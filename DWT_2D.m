clc;    
clear; 
close all;

img = imread('0884_1.png');

img = rgb2gray(img);
noise_img = imnoise(img,"salt & pepper", 0.3); % noise 추가
img_double = double(img);
noise_img_double = double(noise_img);

wname = 'haar'; % Specify the wavelet type, e.g., 'haar', 'db1', etc.
[cA, cH, cV, cD] = dwt2(img_double, wname);
[cA_noise, cH_noise, cV_noise, cD_noise] = dwt2(noise_img_double, wname);

cA_norm = cA / 255;
cH_norm = cH / 255;
cV_norm = cV / 255;
cD_norm = cD / 255;

cA_norm_noise = cA_noise / 255;
cH_norm_noise = cH_noise / 255; 
cV_norm_noise = cV_noise / 255;
cD_norm_noise = cD_noise / 255;

% Create an image to display all coefficients together
[m, n] = size(cA_norm); 
combined_image = zeros(2*m, 2*n); 
combined_image_noise = zeros(2*m, 2*n);


combined_image(1:m, 1:n) = cA_norm;         
combined_image(1:m, n+1:2*n) = cH_norm;     
combined_image(m+1:2*m, 1:n) = cV_norm;     
combined_image(m+1:2*m, n+1:2*n) = cD_norm; % 
combined_image_noise_made(1:m, 1:n) = cA_norm_noise;         
combined_image_noise_made(1:m, n+1:2*n) = cH_norm_noise;    
combined_image_noise_made(m+1:2*m, 1:n) = cV_norm_noise;     
combined_image_noise_made(m+1:2*m, n+1:2*n) = zeros(m, n); 

combined_image_made = mat2zigzag(combined_image);
cA_norm = combined_image_made(1:m, 1:n);        
cH_norm = combined_image_made(1:m, n+1:2*n);     
cV_norm = combined_image_made(m+1:2*m, 1:n);     
cD_norm = combined_image_made(m+1:2*m, n+1:2*n);


reconstructed_img = idwt2(cA_norm, cH_norm, cV_norm, cD_norm, wname);
reconstructed_img_noise = idwt2(cA_norm_noise, cH_norm_noise, cV_norm_noise, cD_norm_noise, wname);

% Display results
total_img = {img, combined_image_made, reconstructed_img, noise_img, combined_image_noise_made, reconstructed_img_noise};
figure;
montage(total_img,'Size', [2 3]);
title('img - filter - filtered img');
function output = mat2zigzag(matrix)
    [rows, cols] = size(matrix);
    output = zeros(rows, cols);
    k = 0;
    for i = 1 : cols - 1
        for height = 1 : k+1
            output(height, k+2 - height) = matrix(height, k+2-height);
        end
        if i > cols
            k = k - 1;
        elseif i == cols
            k = cols;
        else
            k = k + 1;
        end
    end
end
