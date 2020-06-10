clc;
clear all;
close all;
%% Taking an Cloth Image
[fname, path]=uigetfile('.jpg','Open a Leaf Image as input for training');
fname=strcat(path, fname);
im=imread(fname);
im=im2bw(im);
imshow(im);
title('Input Cloth Image');
c=input('Enter the Class(Number from 1-50)');
%% Feature Extraction
F=feature_statistical(im);
try 
    load db;
    
    F=[F c];
    db=[db; F];
    save db.mat db 
catch 
    db=[F c]; % 10 12 1
    save db.mat db 
end

