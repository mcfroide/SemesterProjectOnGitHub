clear all;
close all;
clc;

N=16; % Size of Macro-Block 

load('BusCorruptedMovie015.mat');

%CorruptedMovie=CorruptedMovie(10:160, 25:230,: );
OriginalMovie=OriginalMovie(10:160, 25:230,: );

CorruptedMovie=CorruptRandomly(OriginalMovie, N/2, 0.15);

%save('BusCorrupted&CropedMovieN16p015.mat','OriginalMovie','CorruptedMovie');