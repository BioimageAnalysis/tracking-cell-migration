classdef cicAnalyzer

    methods
    
        function analyzeImage(obj, filepath, outputDir)
            %ANALYZEIMAGE  Analyze images

            if ~exist(outputDir, 'dir')
                mkdir(outputDir);
            end

            reader = HarmonyReader(filepath);

            for iLoc = 1:numel(reader.WellLocs)

                %Convert well location string to row and col index
                row = str2double(reader.WellLocs{iLoc}(2:3));
                col = str2double(reader.WellLocs{iLoc}(5:6));

                for iField = 1:reader.NumFields

                    %Start up video
                    vid = VideoWriter(fullfile(outputDir, ...
                        sprintf('r%02dc%02df%02d.avi', row, col, iField)));
                    vid.FrameRate = 7.5;
                    open(vid)

                    LAP = LAPLinker;
                    LAP.MaxTrackAge = 0;
                    LAP.LinkScoreRange = [0 50];

                    storeCellCounts.Red = zeros(1, reader.NumFrames);
                    storeCellCounts.Green = zeros(1, reader.NumFrames);

                    for iT = 1:reader.NumFrames

                        Ired = readImage(reader, 2, 6, 2, 1, 1, iT);
                        Igreen = readImage(reader, 2, 6, 2, 1, 2, iT);

                        maskRed = cicAnalyzer.segment(Ired);
                        maskGreen = cicAnalyzer.segment(Igreen);

                        %%

                        maskOverlap = maskGreen & maskRed;
                        maskOverlap = imfill(maskOverlap, 'holes');
                        maskOverlap = bwareaopen(maskOverlap, 80);  %TODO: Replace with a metric like 25% of cell size?

                        %Track interaction events
                        overlappingCellData = regionprops(maskOverlap, 'Centroid');
                        if ~isempty(overlappingCellData)
                            LAP = assignToTrack(LAP, iT, overlappingCellData);
                        end

                        %Count number of cells
                        cc_red = bwconncomp(maskRed);
                        cc_green = bwconncomp(maskGreen);

                        storeCellCounts.Red(iT) = cc_red.NumObjects;
                        storeCellCounts.Green(iT) = cc_green.NumObjects;

                        Ired_norm = double(Ired);
                        Ired_norm = (Ired_norm - min(Ired_norm(:)))/(max(Ired_norm(:)) - min(Ired_norm(:)));

                        Igreen_norm = double(Igreen);
                        Igreen_norm = (Igreen_norm - min(Igreen_norm(:)))/(max(Igreen_norm(:)) - min(Igreen_norm(:)));

                        Irgb = cat(3, Ired_norm, 1.5 * Igreen_norm, zeros(size(Ired), 'double'));

                        Iout = showoverlay(Irgb, bwperim(maskRed), 'Color', [1 0 1]);
                        Iout = showoverlay(Iout, bwperim(maskGreen), 'Color', [1 1 0]);
                        Iout = showoverlay(Iout, bwperim(maskOverlap), 'Color', [1 1 1]);

                        for iEv = 1:numel(LAP.activeTrackIDs)

                            ct = getTrack(LAP, LAP.activeTrackIDs(iEv));

                            Iout = insertText(Iout, ...
                                ct.Centroid(end, :), ...
                                int2str(LAP.activeTrackIDs(iEv)), ...
                                'BoxOpacity', 0, 'FontColor', 'white');

                        end

                        writeVideo(vid, Iout);

                        %imshow(Iout)

                    end

                    close(vid)

                    save(fullfile(outputDir, ...
                        sprintf('r%02dc%02df%02d.mat', row, col, iField)));
                end

            end
        end       

    end

    methods (Static)

        function mask = segment(image)

            mask = imbinarize(image, 'adaptive');
            mask = imopen(mask, strel('disk', 3));

            dd = -bwdist(~mask);
            dd(~mask) = Inf;

            dd = imhmin(dd, 1.1);

            L = watershed(dd);

            mask(L == 0) = false;


        end



    end




end