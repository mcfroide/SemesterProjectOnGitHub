function [CoordinatesSorted]=SortAllP0Tensor(Movie, N,Frame)
    sz=size(Movie);
    Ni=sz(1); Nj=sz(2); %NFrame=sz(3);
    %P0List={};
    %Ni=size(Frame,1); Nj=size(Frame,2);
    NbGoodPixels=[];
    Coordinates=[];
    
    %nFrame=1; %Reconstruct the 1st frame only
    %nFrame=6; %Reconstruct the 6th frame only
    %Frame=double(Movie(:,:,nFrame));
    %for k=1:1NFrame 
      for i=1:(N/2):Ni-N+1
        for j=1:(N/2):Nj-N+1

            %Pij=double(Movie(i:i+N-1, j:j+N-1,k));
            Pij=Frame(i:i+N-1, j:j+N-1);
            if min(min(Pij))<0
               % Pij is not clean 
               NbGoodPixels(end+1)=sum(sum(Pij(Pij>=0)));
               %P0List{end+1}=Pij;
               Coordinates(end+1,:)=[i,j];
            end         
        end
      end
    %end

      % Sort P0List
      [sorted,I] = sort(NbGoodPixels,'descend'); % sort S
      CoordinatesSorted=Coordinates;
    for i=1:length(I)
        %P0List{i}=P0List{I(i)};
        CoordinatesSorted(i,:)=Coordinates(I(i),:);
    end
return