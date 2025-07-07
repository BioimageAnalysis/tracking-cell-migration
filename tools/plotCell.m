clearvars
clc

% load('W:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked Data\QB_Hacat_EKAR_H2BmCherry_11012024__2024_11_01T16_56_55_Measurement_1_r02c03f03.mat')
% 
% path = 'W:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';

load('Z:\Datasets\20250530\processed\r04c04\images_r04c04f02.mat')

path = 'Z:\Datasets\20250530\hs\be8a9d7f-32b8-490f-89bc-39485e10fddc\images\r04c04';

row = 4;
col = 4;
field = 2;

ct = getTrack(tracks, 22);

ROI = opts.ROI;
%%

v = VideoWriter('20250707_cell2255.avi');
v.FrameRate = 7.5;

open(v)

for iFrames = 1:numel(ct.Frames)

    I = ECMCellTracker.readImage2(path, row, col, field, ct.Frames(iFrames), 3);

    I = I(ROI(1):(ROI(1) + ROI(3)), ROI(2):(ROI(2) + ROI(4)));

    if ~any(isnan(ct.Centroid(iFrames, :)))
        I = double(I);
        I = (I - min(I(:)))/(max(I(:)) - min(I(:)));
        I = imadjust(I);
        I = insertShape(I, 'circle', [ct.Centroid(iFrames, :) 4]);

        writeVideo(v, I);
    end

    % imshow(I, [])
    % keyboard



end
close(v)