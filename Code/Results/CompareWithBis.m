clear all;
close all;

files={};
p=15;

colors={'-or', '-ob', '-ok', '-om','-oc', '-og', '--xr','--xb','--xk'};

% Look for results in the directory
listing = dir;
for i=length(listing):-1:1
   currentFile=listing(i).name;
   if length(currentFile)<16
   elseif strcmp(currentFile(1:16), 'Algo1_Bus_N16p15') 
       files{end+1}=currentFile;
       p(end+1)=15;
   end
end


clear listing temp

% Plot all results in one figure
figure
hold on;
grid on;
xlabel('Frame index');
ylabel('Relative Frobenius Error'); %||A_{restored}-A||_F/||A||_F

for i=1:length(files)
   currentFile=files{i};
   pStr{i}=['p=',currentFile(15:end-4),'%'];
   load(currentFile);   
   plot(1:length(ErrorFro),ErrorFro, colors{i})
end
legend(pStr)

%%
% Plot all results in one figure
figure
for i=1:length(files)
   currentFile=files{i};
   load(currentFile);   
   subplot(1,2,i)
   imshow(double(RecoveredMovie(:,:,15)))
   title([pStr{i}]);
end
