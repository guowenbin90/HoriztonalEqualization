%% restart
close all;
clc;

%% read image
%image = imread('Fig0308(a)(fractured_spine).tif');
image = imread('Fig0309(a)(washed_out_aerial_image).tif');
%image = imread('Fig0316(1)(top_left).tif');

%% Histogram equalization 

[image_height,image_width] = size(image); 

new_image = uint8(zeros(image_height,image_width)); % uint 8 blank canvas

n = image_height*image_width; % number of pixels.

f = zeros(256,1); %Frequency
pdf = zeros(256,1); %density distribution
cum = zeros(256,1);  %cumulative density distribution
Pr = zeros(256,1); %normolized histogram
S = zeros(256,1); %round each pixel


% Calculate the frequency and density
for i = 1:image_height
    for j = 1:image_width
        r = image(i,j);
        f(r+1) = f(r+1)+1;
        pdf(r+1) = f(r+1)/n;
    end
end

sum = 0;
L = 256;

for i = 1:size(pdf)
    sum = sum + f(i);
    cum(i) = sum;
    Pr(i) = cum(i)/n;
    S(i) = round(Pr(i)*(L-1));
end

for i = 1:image_height
    for j = 1:image_width
        new_image(i,j) = S(image(i,j)+1);
    end
end

figure('Name','Histogram Equalization')
subplot(2,3,1);
imshow(image);
title('Original Image');
subplot(2,3,2);
bar(f);
title('Original Bar');
subplot(2,3,3);   
imhist(image);
title('Histogram of original Image');
subplot(2,3,4);
imshow(new_image);
title('Equalized Image');
subplot(2,3,5);
bar(S);
title('Cumulative Bar');
subplot(2,3,6);
imhist(new_image);
title('Histogram of equalized Image');

