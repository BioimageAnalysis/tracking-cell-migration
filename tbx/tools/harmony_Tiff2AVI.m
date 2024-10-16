function harmony_Tiff2AVI(dataDir)

%dataDir = 'W:\transferred files-09162024\03012024__2024-03-01T12_36_20-Measurement 1\Images';

files = dir(fullfile(dataDir, '*.tiff'));

filenames = {files.name};

expr = '(r\d+c\d+f\d+)p.*';

%expr = 'r(?<row>\d+)c(?<col>\d+)f(?<field>\d+)p.*';
%%
out = regexp(filenames, expr, 'tokens');

allFN = cell(1, numel(out));
for ii = 1:numel(out)
    allFN{ii} = out{ii}{1}{1};
end

uniqueFields = unique(allFN);

%% Parse each image

outputDir = fileparts(dataDir);
outputDir = fullfile(outputDir, 'Exported');

if ~exist(outputDir, 'dir')
    mkdir(outputDir)
end

for iField = 1:numel(uniqueFields)

    currFiles = dir(fullfile(dataDir, [uniqueFields{iField}, '*.tiff']));
    currFilenames = {currFiles.name};

    expr = [uniqueFields{iField}, '.*-ch(?<ch>\d+)sk(?<t>\d+).*'];
    out = regexp(currFilenames, expr, 'names');

    allChannels = zeros(1, numel(out));
    allTimepoints = zeros(1, numel(out));

    for ii = 1:numel(out)

        allChannels(ii) = str2double(out{ii}.ch);
        allTimepoints(ii) = str2double(out{ii}.t);

    end

    channels = unique(allChannels);
    allTimepoints = unique(allTimepoints);

    %Assume no more than 3 channels
    if numel(channels) > 3
        keyboard
    end

    %Read an image to get the size
    I = imread(fullfile(currFiles(1).folder, currFiles(1).name));

    imgSize = size(I);

    %Create a video file
    vid = VideoWriter(fullfile(outputDir, [uniqueFields{iField}, '.avi']));
    vid.FrameRate = 7.5;
    open(vid)

    for frame = min(allTimepoints):max(allTimepoints)

        Irgb = zeros([imgSize, 3]);
        for channel = channels

            fn = [uniqueFields{iField}, 'p01-ch', int2str(channel), 'sk', int2str(frame), 'fk*.tiff'];

            file = dir(fullfile(dataDir, fn));
            if isequal(file, 0)
                continue
            else

                I = imread(fullfile(file.folder, file.name));

                I = double(I);
                I = (I - min(I(:)))/(max(I(:)) - min(I(:)));

                Irgb(:, :, channel) = I;

            end

        end

        writeVideo(vid, Irgb);
    end

    close(vid)



end

