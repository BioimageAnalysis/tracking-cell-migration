clearvars
clc

dataDir = 'F:\2024 Liu Lab\Duration data + HeCAT21624__2024-02-16T15_55_35-Measurement 1\Images';

outputDir = 'D:\Work\Research\20240321';

threshold = 200;

%rows = [4, 5];
%cols = [6, 7, 8];
rows = 3;
cols = 11;
fields = 4;

if ~exist(outputDir, 'dir')

    mkdir(outputDir);

end

for iRow = rows
    for iCol = cols

        for iField = fields

            outputFN = ['r', sprintf('%02.0f', iRow), 'c', sprintf('%02.0f', iCol), 'f', sprintf('%02.0f', iField)];

            LAP = LAPLinker;
            LAP.LinkCostMetric = 'euclidean';
            LAP.TrackDivision = true;
            LAP.LinkScoreRange = [0 40];
            LAP.DivisionScoreRange = [0 20];

            vid = VideoWriter(fullfile(outputDir, [outputFN, '.avi']));
            vid.FrameRate = 5;
            open(vid)

            for iT = 1:10

                I = readImage(dataDir, iRow, iCol, iField, 2, iT);

                mask = segmentCells(I, threshold);

                data = regionprops(mask, 'Centroid');

                LAP = assignToTrack(LAP, iT, data);

                Iout = double(I);
                Iout = (Iout - min(Iout, [], 'all'))/(max(Iout, [], 'all') - min(Iout, [], 'all'));

                Iout = showoverlay(imadjust(Iout), bwperim(mask));
                for iAT = LAP.activeTrackIDs
                    ct = getTrack(LAP, iAT);
                    Iout = insertText(Iout, ct.Centroid(end, :), int2str(iAT), ...
                        'TextColor', 'white', 'BoxOpacity', 0);
                end

                writeVideo(vid, Iout);

            end
            close(vid)

            tracks = LAP.tracks;
            trackStruct = tracks.Tracks;

            save(fullfile(outputDir, [outputFN, '.mat']), 'tracks', 'trackStruct', 'threshold');

            exportsettings(LAP, fullfile(outputDir, [outputFN, '_trackingParams.txt']));
        end
    end
end

% imshowpair(imadjust(I), bwperim(mask))



