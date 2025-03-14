classdef cicAnalyzer

    methods

        function analyzeImage(obj)

            reader = HarmonyReader('Z:\CIC Datasets\qb-RPE-MDA-20250207__2025-02-07T18_09_39-Measurement 1\hs');

            vid = VideoWriter('test.avi');
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

            save('test.mat');
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