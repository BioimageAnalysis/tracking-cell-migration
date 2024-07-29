clearvars
clc

dataDir = 'F:\2024 Liu Lab\Duration data + HeCAT21624__2024-02-16T15_55_35-Measurement 1\Images';
outputDir = 'C:\Users\Jian Tay\OneDrive - UCB-O365\Shared\Share with Bortz Liu labs\20240531';


threshold = 100;

%rows = [4, 5];
%cols = [6, 7, 8];
rows = 2;
cols = 9;
fields = [7];

roiCols = [601 900];

frameRange = 1:110;

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
            LAP.LinkScoreRange = [0 15];
            LAP.DivisionScoreRange = [0 20];

            vid = VideoWriter(fullfile(outputDir, [outputFN, '.avi']));
            vid.FrameRate = 5;
            open(vid)

            for iT = frameRange

                if rem(iT, 10) == 0

                    fprintf('%.1f %% completed.\n', ((iT - frameRange(1))/numel(frameRange)) * 100)
                    save('currentData.mat', 'LAP');

                end

                try

                I = readImage(dataDir, iRow, iCol, iField, 2, iT);
                skippedFrames = 0;

                catch

                    skippedFrames = skippedFrames + 1;

                    if skippedFrames > 10
                        break
                    end

                    continue

                end

                %I = I(:, roiCols(1):roiCols(2));

                % imshow(I, [])

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



