clear all;
close all;
clc;

N=16; % Size of Macro-Block 

load('../Movies/BusResizedCropedMovie.mat');

OriginalMovie=mov;
p=[0.05:0.05:0.4]

%figure

for i=1:length(p)
    CorruptedMovie=CorruptRandomly(mov, N/2, p(i));
    nb=p(i)*100;
    strNb=num2str(nb)

    %imshow(double(CorruptedMovie(:,:,1)));
    %drawnow
    

    filename=['../Movies/BusCorruptedMovieN16p',strNb ,'.mat']
    %save(filename,'OriginalMovie','CorruptedMovie');
end