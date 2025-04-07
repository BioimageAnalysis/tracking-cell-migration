clearvars
clc

load('W:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked Data\QB_Hacat_EKAR_H2BmCherry_11012024__2024_11_01T16_56_55_Measurement_1_r02c03f03.mat')

path = 'W:\Datasets\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images';

row = 2;
col = 3;
field = 3;

ct = getTrack(tracks, 2712);
%%

v = VideoWriter('test.avi');
v.FrameRate = 7.5;

open(v)

for iFrames = 1:numel(ct.Frames)

    I = ECMCellTracker.readImage(path, row, col, field, ct.Frames(iFrames), 3);

    if ~any(isnan(ct.Centroid(iFrames, :)))
        I = double(I);
        I = (I - min(I(:)))/(max(I(:)) - min(I(:)));
        I = insertShape(I, 'circle', [ct.Centroid(iFrames, :) 4]);

        writeVideo(v, I);
    end

    % imshow(I, [])
    % keyboard



end
close(v)