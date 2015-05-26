clear all;
close all;

load('InpaintingFacadeN8.mat');

figure
subplot(1,3,1)
imshow(OriginalImage, [-1,256]);
subplot(1,3,2)
imshow(CorruptedImage, [-1,256]);
subplot(1,3,3)
imshow(RecoveredImage, [-1,256]);

filename=['../Presentation/InpaintingFacade.png'];
print(filename, '-dpng');


load('InpaintingSnowN8.mat');

figure
subplot(1,3,1)
imshow(OriginalImage, [-1,256]);
subplot(1,3,2)
imshow(CorruptedImage, [-1,256]);
subplot(1,3,3)
imshow(RecoveredImage, [-1,256]);
%set(gca,'Position',[0 0 0.5 0.5])

filename=['../Presentation/InpaintingSnow.png'];
%print(filename, '-dpng');

