clear all;
close all;
clc;

load('../Movies/BusMovie.mat');
s=size(mov);

figure
subplot(2,2,1)
imshow(double(mov(:,:,1)))

J = imresize(double(mov(:,:,1)), 0.5);

resizedMov=tensor;

for k=1:100
    J = imresize(double(mov(:,:,k)), 0.80);
    resizedMov(:,:,k)=J;
    %figure, imshow(OriginalImage), figure, imshow(J)
end

subplot(2,2,2)
imshow(double(resizedMov(:,:,1)))

resizedCropedMov=resizedMov(10:160, 15:210,:);

subplot(2,2,4)
imshow(double(resizedCropedMov(:,:,1)))

cropedMov=mov(10:160, 15:210,1:100);

subplot(2,2,3)
imshow(double(cropedMov(:,:,1)))

figure
for i=1:100
    imshow(double(resizedCropedMov(:,:,i)));
    drawnow; 
end

%mov=resizedCropedMov;
%save('../Movies/BusResizedCropedMovie.mat','mov');