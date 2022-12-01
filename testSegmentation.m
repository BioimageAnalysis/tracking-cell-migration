clearvars
clc

dataDir = 'H:\HaCaT movies-20221101\QB-20221028-HaCaT__2022-10-28T16_46_24-Measurement 2\Images';

iT = 1;

I = readImage(dataDir, 5, 8, 1, 1, iT);

Ifilt = imgaussfilt(I, 1);
Ifilt2 = imtophat(Ifilt, strel('disk', 10));

%mask = imbinarize(Ifilt2, 'adaptive', 'Sensitivity', 0.2);
%%
mask = Ifilt2 > 50;

% mask = imclose(mask, strel('disk', 2));
mask = imopen(mask, strel('disk', 1));

mask = imclearborder(mask);
mask = bwareaopen(mask, 50);

dd = -bwdist(~mask);
dd(~mask) = false;
dd = imhmin(dd, 0.7);

L = watershed(dd);

mask(L == 0) = false;

showoverlay(imadjust(I), bwperim(mask));