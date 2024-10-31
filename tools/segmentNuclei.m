file = 'Z:\cropped datasets\dataset1\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1r02c02f02_ch3.tif';
%file = 'Z:\cropped datasets\dataset2\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1r02c03f01_ch3.tif';
%file = 'Z:\cropped datasets\dataset3\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1r02c04f01_ch3.tif';

%file = 'Z:\cropped datasets\dataset4\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1r02c05f02_ch3.tif';

nFrames = numel(imfinfo(file));

dirOut = fileparts(file);

for iFrame = 1:nFrames

    I = imread(file, iFrame);

    % mask = ECMCellTracker.segmentHoles(I, 5);
    % 
    % CC = bwlabel(mask);

    if iFrame == 1
        imwrite(CC, fullfile(dirOut, 'mask_holes.tif'), 'Compression', 'none')
    else
        imwrite(CC, fullfile(dirOut, 'mask_holes.tif'), 'Compression', 'none', 'writeMode', 'append')
    end

end

I = imread(file, iFrame);

labels = zeros(size(I), 'uint16');
for iFrame = 1:nFrames

    if iFrame == 1
        imwrite(CC, fullfile(dirOut, 'mask_holes.tif'), 'Compression', 'none')
    else
        imwrite(CC, fullfile(dirOut, 'mask_holes.tif'), 'Compression', 'none', 'writeMode', 'append')
    end

end