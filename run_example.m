clearvars
clc

T = ECMCellTracker;
T.ParallelRequestedWorkers = 2;
T.ParallelProcess = false;
T.FrameRange = 1:71;
T.FileFormat = 'operaphenix2';

%T.ROI = [470 266 583 700];
T.ROI = [209 1 750 600];  %ymin xmin height width
% T.SegmentType = 'nuclear';
% T.NucleiQuality = 50;

%dataDir = 'Z:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
%outputDir = 'Z:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked Data\2025-04-09';

dataDir = 'Z:\Datasets\20250530\hs\be8a9d7f-32b8-490f-89bc-39485e10fddc\images\r04c04';
outputDir = 'Z:\Datasets\20250530\processed\r04c04';

% dataDir = 'X:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
% outputDir = 'X:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked_2';

%process(T, dataDir, outputDir, [4 6 2; 4 6 1; 4 5 3; 4 5 2; 4 5 1; 4 4 3; 4 4 1; 4 3 3; 4 3 2; 4 3 1])
% process(T, dataDir, outputDir, [2, 2, 2; 2, 2, 3; 2, 3, 1; 2 3 2; 2, 3, 3; 2 4 1; 2 4 2; 2 4 3;...
%     3, 2, 1; ])

process(T, dataDir, outputDir, [4, 4, 2])
%[2, 2, 1