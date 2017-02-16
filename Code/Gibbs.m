function [ Err ] = Gibbs(sweep,original,rows,cols,r_img)

%parameters
%sweep_iter=20;
beta_min=0.001;
beta_max=0.02;
step=nthroot(beta_max/beta_min,sweep);

%Gibbs sampler, red channel
%errors=zeros(1,sweep);

beta_i=beta_min;
for i=1:(sweep+1)
    for j=1:length(rows)
        y=rows(j);
        x=cols(j);
        Ix_val=0.5*(r_img(y,x-1)+r_img(y,x+1));
        Iy_val=0.5*(r_img(y-1,x)+r_img(y+1,x));

        dx=Ix_val-(0:255);
        dy=Iy_val-(0:255);
        pdf=exp(-beta_i.*((dx).^2+(dy).^2));
        cdf=cumsum(pdf);
        I_val=find(cdf>cdf(end)*rand(),1)-1;
        r_img(y,x)=I_val;
    end
    beta_i=beta_i*step;
end

restored=original;
restored(:,:,1)=uint8(r_img);

Err = check_Err(restored,original,rows,cols);
%imshow(restored);
end