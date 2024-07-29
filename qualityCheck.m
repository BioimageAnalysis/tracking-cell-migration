clearvars
clc

file = 'D:\Work\Research\20240321\r02c09f07.mat';

numFrames = 110;

load(file)

%% Find tracks that are tracked for at least 90% of the movie

isTrackValid = false(1, tracks.NumTracks);

for iTrack = 1:tracks.NumTracks

    ct = getTrack(tracks, iTrack);

    if numel(ct.Frames) >= (0.9 * numFrames)

        isTrackValid(iTrack) = true;
        plot(ct.Centroid(:, 1), ct.Centroid(:, 2));
        hold on

    end

end

