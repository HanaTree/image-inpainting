function [ Err ] = PDE(iter,original,rows,cols,r_img)

%parameters
%sweep_iter=50;
alpha=0.2;
step=0.98;

%QDE solver, red channel
for i=1:iter
    for j=1:length(rows)
        y=rows(j);
        x=cols(j);
        sec_grad=r_img(y-1,x)+r_img(y+1,x)+r_img(y,x-1)+r_img(y,x+1)-4*r_img(y,x);
        r_img(y,x)=r_img(y,x)+alpha*sec_grad;
    end
    alpha=alpha*step;
end

restored=original;
restored(:,:,1)=uint8(r_img);

%imshow(restored);
Err = check_Err(restored,original,rows,cols);
end