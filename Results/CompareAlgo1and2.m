clear all;
close all;

load '../Results/ComparisonBusAlgo2ReducedRank.mat';

mov2=RecoveredMovie;
err2=ErrorFro;

clear RecoveredMovie ErrorFro

load '../Results/ComparisonBusAlgo1.mat';


mov1=RecoveredMovie;
err1=ErrorFro;

clear RecoveredMovie ErrorFro
% 
% itMax=15;
 goodFrames=[2,3,6,15]
% figure
% plot(goodFrames,err1(goodFrames))
% hold on;
% plot(goodFrames, err2(goodFrames))
% xlabel('Iteration')
% ylabel('Relative error in whole frame');
% legend('ALS', 'GeomCG')
% 
for i=1:length(err2)
diff(i)=norm(mov1(:,:,i)-mov2(:,:,i))/norm(mov1(:,:,i));

end

 figure
 plot(goodFrames,diff(goodFrames),'--*')
%  hold on;
% plot(goodFrames, err2(goodFrames))
% xlabel('Iteration')
% ylabel('Relative error in whole frame');
% legend('ALS', 'GeomCG')
% 
% figure
% for k=1:15
%    subplot(1,2,1)
%    imshow(double(mov1(:,:,k)))
%    title('ALS')
%    subplot(1,2,2)
%    imshow(double(mov2(:,:,k)))
%    title('GeomCG')
%    drawnow
%    
%    pause
%     
% end