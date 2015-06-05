clear all;
close all;
% http://www.briqueterie-chimot.fr/wpcproduct/la-brique-rouge-chimot/

I=rgb2gray(imread('../../facade-rouge.jpg'));

J=imresize(I,0.6);
[n,m]=size(J);

K=double(J);%(round(n/5):round(4.5*n/5),round(m/15):end);
OriginalImage=K;

K(152:202,340:450)=-1;
 
figure
imshow(K,[-1,256])

CorruptedImage=K;

filename='../Movies/Facade.mat';
%save(filename,'CorruptedImage', 'OriginalImage');