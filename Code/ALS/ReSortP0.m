function SortedCoordinates=ReSortP0(Coordinates, n, Frame, N)
% n is the index of the Coordinates vector from which entries need to be
% sorted.

% No need to consider the n-1 first coordinates which have already been
% processed
temp=Coordinates(n:end,:);

NbGoodPixels=zeros(size(temp,1),1);

for k=1:size(temp,1)
    i=temp(k,1);
    j=temp(k,2);
    Pij=Frame(i:i+N-1, j:j+N-1);
    % Compute the nb of known pixels in Pij
    NbGoodPixels(k)=sum(sum((Pij>=0)));
end
[~,I] = sort(NbGoodPixels,'descend'); % sort S
SortedCoordinates=Coordinates;
for i=1:length(I)
    SortedCoordinates(n+i-1,:)=temp(I(i),:);
end

end