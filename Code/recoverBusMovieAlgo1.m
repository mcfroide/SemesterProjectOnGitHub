clear all;
close all;
display('--- Algo 1: ALS ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Missing pixels are marked with -1.
%
%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./ALS/');

N=8; % Size of the Macro-Block

p=15;
filename=['Movies/BusCorruptedMovieN8p',num2str(p),'.mat'];
load(filename);

RecoveredMovie=CorruptedMovie;

s=size(OriginalMovie);
Mrows=s(1);
Mcols=s(2);
Mframe=s(3);

R1=N; R2=N; R3=3;

sigma=1e-2; itMax=60; sigmaIterative=5e-6;
nbNeighbours=5; % Nb of nearest previously recovered and corrupted future frames used in the tensor building step
% Set to -1 to use all frames

K=2*nbNeighbours+1; % This is equal to the number of reference frames from which to choose the patches similar to P0

nFrame_=1:100;
lengthNFrame_=length(nFrame_);

ErrorFro=zeros(lengthNFrame_, 1);

for iFrame=1:lengthNFrame_
    disp(['---- Frame ', num2str(iFrame),' out of ', num2str(lengthNFrame_),' ----']);
    nFrame=nFrame_(iFrame);
    Frame=double(RecoveredMovie(:, :, nFrame));
    [Coordinates]=SortAllP0Tensor(N,Frame);
    nbIt=length(Coordinates);
    
    for n=1:nbIt
        if (mod(n,50)==1)
            display(['Iteration ',num2str(n),' out of ', num2str(nbIt)]);
        end
        i=Coordinates(n,1);
        j=Coordinates(n,2);
        
        P0=Frame(i:i+N-1, j:j+N-1);
        
        if min(min(P0))<0
            if max(max(P0))<0
                Coordinates=ReSortP0(Coordinates, n, Frame,N);
                i=Coordinates(n,1);
                j=Coordinates(n,1);
                P0=Frame(i:i+N-1, j:j+N-1);
            end
            
            [P0_new, ~]=RecoverSubBlockTensor(RecoveredMovie,P0, K, R1, R2, R3, sigma, sigmaIterative, itMax,nFrame, nbNeighbours);
            RecoveredMovie(i:i+N-1, j:j+N-1,nFrame)=P0_new;
            Frame(i:i+N-1, j:j+N-1)=P0_new;
        end
    end
    OriginalFrame=double(OriginalMovie(:,:,iFrame));
end

filename=['../Results/recoverBusMovieN8.mat'];
save(filename,'CorruptedMovie', 'RecoveredMovie');

writerObj = VideoWriter('../Presentation/recoveredBusN8.avi'); %'FrameRate',20
open(writerObj);

fh=figure
Frame=double(RecoveredMovie(:,:,1));
corruptedFrame=double(CorruptedMovie(:,:,1));
subplot(1,2,1)
imshow(corruptedFrame)
subplot(1,2,2)
imshow(Frame);
print  -dpng '../Presentation/myposter.png'
axis tight
set(gca,'nextplot','replacechildren');

for i = 2:lengthNFrame_
    Frame=double(RecoveredMovie(:,:,i));
    corruptedFrame=double(CorruptedMovie(:,:,i));
    subplot(1,2,1)
    imshow(corruptedFrame)
    subplot(1,2,2)
    imshow(Frame);
    frame = getframe(fh);
    writeVideo(writerObj,frame);
end

close(writerObj);


% filename=['../Results/recoverBusMovie.mat'];
% save(filename,'CorruptedMovie', 'RecoveredMovie');
% 
% writerObj = VideoWriter('../Presentation/recoveredBus.avi'); %'FrameRate',20
% open(writerObj);
% 
% figure
% Frame=double(RecoveredMovie(:,:,1));
% imshow(Frame);
% print  -dpng '../Presentation/myrecoveredposter.png'
% axis tight
% set(gca,'nextplot','replacechildren');
% 
% for i = 2:lengthNFrame_
%     Frame=double(RecoveredMovie(:,:,i));
%     imshow(Frame);
%     frame = getframe;
%     writeVideo(writerObj,frame);
% end
% 
% close(writerObj);
% 
% 
% writerObj = VideoWriter('../Presentation/corruptedBus.avi'); %'FrameRate',20
% open(writerObj);
% 
% figure
% corruptedFrame=double(CorruptedMovie(:,:,1));
% imshow(corruptedFrame);
% print  -dpng '../Presentation/mycorruptedposter.png'
% axis tight
% set(gca,'nextplot','replacechildren');
% 
% for i = 2:lengthNFrame_
%     corruptedFrame=double(CorruptedMovie(:,:,i));
%     imshow(corruptedFrame);
%     frame = getframe;
%     writeVideo(writerObj,frame);
% end
% 
% close(writerObj);

