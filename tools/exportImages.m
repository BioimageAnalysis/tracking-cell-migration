clearvars
clc

ROI = [472 1080 390 1027];

fpath = 'Z:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
fpathOut = 'D:\Work\Research\HaCat-cell-migration\data\20250902';
fn = 'r03c04f01p01';

for iT = 1:288
    for iC = 1:3

        currFN = sprintf('%s-ch%.0dsk%.0dfk1fl1.tiff', ...
            fn, iC, iT);

        fPathFull = fullfile(fpath, currFN);

        I = imread(fPathFull);
        I = I(ROI(1):ROI(2), ROI(3):ROI(4));

        currFN_out = sprintf('%s_ch%.0d.tiff', ...
            fn, iC);

        if iT == 1
            imwrite(I, fullfile(fpathOut, currFN_out), 'Compression', 'none');
        else
            imwrite(I, fullfile(fpathOut, currFN_out), 'Compression', 'none', 'writeMode', 'append');
        end
    end
end