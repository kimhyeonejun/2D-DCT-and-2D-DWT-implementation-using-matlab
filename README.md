# An implmentation of 2D DCT and 2D DWT transform
This is my implementation of 2D-DCT and 2D-DWT. <br>
**1. 2D DCT** <br>
I first apply 2D DCT to image. Then, zigzag scan is used for scanning all DCT coefficients. After applying zero-padding, I used inverse 2D DCT to restore the image. Below are images that represent the original image, zero-padded 2D DCT transformed image, recovered image, respectively. Zigzag scan is describe as below. <br>
![image](https://github.com/kimhyeonejun/2D-DCT-and-2D-DWT-implementation-using-matlab/assets/103301952/ab1eb1a9-a442-4e82-b288-5ba366efb3e5) <br>

The result is given for two cases, with noise and without noise.
![image](https://github.com/kimhyeonejun/2D-DCT-and-2D-DWT-implementation-using-matlab/assets/103301952/4964878e-25f2-43ea-ba5e-b3c89c95b5b5)

**2. 2D DWT** <br>
Now, I apply 2D DWT to image. This time, zero padding is applied for a quater of the whole image located in down-right corner. After applying zero-padding, I used inverse 2D DWT to restore the image. Below are images that represent the original image, zero-padded 2D DWT transformed image, recovered image, respectively. <br>

The result is given for two cases, with noise and without noise.
![image](https://github.com/kimhyeonejun/2D-DCT-and-2D-DWT-implementation-using-matlab/assets/103301952/94892cb4-5a7a-4447-9b0e-c94b697fb6b4)
