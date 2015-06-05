function [P0_new,err]=RecoverSubBlock(Movie,P0, K, R1, R2, R3, sigma, sigmaIterative, itMax, iFrame, nbNeighbours)
% Returns a completed version of P0, computed using the Alteranting Least Square algorithm

% Select (at most) K-1 MBs similar to P0 on its set of known pixels
[P,~]=SelectMBsTensor(Movie,K,P0, iFrame, nbNeighbours);

% Create inital tensor from the set of selested MBs
X=CreateTensorX(P0,P);

% % Display P0 together with the initial guess
% figure
% subplot(2,3,1)
% imshow(P0)
% subplot(2,3,2)
% imshow(double(X(:,:,1)))

normX=norm(X);

% Keff might be smaller than K if not enough matching MBs have been
% selected
Keff=size(X,3);

% N is the size of the square MBs
N=size(P0,1);
%Random initialisation of 3 vectors Ai, of respective size NxR1, NxR2,
%KeffxR3
A=InitializeA(N,Keff, R1, R2, R3);

% First iteration of low-rank approximation of X
[Xl, A_new]=ComputeXl(A,X);

i=0;
err(1)=norm(Xl-X)/normX;
diffErr=1000;
% Iterate until convergence, at least 2 iterations
while err(end)>sigma && i<itMax && (diffErr>sigmaIterative || i<2)
    [Xl,A_new]=ComputeXl(A_new,X);
    i=i+1;
    err(end+1)=norm(Xl-X)/normX;
    diffErr=err(end-1)-err(end);
end

% Complete unknown pixels of P0 with results of Xl
P0_new=P0.*(P0>=0)+double(Xl(:,:,1)).*(P0<0);


if i>=itMax
    disp(['Tolerance ', num2str(sigma), ' not reached in ', num2str(itMax),' iterations.']);
end

% % Display result and error graph
% subplot(2,3,3)
% imshow(double(P0_new))
% subplot(2,3,4:6)
% plot(err);
% set(gca,'XTick',1:length(err));
% hold on;
% grid on;
% xlabel('Iteration');
% ylabel('Relative Error on X_L');
% pause
 return