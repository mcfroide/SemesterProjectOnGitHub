function [Xl, A_new]=ComputeXl(A, X)
% A is a cell of 3 vectors, respectively of size NxR1, NxR2, KxR3
% X is a 3D tensor of size NxNxK, for which we seek a rank [R1,R2,R3]
% approximation.

K=size(X,3);
A_new=A;

% Wanted rank of Xl
R=cell(3,1);

% Enforce most important eigenvector in mode-3 to a constant vector of l2-norm 1.
A_new{3}(:,1)=1/K*ones(K,1);

% Loop over the 3 dimensions
for i=1:3
    R{i}=size(A_new{i},2);
    Y=X;
    for j=1:3
        if j~=i
            Y=ttm(Y,A_new{j}',j);
        end
    end
    
    % Unfold Y in mode i
    Yi=tenmat(Y,i);
    [Q,~,~]=svd(Yi.data);
    % Construct Ai with the first Ri principal components of Yi
    A_new{i}=Q(:,1:R{i});
end

% Compute core tensor of size R1xR2xR3
G=ttm(X,{A_new{1}',A_new{2}',A_new{3}'});
% Compute Xl, a low rank approximation of X
Xl=ttm(G,{A_new{1},A_new{2},A_new{3}});
return
