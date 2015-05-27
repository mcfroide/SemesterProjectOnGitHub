clear all;
close all;

load '../Results/ComparisonBusAlgo2.mat';

mov2=RecoveredMovie;
err2=ErrorFro;

clear RecoveredMovie ErrorFro

load '../Results/ComparisonBusAlgo1.mat';


mov1=RecoveredMovie;
err1=ErrorFro;

clear RecoveredMovie ErrorFro

% figure
% plot(err1)
% hold on;
% plot(err2)
% xlabel('Iteration')
% ylabel('Relative error in whole frame');
% legend('ALS', 'GeomCG')



figure
for k=1:30
   subplot(1,2,1)
   imshow(double(mov1(:,:,k)))
   subplot(1,2,2)
   imshow(double(mov2(:,:,k)))
   drawnow
   
   pause
    
end