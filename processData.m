clearvars
clc

dataDir = 'H:\HaCaT movies-20221101\QB-20221028-HaCaT__2022-10-28T16_46_24-Measurement 2\Images';

outputDir = 'D:\Projects\ALMC Tickets\T17151-XuedongLiu\data\20221130_2';

threshold = 50;

rows = [4, 5];
cols = [6, 7, 8];

for iRow = rows
    for iCol = cols

        outputFN = ['r', sprintf('%02.0f', iRow), 'c', sprintf('%02.0f', iCol)];

        LAP = LAPLinker;
        LAP.TrackDivision = true;
        LAP.LinkScoreRange = [0 50];
        LAP.DivisionScoreRange = [0 20];

        vid = VideoWriter(fullfile(outputDir, [outputFN, '.avi']));
        vid.FrameRate = 5;
        open(vid)

        for iT = 1:102

            I = readImage(dataDir, iRow, iCol, 1, 1, iT);

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

% imshowpair(imadjust(I), bwperim(mask))



