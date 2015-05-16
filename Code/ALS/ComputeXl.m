function [Xl, A_new]=ComputeXl(A, X)
% Y=tensor;
% G=tensor;
% Xl=tensor;
K=size(X,3);
%N=size(X,1);
A_new=A;

A_new{3}(:,1)=1/K*ones(K,1);
    for i=1:3
        R{i}=size(A_new{i},2);
%         if i~=1
%            Y=ttm(X,A{1}',1); 
%         else
%            Y=ttm(X, A{2}',2);
%         end
        Y=X;
        for j=1:3
            if j~=i
                Y=ttm(Y,A_new{j}',j);  
            end
        end
        
        %Yi=matricize(Y,i);
        %[Q,~,~]=svd(Yi); % svd not qr !!!
        Yi=tenmat(Y,i);
        [Q,~,~]=svd(Yi.data); % svd not qr !!!
        %diag(s)
        A_new{i}=Q(:,1:R{i});
    end
    
    G=ttm(X,{A_new{1}',A_new{2}',A_new{3}'});
    Xl=ttm(G,{A_new{1},A_new{2},A_new{3}});
    
    %A_new=A;
return
