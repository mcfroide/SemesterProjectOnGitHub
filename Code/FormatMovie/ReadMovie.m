clear all
close all

addpath('./OpenY4M/');
addpath('./OpenY4M/YUV2Image/');

% % ****** BUS SEQUENCE **************
% filename='../CIFSequences/bus_cif.y4m';
% width=352;
% height=288;
% nrFrame=150;

% ****** FOREMAN SEQUENCE **************
filename='../CIFSequences/foreman_cif.y4m';
width=352;
height=288;
nrFrame=300;


movForeman=loadFileY4m(filename, width, height, nrFrame);

movForeman=movForeman/256.0;


save('ForemanMovie', movForeman);
