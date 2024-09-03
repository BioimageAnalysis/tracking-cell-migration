clearvars
clc

T = ECMCellTracker;

dataDir = 'F:\2024 Liu Lab\Duration data + HeCAT21624__2024-02-16T15_55_35-Measurement 1\Images';
outputDir = '../test_data2';

process(T, dataDir, outputDir, [2, 9, 7])