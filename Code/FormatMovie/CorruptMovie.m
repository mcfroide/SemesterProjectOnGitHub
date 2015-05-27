clear all;
close all;
clc;

N=8; % Size of Macro-Block 

load('../Movies/BusResizedCropedMovie.mat');

OriginalMovie=mov;
p=[0.15]

figure

for i=1:length(p)
    CorruptedMovie=CorruptRandomly(mov, N/2, p(i));
    nb=p(i)*100;
    strNb=num2str(nb)

    imshow(double(CorruptedMovie(:,:,20)));
    drawnow

    filename=['../Movies/BusCorruptedMovieN8p',strNb ,'.mat']
    %save(filename,'OriginalMovie','CorruptedMovie');
end