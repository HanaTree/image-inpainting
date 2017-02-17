# image-inpainting

This is a task of image restoration and inpainting with two methods - **Gibbs sampler** and **PDE diffusion**. The original image has (Red, Green, Blue) bands, and the distorted image is created by imposing the mask image on the Red-band of the original image.

The output contains the restored images with both methods and also two plots showing the *per pixel error* over the number of sweeps/iterations of the two methods.
