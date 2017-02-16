clear

original_img=imread('/Users/hanahouse/Desktop/original_image.bmp');
mask_img=imread('/Users/hanahouse/Desktop/mask_image.bmp');
distorted_img=imread('/Users/hanahouse/Desktop/distorted_image.bmp');

%masked pixels index (rows, cols)
inds=find(mask_img==255);
[rows,cols]=ind2sub(size(mask_img),inds);
r_img=double(distorted_img(:,:,1));

%parameters
sweep_iter=20;
beta_min=0.001; 
beta_max=0.02;
step=nthroot(beta_max/beta_min,sweep_iter);

%Gibbs sampler, red channel
errors=zeros(1,sweep_iter);

beta_i=beta_min;
for i=1:(sweep_iter+1)
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

construct_img=original_img;
construct_img(:,:,1)=uint8(r_img);

Err = check_Err(construct_img,original_img,rows,cols);

imshow(construct_img);