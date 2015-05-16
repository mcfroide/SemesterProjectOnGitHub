clear all;
%clearvars;
close all;
display('--- Inpainting ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Missing pixels are marked with -1.
%
%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./ALS/');
addpath('../');


OriginalImage=rgb2gray(imread('Victorian_Street_Lamp.jpg'));
%OriginalImage = imresize(OriginalImage, 0.25);

%imshow(OriginalImage)
%imshow(OriginalImage);

CorruptedImage=double(OriginalImage);%double(OriginalImage);
%CorruptedImage=(CorruptedImage);

%size(Image)
CorruptedImage(170:1750,500:528)=-1;
CorruptedImage(290:250,485:533)=-1;
CorruptedImage(250:300,475:553)=-1;
CorruptedImage(300:350,450:580)=-1;
CorruptedImage(350:400,400:630)=-1;
CorruptedImage(400:500,430:603)=-1;
CorruptedImage(500:600,450:575)=-1;
CorruptedImage(600:720,480:555)=-1;
CorruptedImage(690:710,555:670)=-1;
CorruptedImage(720:1350,490:540)=-1;
CorruptedImage(1350:1650,460:550)=-1;
CorruptedImage(1350:1750,430:570)=-1;

%CorruptedImage = imresize(CorruptedImage, 0.25);
%OriginalImage = imresize(OriginalImage, 0.25);




%CorruptedImage(170:1750,500:520)=-1;
%CorruptedImage(49:63,121:133)=-1;
%CorruptedImage(63:75,475:553)=-1;
%CorruptedImage(300:350,450:580)=-1;
%CorruptedImage(350:400,400:630)=-1;
%CorruptedImage(400:500,430:603)=-1;
%CorruptedImage(500:600,450:575)=-1;
%CorruptedImage(600:720,480:555)=-1;
% CorruptedImage(690:710,555:670)=-1;
% CorruptedImage(720:1350,490:540)=-1;
% CorruptedImage(1350:1650,460:550)=-1;
% CorruptedImage(1350:1750,430:570)=-1;

figure(2)
imshow(CorruptedImage,[-1,256]);

RecoveredImage=CorruptedImage;

N=8; % Size of the Macro-Block
% 
% % % ****** To work on a "new" movie ***********
% % load BusMovie.mat
% % 
% % OriginalMovie=mov(N+1:floor(200/N)*N,1:floor(240/N)*N,1:40); % For speed
% % 
% % fraction=0.15;
% % CorruptedMovie=CorruptRandomly(OriginalMovie,N/2,fraction);
% % RecoveredMovie=CorruptedMovie;
% 
% load BusCorruptedMovie015.mat
% 
% RecoveredMovie=CorruptedMovie;
% 
s=size(OriginalImage);
Mrows=s(1);
Mcols=s(2);
Mframe=1;
 
K=10;
% 
R1=N; R2=N; R3=3;
% 
sigma=1e-2; itMax=20; sigmaIterative=5e-6;
nbNeighbours=-1; % Nb of nearest previously recovered and corrupted future frames used in the tensor building step
% % Set to -1 to use all frames
% 
 nFrame=1;
 %lengthNFrame_=length(nFrame_);
% 
% ErrorFro=zeros(lengthNFrame_, 1);
% PSNR=zeros(lengthNFrame_, 1);
% 
%for iFrame=1:lengthNFrame_
    %disp(['---- Frame ', num2str(iFrame),' out of ', num2str(lengthNFrame_),' ----']);
    %nFrame=nFrame_(iFrame);
    %Frame=double(RecoveredMovie(:, :, nFrame));
    RecoveredMovie=tensor;
    RecoveredMovie(:,:,1)=RecoveredImage;
    [Coordinates]=SortAllP0Tensor(CorruptedImage,N,CorruptedImage);
    nbIt=length(Coordinates);
    
    for n=1:30%nbIt
        if (mod(n,10)==0)
            display(['Iteration ',num2str(n),' out of ', num2str(nbIt)]);
        end
        i=Coordinates(n,1);
        j=Coordinates(n,2);
        
        P0=RecoveredImage(i:i+N-1, j:j+N-1);
        
        if min(min(P0))<0
            if max(max(P0))<0
                Coordinates=ReSortP0(Coordinates, n, RecoveredImage,N);
                i=Coordinates(n,1);
                j=Coordinates(n,1);
                P0=RecoveredImage(i:i+N-1, j:j+N-1);
            end
            
            [P0_new, err]=RecoverSubBlockTensor(RecoveredMovie,P0, K, R1, R2, R3, sigma, sigmaIterative, itMax,nFrame, nbNeighbours);
            RecoveredMovie(i:i+N-1, j:j+N-1,1)=P0_new;
            RecoveredImage(i:i+N-1, j:j+N-1)=P0_new;
        end
    end
    
    figure(3)
    imshow(RecoveredImage, [-1,256])
    
   % save('InPainting.mat','RecoveredImage', 'Coordinates');
%     OriginalFrame=double(OriginalMovie(:,:,iFrame));
%     
%     ErrorFro(iFrame)=FrobeniusRelativeError(OriginalFrame, Frame);
%     PSNR(iFrame)=psnr(Frame, OriginalFrame);
%     
%     %S=svd(Frame);
%     %SVErrorEstimate=SingularValueErrorEstimate(Frame, R3);
% 
% 
% 
% filename=['Algo1_Bus_N',num2str(N), '.mat'];
% save(filename, 'ErrorFro', 'PSNR', 'RecoveredMovie');
% 
% 
% figure
% %plot(nFrame_,PSNR, '-*r');
% %hold on;
% plot(nFrame_,ErrorFro*100, '--*b');
% xlabel('Frame index');
% ylabel('Relative error (Frobenius norm)');
% %legend('PSNR (dB)','||A_{restored}-A||_F/||A||_F (%)');
% 
