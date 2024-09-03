function img = readImage(dataDir, row, col, field, channel, frame)
% r03c03f01p01-ch1sk1fk1fl1.tiff
% 
% Where
% r (01-08) = row
% c (01-12) = column
% f (01-09) = field
% p (01-21) = plane
% ch (1-4) = channel

filename = ...
    sprintf('r%02.0fc%02.0ff%02.0fp01-ch%.0fsk%.0ffk1fl1.tiff', ...
    row, col, field, channel, frame);

if ~exist(fullfile(dataDir, filename), 'file')
    error('File does not exist')
end

img = imread(fullfile(dataDir, filename));