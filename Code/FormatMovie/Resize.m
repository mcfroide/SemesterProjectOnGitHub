clear all;
close all;

addpath('../')
OriginalImage=rgb2gray(imread('Victorian_Street_Lamp.jpg'));

%I = imread('rice.png');
J = imresize(OriginalImage, 0.25);
figure, imshow(OriginalImage), figure, imshow(J)