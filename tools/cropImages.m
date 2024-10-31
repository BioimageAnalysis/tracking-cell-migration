function cropImages(dataDir, row, col, field, roi, outputDir)

%Get number of frames
filename = ...
    sprintf('r%02dc%02df%02dp%02d-ch%dsk*.tiff', ...
    row, ...
    col, ...
    field, ...
    1, ...
    1);

files = dir(fullfile(dataDir, 'Images', filename));

if isempty(files)
    error('File not found')
end

filenames = {files.name};

R = regexp(filenames, '\w+sk(\d+)\w+.tiff', 'tokens');

maxFrame = -Inf;
for iR = 1:numel(R)
    maxFrame = max(maxFrame, str2double(R{iR}{1}));
    disp(str2double(R{iR}{1}))
end

if ~exist(outputDir, 'dir')
    mkdir(outputDir)
end

for iT = 1:maxFrame

    for iC = 1:3

        filename = ...
            sprintf('r%02dc%02df%02dp%02d-ch%dsk%dfk1fl1.tiff', ...
            row, ...
            col, ...
            field, ...
            1, ...
            iC, ...
            iT);

        if ~exist(fullfile(dataDir, 'Images', filename), 'file')
            continue
        else
            I = imread(fullfile(dataDir, 'Images', filename));

            I = I(roi(2):roi(4), roi(1):roi(3));

            [~, fn] = fileparts(dataDir);
            [~, fn] = fileparts(fn);

            fn = [fn, sprintf('r%02dc%02df%02d_ch%d.tif', ...
                row, col, field, iC)];
            
            if iT == 1
                imwrite(I, fullfile(outputDir, fn),'Compression', 'none')                
            else
                imwrite(I, fullfile(outputDir, fn), 'writeMode', 'append', 'Compression', 'none')            
            end
        end
    end
end