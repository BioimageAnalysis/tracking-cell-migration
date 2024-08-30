classdef OPCellTracker

    methods

        function trackcells(obj, varargin)





        end

    end

    methods (Static)

        function processFile(dataDir, opts)


        end

        function mask = segmentCells(I, threshold)
            %SEGMENTCELLS  Segment cells in image
            %
            %  MASK = SEGMENTCELLS(I, T) identifies nuclei in the image I.
            %  The nuclei are expected to be small and round in shape. The
            %  algorithm works by using the difference of Gaussians filter
            %  to generate an initial mask. Watershedding and other
            %  morphological operators are then applied to remove unwanted
            %  objects from detection.

            I = double(I);

            Idg1 = imgaussfilt(I, 4);
            Idg2 = imgaussfilt(I, 1);

            Idog = Idg2 - Idg1;

            mask = Idog > 20;

            dd = -bwdist(~mask);
            dd(~mask) = false;
            dd = imhmin(dd, 0.7);

            L = watershed(dd);

            mask(L == 0) = false;
            mask = imclearborder(mask);


        end

        function img = readImage(dataDir, varargin)
            %READIMAGE  Reads an image from Harmony
            %
            %  I = READIMAGE(FOLDER, ROW, COL) reads the (first) image at
            %  the specified well. Additional parameters can be passed on
            %  to specify the field of view, frame, channel, and z-plane to
            %  read. Note that the parameters must be passed in that order.
            %  FOLDER should be the path to the folder that exported from
            %  the Harmony software.
            
            ip = inputParser;
            addRequired(ip, 'row')
            addRequired(ip, 'col')
            addOptional(ip, 'field', 1)
            addOptional(ip, 'frame', 1)
            addOptional(ip, 'channel', 1)            
            addOptional(ip, 'plane', 1)
            parse(ip, varargin{:})

            filename = ...
                sprintf('r%02dc%02df%02dp%02d-ch%dsk%dfk1fl1.tiff', ...
                ip.Results.row, ...
                ip.Results.col, ...
                ip.Results.field, ...
                ip.Results.plane, ...
                ip.Results.channel, ...
                ip.Results.frame);

            %Harmony output filename:
            % r03c03f01p01-ch1sk1fk1fl1.tiff
            %
            % Where
            % r (01-08) = row
            % c (01-12) = column
            % f (01-09) = field
            % p (01-21) = plane
            % ch (1-4) = channel

            if ~exist(fullfile(dataDir, filename), 'file')
                error('File does not exist')
            end

            img = imread(fullfile(dataDir, filename));

        end

    end



end