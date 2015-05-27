clear all;
close all;

files={};
p=[];

colors={'-or', '-ob', '-ok', '-om','-oc', '-og', '--xr','--xb','--xk'};

% load 'Algo1_Bus_N16p15.mat';
% 
% n=8;
% s=size(RecoveredMovie);
% Ni=s(1);
% Nj=s(2);
% 
% clear ErrorFro, RecoveredMovie;
% 
% nbBlocksPerColumn=floor(Ni/n);
% nbBlocksPerRow=floor(Nj/n);
% nbBlocks=nbBlocksPerColumn*nbBlocksPerRow;


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
hold on;
grid on;
xlabel('Frame index');
ylabel('Relative error'); %||A_{restored}-A||_F/||A||_F

for i=1:length(files)
   currentFile=files{i};
   %nbCorruptedBlocks=round(p(i)*nbBlocks);
   pStr{i}=['p=',currentFile(15:end-4),'%'];
   load(currentFile);   
   plot(1:length(ErrorFro),ErrorFro, colors{i})
end
legend(pStr)