function X=CreateTensorX(P0,P)
% P0 is the MB which needs to be completed. It is of size NixNj.
% P is a stack of MBs which are similar to P0 on its set of known pixels.
% P contains K-1 MBs of size NixNj.
% This function groups a first approximation of P0 with all MBs from P. 

K=length(P)+1;
Ni=size(P0,1);
Nj=size(P0,2);

%Random initialization of 
X=tensor(rand(Ni,Nj,K));

sumP=0;
for i=1:K-1
    X(:,:,i+1)=P{i};
    sumP=sumP+P{i};
end
% First frame of X is set to P0. Unknown pixels are approximated by the
% mean over all MBs in P
X(:,:,1)=P0.*(P0>=0)+1/(K-1)*sumP.*(P0<0);

% *** Random completion of unknown pixels leads to bad results ***
%X(:,:,1)=P0.*(P0>=0)+rand(Ni,Nj).*(P0<0);

return