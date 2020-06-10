%% Test Cloth Image
clc;
clear all;
close all;
[fname, path]=uigetfile('.jpg','provide a Leaf Image for testing');
fname=strcat(path, fname);
im=imread(fname);
im=im2bw(im);
imshow(im);
title('Test Cloth Image');
%% Find the class the test cloth image belongs
Ftest=feature_statistical(im);
%% Compare with the feature of training image in the database
load db.mat
Ftrain=db(:,1:2);
Ctrain=db(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end
Min=min(dist);
if(Min<2)
m=find(dist==Min,1);
det_class=Ctrain(m);
msgbox(strcat('Detected Class=',num2str(det_class)));
else
    msgbox('This is not in the data set');
end
