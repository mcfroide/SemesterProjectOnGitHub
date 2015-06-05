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
   elseif (strcmp(currentFile(1:14), 'Algo1_Bus_N16p') && strcmp(currentFile(end-8:end), 'Final.mat'))
       files{end+1}=currentFile;
       p(end+1)=str2num(currentFile(15:end-9))
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
filename=['../Code/Movies/BusResizedCropedMovie.mat'];
load(filename);


figure
subplot(2,4,1)
imshow(double(mov(:,:,15)))
title(['Original frame']);

for i=1:length(files)
   currentFile=files{i};
   load(currentFile);   
   subplot(2,4,i+1)
   imshow(double(RecoveredMovie(:,:,15)))
   title(['p=',num2str(p(i)),'%']);
end


