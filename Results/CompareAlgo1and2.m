clear all;
%close all;

%load '../Results/ComparisonBusAlgo2ReducedRank.mat';
load 'ALS_NN1.mat';

mov1=RecoveredMovie;
err1=ErrorFrame;

clear RecoveredMovie ErrorFrame

%load '../Results/ComparisonBusAlgo1.mat';
load 'GeomCG_NN1.mat';

mov2=RecoveredMovie;
err2=ErrorFrame;

clear RecoveredMovie ErrorFrame

load 'Algo1_Bus_N16p15Final.mat';

green=[0, 0.7, 0];

 figure
 plot(1:length(err1),err1,'-sqb')
  hold on;
 plot(1:length(err2),err2,'-*r')
 plot(1:length(err2),ErrorFrame,'--o','color', green)
 legend('ALS, r=[16,16,1]','GeomCG, r=[16,16,1]', 'ALS, r=[16,16,3]');
% plot(goodFrames, err2(goodFrames))
 xlabel('Frame index')
 ylabel('Relative error on reconstructed MBs');
 
 

filename=['../Code/Movies/BusCorruptedMovieN16p15.mat'];
load(filename);



 figure
 subplot(2,2,1)
 imshow(double(OriginalMovie(:,:,20)));
 title('Original');
 subplot(2,2,2)
 imshow(double(CorruptedMovie(:,:,20)));
 title('Corrupted')
 subplot(2,2,3)
 imshow(double(mov1(:,:,20)));
 title('ALS')
 subplot(2,2,4)
 imshow(double(mov2(:,:,20)));
 title('GeomCG')

