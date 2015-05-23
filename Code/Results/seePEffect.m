clear all;
close all;

files={};
p=[];

colors={'-or', '-ob', '-ok', '-om','-oc', '-og', '--xr','--xb','--xk'};

% Look for results in the directory
listing = dir;
for i=length(listing):-1:1
   currentFile=listing(i).name;
   if length(currentFile)<15
   elseif strcmp(currentFile(1:14), 'Algo1_Bus_N16p') 
       files{end+1}=currentFile;
       p(end+1)=str2num(currentFile(15:end-4))
   end
end

% Sort results wrt to p
[p,I]=sort(p);
temp=cell(size(files));
for i=1:length(I)
    temp{i}=files{I(i)};
end
files=temp;

clear listing temp

% Plot all results in one figure
figure

for i=1:length(files)
   currentFile=files{i};
   %pStr{i}=['p=',currentFile(15:end-4),'%'];
   load(currentFile);   
   subplot(3,3,i)
   imshow(double(RecoveredMovie(:,:,15)))
end
