%EXPORT_MASKS_COMPARISON  Export masks from a whole movie for comparison
clearvars
clc

dataDir = 'X:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';
exportDir = 'X:\ML data\validation';

row = 2;
col = 2;
field = 3;
frame = 1:288;

%% Process files

%Generate output filename
fn = fileparts(dataDir);
[~, dn] = fileparts(fn);

chan = 3;  %Nuclear

for iFrame = 1:numel(frame)

    I = ECMCellTracker.readImage(dataDir, row, col, field, frame(iFrame), chan);

    mask = ECMCellTracker.segmentCells(I, 20);
    
    exportFN = sprintf('%s_r%dc%df%d', dn, row, col, field);

    if iFrame == 1
        imwrite(I, fullfile(exportDir, [exportFN, '_image.tiff']), 'Compression', 'none')
        imwrite(mask, fullfile(exportDir, [exportFN, '_masks.tiff']), 'Compression', 'none')
    else
        imwrite(I, fullfile(exportDir, [exportFN, '_image.tiff']), 'Compression', 'none', 'writeMode', 'append')
        imwrite(mask, fullfile(exportDir, [exportFN, '_masks.tiff']), 'Compression', 'none', 'writeMode', 'append')
    end
    
end