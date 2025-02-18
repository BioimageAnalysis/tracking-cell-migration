clearvars
clc

dataDir = 'Y:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';

exportDir = 'Y:\ML data';

imgFiles = dir(fullfile(dataDir, '*-ch3*.tiff'));

%%
%Pick some random images
idx = randsample(numel(imgFiles), 1000);

imgList = {};

for ii = 1:numel(idx)

    imgList{ii} = imgFiles(idx(ii)).name;

    I = imread(fullfile(dataDir, imgFiles(idx(ii)).name));

    mask = ECMCellTracker.segmentCells(I, 20);

    [~, fn] = fileparts(imgFiles(idx(ii)).name);

    imwrite(I, fullfile(exportDir, 'images', [fn, '.tiff']), 'Compression', 'none')
    imwrite(mask, fullfile(exportDir, 'masks', [fn, '.tiff']), 'Compression', 'none')
    
end

%%
fid = fopen(fullfile(exportDir, 'files.csv'), 'w');

for iF = 1:numel(imgList)

    fprintf(fid, '%s\n', imgList{iF});

end

fclose(fid)