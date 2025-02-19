%Script to use trained model to generate cell masks
clearvars
clc

dataDir = 'X:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
model = 'D:\Projects\Research\HaCat models\trained\models\cellpose_1739921107.8345888';

outputDir = 'X:\ML data\predictions\cellpose_1739921107_diameter';

row = 2;
col = 2;
field = 3;
frame = 1:288;

chan = 3;  %Nuclear

%% Process files

if ~exist(outputDir, 'dir')
    mkdir(outputDir)
end

%Generate output filename
fn = fileparts(dataDir);
[~, dn] = fileparts(fn);

%Create cellpose object and load model
cp = cellpose(model=model);

for iFrame = 1:numel(frame)

    I = ECMCellTracker.readImage(dataDir, row, col, field, frame(iFrame), chan);

    %Run prediction
    labels = segmentCells2D(cp, I);

    %Convert to uint16
    labels = uint16(labels);

    exportFN = sprintf('%s_r%dc%df%d', dn, row, col, field);

    if iFrame == 1
        imwrite(I, fullfile(outputDir, [exportFN, '_image.tiff']), 'Compression', 'none')
        imwrite(labels, fullfile(outputDir, [exportFN, '_masks.tiff']), 'Compression', 'none')
    else
        imwrite(I, fullfile(outputDir, [exportFN, '_image.tiff']), 'Compression', 'none', 'writeMode', 'append')
        imwrite(labels, fullfile(outputDir, [exportFN, '_masks.tiff']), 'Compression', 'none', 'writeMode', 'append')
    end


end


