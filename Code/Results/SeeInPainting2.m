clear all;

load('../Movies/EraseBank.mat');
load('InPainting2.mat');
figure
subplot(2,2,1)
imshow(OriginalImage, [-1,256]);
subplot(2,2,2)
imshow(CorruptedImage, [-1,256]);
subplot(2,2,3)
imshow(RecoveredImage, [-1,256]);

