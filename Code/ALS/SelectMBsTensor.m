function [P,S]=SelectMBsTensor(Movie, K, P0, iFrame, nbNeighbours)
% nbNeighbours is th nb of nearest previously recovered and nb of corrupted
% future frames used in the tensor building step.
% Set it to -1 to use all frames
sz=size(Movie);
Ni=sz(1); Nj=sz(2); NFrames=sz(3);
N=size(P0,1);
Omega=(P0>=0); % Set of clean pixels
%P=cell(K-1,1);
Pi={};
S=[];

% nbBlocksPerColumn=floor(Ni/N);
% nbBlocksPerRow=floor(Nj/N);
% nbBlocks=nbBlocksPerColumn*nbBlocksPerRow;
% S=-1*ones(nbBlocks*length(FramesSet),1);
% index=0;


if nbNeighbours==-1
    FramesSet=1:NFrames;
else
    m=max(1,iFrame-nbNeighbours);
    M=min(NFrames, iFrame+nbNeighbours);
    FramesSet=m:M;
end


normP0=norm(P0.*Omega, 'fro');

%for k=1:NFrame
for k=FramesSet
    Frame=double(Movie(:, :,k));
    for i=1:N/2:Ni-N+1
        for j=1:N/2:Nj-N+1
            %Pij=double(Movie(i:i+N-1, j:j+N-1,k));
            Pij=Frame(i:i+N-1, j:j+N-1);
            if min(min(Pij))<0
                % Pij is not clean
            else
                %if all(all(Pij>=0)) %This test is too long
                %index=index+1;
                Pij=Pij/norm(Pij.*Omega, 'fro')*normP0;
                Pi{end+1}=Pij; % Store Pij in Pi
                %S(index)=sum(sum(abs(Omega.*(Pij-P0)))); % Compute its "non-match" with P0
                S(end+1)=sum(sum(abs(Omega.*(Pij-P0)))); % Compute its "non-match" with P0

            end
        end
    end
end

%S=S(1:index);

[sortedS,I] = sort(S,'ascend'); % sort S

k=1;
while (sortedS(k)<=2*sortedS(1) && k<K-1 && k<length(sortedS))
    k=k+1;
    % If not enough similar blocks are available, take less blocks
    % to avoid taking non-similar blocks
end


%k=min(K-1,length(sortedS));
S=zeros(k,1);
P=cell(k,1);
for i=1:k
    S(i)=sortedS(i);
    %Pij=Pi{I(i)}; % Select the K {Pij}i,j which best match P0
    %P{i}=Pij/norm(Pij, 'fro')*normP0; % Normalize selected {Pij}i,j
    P{i}=Pi{I(i)}; % Select the K {Pij}i,j which best match P0
end

% sortedS(1)
% pause

%%%%%%%%%%%%%%%%
% Normalize the Pi
% What is the l2-norm of a matrix ? Is it Fobenius norm ?
% Should the normalizaiton be done before the selection ?!
%%%%%%%%%%%
% figure(1)
%  imshow(P0)
%  figure(2)
%  imshow(P{1})
%  figure(3)
%  imshow(P{end})
%  pause

return




