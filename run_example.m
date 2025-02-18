clearvars
clc

T = ECMCellTracker;
T.ParallelRequestedWorkers = 2;
T.ParallelProcess = false;
T.FrameRange = 1:288;

T.ROI = [1 518 1050 550];
% T.SegmentType = 'nuclear';
% T.NucleiQuality = 50;

dataDir = 'X:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
outputDir = 'X:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked_2';

%process(T, dataDir, outputDir, [4 6 2; 4 6 1; 4 5 3; 4 5 2; 4 5 1; 4 4 3; 4 4 1; 4 3 3; 4 3 2; 4 3 1])
% process(T, dataDir, outputDir, [2, 2, 2; 2, 2, 3; 2, 3, 1; 2 3 2; 2, 3, 3; 2 4 1; 2 4 2; 2 4 3;...
%     3, 2, 1; ])

process(T, dataDir, outputDir, [2, 4, 1])
%[2, 2, 1