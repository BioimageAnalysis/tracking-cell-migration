clearvars
clc

file = 'Z:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Tracked_2\QB_Hacat_EKAR_H2BmCherry_11012024__2024_11_01T16_56_55_Measurement_1_r02c03f03.mat';

load(file)
%%
for iTr = 1:tracks.NumTracks

    ct = getTrack(tracks, iTr);

    if numel(ct.ERKintensity) ~= size(ct.Centroid, 1)
        keyboard
    end
end