clearvars
clc

dataDir = 'H:\HaCaT movies-20221101\QB-20221028-HaCaT__2022-10-28T16_46_24-Measurement 2\Images';

I = imread(fullfile(dataDir, 'r04c06f01p01-ch1sk1fk1fl1.tiff'));

I2 = imread(fullfile(dataDir, 'r04c06f01p01-ch1sk2fk1fl1.tiff'));

figure;
imshow(imadjust(I), [])

figure;
imshow(imadjust(I2), [])

% r03c03f01p01-ch1sk1fk1fl1.tiff
% 
% Where
% r (01-08) = row
% c (01-12) = column
% f (01-09) = field
% p (01-21) = plane
% ch (1-4) = channel