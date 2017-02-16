clc
clear all;
close all;

original=imread('/Users/hanahouse/Desktop/original_image.bmp');
mask=imread('/Users/hanahouse/Desktop/mask_image.bmp');
distorted=imread('/Users/hanahouse/Desktop/distorted_image.bmp');

%% masked pixels index (rows, cols)
inds=find(mask==255);
%num_inds = size(inds)(1);
[rows,cols]=ind2sub(size(mask),inds);
r_img=double(distorted(:,:,1));

%% parameters_Gibbs_sampler
M = 20;
sweep = 1:M;
%beta_min = 0.001;
%beta_max = 0.02;
%step = nthroot(beta_max/beta_min,sweep);

%% parameters_PDE_diffusion
N = 70;
iter = 1:N;
%alpha = 0.2;
%step = 0.98;

err_1 = zeros(1,M);
err_2 = zeros(1,N);

Case = 2;
switch Case
    %% Gibbs Sampler
    case 1
        for i = 1:M
            err_1(i) = Gibbs(i,original,rows,cols,r_img);
        end
        figure
        plot(sweep, err_1)
        title('Gibbs Sampler: Per Pixel Error Over Number of Sweeps')
        xlabel('number of sweeps')
        ylabel('per pixel error')
        
    %% PDE    
    case 2
        for j = 1:N
            err_2(j) = PDE(j,original,rows,cols,r_img);
        end
        figure
        plot(iter, err_2)
        title('PDE Diffusion: Per Pixel Error Over Number of Iterations')
        xlabel('number of sweeps')
        ylabel('per pixel error')
        
end
