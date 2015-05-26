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

load('Movies/Facade.mat'); 
RecoveredImage=CorruptedImage;
s=size(CorruptedImage);
Mrows=s(1);
Mcols=s(2);
Mframe=1;
 
K=10;
N=4;
 
R1=N; R2=N; R3=3;
 
sigma=1e-2; itMax=60; sigmaIterative=5e-6;
nbNeighbours=-1; % Nb of nearest previously recovered and corrupted future frames used in the tensor building step
% % Set to -1 to use all frames
 
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
    [Coordinates]=SortAllP0Tensor(N,CorruptedImage);
    nbIt=length(Coordinates);
    
    for n=1:nbIt
        Coordinates=ReSortP0(Coordinates, n, RecoveredImage,N);
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
    
    %figure(3)
    %imshow(RecoveredImage, [-1,256]);
    
    beep
    
    figure
    subplot(2,2,1)
    imshow(OriginalImage, [-1,256]);
    subplot(2,2,2)
    imshow(CorruptedImage, [-1,256]);
    subplot(2,2,3:4)
    imshow(RecoveredImage, [-1,256]);
    filename=['../Results/InpaintingFacadeN',num2str(N),'.fig'];
    %savefig(filename);

%     load('InPainting2.mat')
%     
%     figure
%     subplot(2,2,1)
%     imshow(OriginalImage, [-1,256]);
%     subplot(2,2,2)
%     imshow(CorruptedImage, [-1,256]);
%     subplot(2,2,3)
%     imshow(RecoveredImage, [-1,256]);
%     
filename=['../Results/InpaintingFacadeN',num2str(N),'.mat'];
%save(filename,'OriginalImage','CorruptedImage','RecoveredImage');

