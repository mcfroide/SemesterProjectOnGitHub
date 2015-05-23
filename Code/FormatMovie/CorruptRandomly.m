function PCorrupted=CorruptRandomly(P,n,fraction)
% P is the movie stored as a tensor
% n is the half-size of the Macro-Block
% fraction is the fraction of image pixels to corrupt

s=size(P);

Ni=s(1);
Nj=s(2);
K=s(3);

PCorrupted=P;
nbBlocksPerColumn=floor(Ni/n);
nbBlocksPerRow=floor(Nj/n);
nbBlocks=nbBlocksPerColumn*nbBlocksPerRow;
nbCorruptedBlocks=round(fraction*nbBlocks);

for k=1:K
    CorruptedFrame=double(PCorrupted(:,:,k));
    R=randperm(nbBlocks,nbCorruptedBlocks);
    r=floor((R-1)/nbBlocksPerRow)*n+1;
    c=((R-1)-nbBlocksPerRow*(r-1)/n)*n+1;

    for i=1:length(r)
         CorruptedFrame(r(i):r(i)+n-1,c(i):c(i)+n-1)=-1;
    end
    PCorrupted(:,:,k)=CorruptedFrame;
end

return