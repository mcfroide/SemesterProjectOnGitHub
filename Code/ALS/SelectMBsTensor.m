function [P,S]=SelectMBs(Movie, K, P0, iFrame, nbNeighbours)
% nbNeighbours is th nb of nearest previously recovered and nb of corrupted
% future frames used in the tensor building step. Set it to -1 to use all frames
% K is the maximal nb of MBs to select into P.

sz=size(Movie);
Ni=sz(1); Nj=sz(2); NFrames=sz(3);
N=size(P0,1);
Omega=(P0>=0); % Set of clean pixels
Pi={};
S=[];

if nbNeighbours==-1
    FramesSet=1:NFrames;
else
    m=max(1,iFrame-nbNeighbours);
    M=min(NFrames, iFrame+nbNeighbours);
    FramesSet=m:M;
end

% Norm of P0 in Frobenius norm
normP0=norm(P0.*Omega, 'fro');

for k=FramesSet
    Frame=double(Movie(:, :,k));
    for i=1:N/2:Ni-N+1
        for j=1:N/2:Nj-N+1
            Pij=Frame(i:i+N-1, j:j+N-1);
            if min(min(Pij))<0
                % Pij is not clean, do not store it
            else
                % Store a normalize version of the current MB
                Pij=Pij/norm(Pij.*Omega, 'fro')*normP0;
                Pi{end+1}=Pij; % Store Pij in Pi
                S(end+1)=sum(sum(abs(Omega.*(Pij-P0)))); % Compute its "non-match" with P0
            end
        end
    end
end

[sortedS,I] = sort(S,'ascend'); % sort S with best match on top

k=1;
while (sortedS(k)<=2*sortedS(1) && k<K-1 && k<length(sortedS))
    k=k+1;
    % If not enough similar blocks are available, take less blocks
    % to avoid taking non-similar blocks
end

S=zeros(k,1);
P=cell(k,1);
for i=1:k
    S(i)=sortedS(i);
    P{i}=Pi{I(i)}; % Select the k {Pij}i,j which best match P0
end

return




