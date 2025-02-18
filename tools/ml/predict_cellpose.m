%Script to use trained model to generate cell masks
clearvars
clc

dataDir = 'X:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';

model = 'D:\Projects\Research\HaCat models\trained\models\cellpose_1739318449.8496401';

cp = cellpose(model=model);

%r2c2f3
%r2c4f1

exportDir = 'Y:\ML data';

imgFiles = dir(fullfile(dataDir, '*-ch3*.tiff'));