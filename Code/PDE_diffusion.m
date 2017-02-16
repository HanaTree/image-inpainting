clear

original_img=imread('/Users/hanahouse/Desktop/original_image.bmp');
mask_img=imread('/Users/hanahouse/Desktop/mask_image.bmp');
distorted_img=imread('/Users/hanahouse/Desktop/distorted_image.bmp');

%masked pixels index (rows, cols)
inds=find(mask_img==255);
[rows,cols]=ind2sub(size(mask_img),inds);
r_img=double(distorted_img(:,:,1));

%parameters
sweep_iter=50;
alpha=0.2;
step=0.98;

%QDE solver, red channel
for i=1:sweep_iter
    for j=1:length(rows)
        y=rows(j);
        x=cols(j);
        sec_grad=r_img(y-1,x)+r_img(y+1,x)+r_img(y,x-1)+r_img(y,x+1)-4*r_img(y,x);
        r_img(y,x)=r_img(y,x)+alpha*sec_grad;
    end
    alpha=alpha*step;
end

construct_img=original_img;
construct_img(:,:,1)=uint8(r_img);
imshow(construct_img);

Err = check_Err(construct_img,original_img,rows,cols);