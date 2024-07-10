clc;    
clear; 
close all; 

% Load
img = imread('0884_1.png'); % 이미지 불러오기
img = rgb2gray(img);  % grayscale 변환
noise_img = imnoise(img,"salt & pepper", 0.3); % noise 추가

dct_image = dct2(double(img))/255;
dct_noise_image = dct2(double(noise_img))/255;

zigzag_vector = mat2zigzag(dct_image);
zigzag_vector_noise = mat2zigzag(dct_noise_image);

n1 = 2; 
n2 = 8;
original_length = length(zigzag_vector);
new_length1 = ceil(original_length - original_length / n1);
new_length2 = ceil(original_length - original_length / n2);

padded_vector = zeros(1, original_length);
padded_vactor_noise = zeros(1, original_length);
padded_vector(1:new_length1) = zigzag_vector(1:new_length1);
padded_vector_noise(1:new_length2) = zigzag_vector_noise(1:new_length2);

[~, block_size, channel] = size(img);

dct_coefficients = inverse_zigzag(padded_vector, block_size, block_size);
dct_coefficients_noise = inverse_zigzag(padded_vector_noise, block_size, block_size);

reconstructed_image = real(idct2(dct_coefficients));
reconstructed_image_noise = real(idct2(dct_coefficients_noise));
 
total_img = {img, 5.0*log(1+dct_coefficients), reconstructed_image, noise_img, 5.0*log(1+dct_coefficients_noise), reconstructed_image_noise};
figure;
montage(total_img,'Size', [2 3]);
title('img - filter - filtered img');

function output = mat2zigzag(matrix)
    [rows, cols] = size(matrix);
    output = zeros(1, rows*cols);
    cur_row = 1; cur_col = 1; cur_index = 1;
    while cur_row <= rows && cur_col <= cols
        if mod(cur_row + cur_col, 2) == 0
            if cur_col <= cols && cur_row > 0
                output(cur_index) = matrix(cur_row, cur_col);
                cur_index = cur_index + 1;
            end
            if cur_row == 1 || cur_col == cols
                if cur_col == cols
                    cur_row = cur_row + 1;
                else
                    cur_col = cur_col + 1;
                end
            else
                cur_row = cur_row - 1;
                cur_col = cur_col + 1;
            end
        else
            if cur_row <= rows && cur_col > 0
                output(cur_index) = matrix(cur_row, cur_col);
                cur_index = cur_index + 1;
            end
            if cur_col == 1 || cur_row == rows
                if cur_row == rows
                    cur_col = cur_col + 1;
                else
                    cur_row = cur_row + 1;
                end
            else
                cur_row = cur_row + 1;
                cur_col = cur_col - 1;
            end
        end
    end
end

function output = inverse_zigzag(input, rows, cols)
    output = zeros(rows, cols);
    row = 1; col = 1; index = 1;
    elements = numel(input);

    while index <= elements
        if mod(row + col, 2) == 0
            if col <= cols && row > 0
                output(row, col) = input(index);
                index = index + 1;
            end
            if row == 1 || col == cols
                if col == cols
                    row = row + 1;
                else
                    col = col + 1;
                end
            else
                row = row - 1;
                col = col + 1;
            end
        else
            if row <= rows && col > 0
                output(row, col) = input(index);
                index = index + 1;
            end
            if col == 1 || row == rows
                if row == rows
                    col = col + 1;
                else
                    row = row + 1;
                end
            else
                row = row + 1;
                col = col - 1;
            end
        end
    end
end

