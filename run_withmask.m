clearvars
clc

T = ECMCellTracker;
T.ParallelProcess = false;
T.FrameRange = 1:288;
T.FileFormat = 'exportedtiff';
T.UseMask = true;


dataDir = 'D:\Work\Research\HaCat-cell-migration\data\20250902';
outputDir = 'D:\Work\Research\HaCat-cell-migration\data\20250902\processed';

process(T, dataDir, outputDir, 'r03c04f01p01');


