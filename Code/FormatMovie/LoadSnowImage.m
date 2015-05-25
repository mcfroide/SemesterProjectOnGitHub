clear all;
close all;
% http://images.forwallpaper.com/files/images/0/0249/0249d4f1/113975/winter-park-snow-bench.jpg

%I=rgb2gray(imread('../../Parc-du-Cinquantenaire-snow.jpg'));
% 
% J=imresize(I,0.2);
% [n,m]=size(J);
% 
% K=J(round(n/5):round(4.5*n/5),round(m/15):end);
% imshow(K)


I=rgb2gray(imread('../../winter-park-snow-bench.jpg'));

J=imresize(I,0.3);
[n,m]=size(J);

K=double(J);%(round(n/5):round(4.5*n/5),round(m/15):end);
OriginalImage=K;

K(248:316,75:113)=-1;
K(270:316,110:149)=-1;
K(306:316, 25:75)=-1;
K(295:316, 143:155)=-1;
figure
imshow(K,[-1,256])
%figure
%imshow(J)

CorruptedImage=K;

filename='../Movies/EraseBank.mat';
save(filename,'CorruptedImage', 'OriginalImage');