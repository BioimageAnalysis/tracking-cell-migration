clearvars
clc

T = ECMCellTracker;
T.ParallelRequestedWorkers = 2;
T.ParallelProcess = false;
% T.SegmentType = 'nuclear';
% T.NucleiQuality = 50;

dataDir = 'Z:\transferred files-09162024\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1\Images';
outputDir = 'Z:\Tracked ERK\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1/';

%process(T, dataDir, outputDir, [4 6 2; 4 6 1; 4 5 3; 4 5 2; 4 5 1; 4 4 3; 4 4 1; 4 3 3; 4 3 2; 4 3 1])
process(T, dataDir, outputDir, [4 6 1; 4 5 3; 4 5 2; 4 5 1; 4 4 3; 4 4 1; 4 3 3; 4 3 2; 4 3 1])