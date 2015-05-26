function [CoordinatesSorted]=SortAllP0Tensor(N,Frame)
% Find all MBs in the frame which need to be completed.
% N is the size of the MB.

%sz=size(Movie);
%Ni=sz(1); Nj=sz(2);
Ni=size(Frame,1); Nj=size(Frame,2);
NbGoodPixels=[];
Coordinates=[];

for i=1:(N/2):Ni-N+1
    for j=1:(N/2):Nj-N+1
        Pij=Frame(i:i+N-1, j:j+N-1);
        if min(min(Pij))<0 % Pij is not clean, and needs to be completed
            NbGoodPixels(end+1)=sum(sum(Pij>=0)); % Computes nb of known pixels in Pij
            Coordinates(end+1,:)=[i,j]; % Store position of Pij
        end
    end
end

% Sort the Pij wrt to the nb of known pixels they contain
[~,I] = sort(NbGoodPixels,'descend');
CoordinatesSorted=Coordinates;
for i=1:length(I)
    % Sort the locations of Pij 
    CoordinatesSorted(i,:)=Coordinates(I(i),:);
end

return