function X=CreateTensorX(P0,P)
    K=length(P)+1;
    Ni=size(P0,1);
    Nj=size(P0,2);
    X=tensor(rand(Ni,Nj,K));

    sumP=0;
    for i=1:K-1
        X(:,:,i+1)=P{i};
        sumP=sumP+P{i};
    end
    X(:,:,1)=P0.*(P0>=0)+1/(K-1)*sumP.*(P0<0);

return