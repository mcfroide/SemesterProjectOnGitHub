clear all;
close all;
display('--- Algo 1: ALS ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Missing pixels are marked with -1.
%
%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./ALS/');

N=16; % Size of the Macro-Block

p=5;
filename=['Movies/BusCorruptedMovieN16p',num2str(p),'.mat'];
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

K=2*nbNeighbours+1;

nFrame_=1:30;
lengthNFrame_=length(nFrame_);

ErrorFrame=zeros(lengthNFrame_, 1);

for iFrame=1:lengthNFrame_
    disp(['---- Frame ', num2str(iFrame),' out of ', num2str(lengthNFrame_),' ----']);
    nFrame=nFrame_(iFrame);
    Frame=double(RecoveredMovie(:, :, nFrame));
    [Coordinates]=SortAllP0Tensor(N,Frame);
    nbIt=length(Coordinates);
    
    OriginalFrame=double(OriginalMovie(:,:,iFrame));
    ErrorIt=zeros(nbIt,1);
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
            
            P0_orgn=OriginalFrame(i:i+N-1, j:j+N-1);
            ErrorIt(n)=FrobeniusRelativeError(P0_orgn, P0_new);
        end
    end
    ErrorFrame(iFrame)=mean(ErrorIt);
    %ErrorFro(iFrame)=FrobeniusRelativeError(OriginalFrame, Frame);
end

%profile viewer
%profile off

filename=['../Results/Algo1_Bus_N',num2str(N),'p',num2str(p), 'NewError.mat'];
save(filename, 'ErrorFrame', 'RecoveredMovie');

beep

figure(1)
hold on;
plot(nFrame_,ErrorFrame, '--*b');
xlabel('Frame index');
ylabel('Mean relative error');

