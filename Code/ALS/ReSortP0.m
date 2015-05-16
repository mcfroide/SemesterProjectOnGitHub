function SortedCoordinates=ReSortP0(Coordinates, n, Frame, N)
% Doesn't work properly yet.
% n is the index of the Coordinates vector from which entries need to be
% sorted. 

temp=Coordinates(n:end,:)
NbGoodPixels=zeros(size(temp,1),1);

for k=1:size(temp,1)
    %i=Coordinates(k-1+n,1);
    %j=Coordinates(k-1+n,2);
    i=temp(k,1);
    j=temp(k,2);
    Pij=Frame(i:i+N-1, j:j+N-1); 
    NbGoodPixels(k)=sum(sum(Pij(Pij>=0)));
end
  [~,I] = sort(NbGoodPixels,'descend'); % sort S
    SortedCoordinates=Coordinates;
    for i=1:length(I)
        SortedCoordinates(n+i-1,:)=temp(I(i),:);
    end
end