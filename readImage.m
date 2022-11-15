function img = readImage(dataDir, row, col, field, channel, frame)

filename = ...
    sprintf('r%02.0fc%02.0ff%02.0fp01-ch%.0fsk%.0ffk1fl1.tiff', ...
    row, col, field, channel, frame);

if ~exist(fullfile(dataDir, filename), 'file')
    error('File does not exist')
end

img = imread(fullfile(dataDir, filename));