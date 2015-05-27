clear all;
%clearvars;
close all;
display('--- Algo 2: GeomCG ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Missing pixels are marked with -1.
%
%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./geomCG/');
addpath('./ALS/');

N=16; % Size of the Macro-Block

% % ****** To work on a "new" movie ***********
% load BusMovie.mat
%
% OriginalMovie=mov(N+1:floor(200/N)*N,1:floor(240/N)*N,1:40); % For speed
%
% fraction=0.15;
% CorruptedMovie=CorruptRandomly(OriginalMovie,N/2,fraction);
% RecoveredMovie=CorruptedMovie;

%load BusCorruptedMovie015.mat
%load BusCorrupted&CropedMovieN16p015.mat
p=15;
filename=['Movies/BusCorruptedMovieN16p',num2str(p),'.mat'];
load(filename);


RecoveredMovie=CorruptedMovie;

s=size(OriginalMovie);
Mrows=s(1);
Mcols=s(2);
Mframe=s(3);
n = [Mrows Mcols Mframe];

K=11;

R1=N/2; R2=N/2; R3=1;
r = [R1, R2, R3];

opts = struct( 'maxiter', 60, 'tol', 1e-6, 'verbose', false );


%sigma=1e-2; itMax=60; sigmaIterative=5e-6;
nbNeighbours=5; % Nb of nearest previously recovered and corrupted future frames used in the tensor building step
% Set to -1 to use all frames

nFrame_=1:6;
lengthNFrame_=length(nFrame_);

ErrorFro=zeros(lengthNFrame_, 1);
PSNR=zeros(lengthNFrame_, 1);

for iFrame=1:lengthNFrame_
    disp(['---- Frame ', num2str(iFrame),' out of ', num2str(lengthNFrame_),' ----']);
    nFrame=nFrame_(iFrame);
    Frame=double(RecoveredMovie(:, :, nFrame));
    [Coordinates]=SortAllP0Tensor(N,Frame);
    nbIt=length(Coordinates);
    
    for n=1:nbIt
        if (mod(n,20)==1)
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
            
            [P,~]=SelectMBsTensor(RecoveredMovie,K,P0, nFrame, nbNeighbours);
            X=CreateTensorX(P0,P);
            XSparse=CreateXSparse(P0,X);
            
            %[Xl, A_new]=ComputeXl(A,X);
            %XInit=ttensor(Xl);
            KEff=size(X,3);
            if KEff<3
                KEff
                pause
            end
            %A=InitializeA(N,KEff, R1, R2, R3);
            %G=ttm(X,{A{1}',A{2}',A{3}'});
            %XInit=ttensor(G, A);
            
            XInit=makeRandTensor([N,N,KEff],r);
           
            [resX, ~, ~] = geomCG( XSparse, XInit, [], opts);
            resX=double(resX);
            P0_new=resX(:,:,1);
            %min(min(P0_new))
            %pause
            %[P0_new, err]=RecoverSubBlockTensor(RecoveredMovie,P0, K, R1, R2, R3, sigma, sigmaIterative, itMax,nFrame, nbNeighbours);
                        % Copy only pixels which are not part of Omega
            P0_new(P0>=0)=P0(P0>=0);
            RecoveredMovie(i:i+N-1, j:j+N-1,nFrame)=P0_new;
            Frame(i:i+N-1, j:j+N-1)=P0_new;
        end
    end
    OriginalFrame=double(OriginalMovie(:,:,nFrame));
    
    ErrorFro(iFrame)=FrobeniusRelativeError(OriginalFrame, Frame);
    %PSNR(iFrame)=psnr(Frame, OriginalFrame);
    
    %S=svd(Frame);
    %SVErrorEstimate=SingularValueErrorEstimate(Frame, R3);
end

filename=['../Results/ComparisonBusAlgo2ReducedRank.mat'];
save(filename, 'ErrorFro','RecoveredMovie'); 

figure
subplot(1,2,1)
imshow(double(RecoveredMovie(:,:,1)))
subplot(1,2,2)
imshow(double(CorruptedMovie(:,:,1)))

%filename=['Algo2_Bus_N',num2str(N), '.mat'];
%save(filename, 'ErrorFro', 'PSNR', 'RecoveredMovie');


figure
%plot(nFrame_,PSNR, '-*r');
%hold on;
plot(nFrame_,ErrorFro*100, '--*b');
xlabel('Frame index');
ylabel('Relative error (Frobenius norm)');
%legend('PSNR (dB)','||A_{restored}-A||_F/||A||_F (%)');

