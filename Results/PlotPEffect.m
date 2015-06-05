clear all;
close all;

files={};
p=[];

cc=autumn(10);
orange=cc(7,:);

%colors={'-or', '-ob', '-ok', '-om','-oc', '-og', '--xr','--xb','--xk',orange};
colors={'r', 'b', 'k', 'm','c', 'g',orange, 'r','b','k',};
markers={'o', 'x', '>', 'sq', '+','d', '*'};



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
   elseif (strcmp(currentFile(1:14), 'Algo1_Bus_N16p') && strcmp(currentFile(end-8:end), 'Final.mat'))
       files{end+1}=currentFile;
       %p(end+1)=str2num(currentFile(15:end-4))
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
figure
hold on;
grid on;
xlabel('Frame index');
ylabel('Mean relative error of reconstructed MBs'); %||A_{restored}-A||_F/||A||_F
axis([ 1 30 0.05 0.45])

for i=1:length(files)
   currentFile=files{i};
   %nbCorruptedBlocks=round(p(i)*nbBlocks);
   pStr{i}=['p=',currentFile(15:end-9),'%'];
   load(currentFile);  
   M(i)=mean(ErrorFrame);
   plot(1:length(ErrorFrame),ErrorFrame, 'Marker', markers{i},'color', colors{i} );%colors{i})
end
legend(pStr)

%%
y=log(M);
nodes=[p(1)-5,p,p(end)+5]; %nodes=0.8*p(1):0.05:1.1*p(end);
PP=polyfit(p,y,1);
QQ=polyval(PP,nodes);
Interp=exp(QQ);

Interpp=exp(PP(2))*exp(PP(1)*nodes);

figure
semilogy(p, M, '--ok');
%loglog(p, M, '--ok')
hold on;
semilogy(nodes,Interpp, '--r')
xlabel('p [%]');
ylabel('Mean Relative Error')
LinIntString=[num2str(PP(2),2),'exp(',num2str(PP(1),2),'p)'];
legend('Experimental results', LinIntString,'Location','Best')