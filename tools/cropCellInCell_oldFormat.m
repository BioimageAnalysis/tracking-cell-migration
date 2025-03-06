clearvars
clc

dataFolder = 'Y:\Jian''s work\Quanbin\qb-RPE-MDA-20250207__2025-02-07T18_09_39-Measurement 1\Images';

files = dir(fullfile(dataFolder, 'r02c07f04*-ch1sk*.tiff'));

vid = VideoWriter('r02c07f04_duplicate.avi');
open(vid)
for iF = 1:numel(files)

    fn = sprintf('r02c07f04p01-ch1sk%dfk1fl1.tiff', iF);

    I_ch1 = imread(fullfile(files(iF).folder, fn));

    ch2FN = replace(fn, '-ch1', '-ch2');
    I_ch2 = imread(fullfile(files(iF).folder, ch2FN));

    %Normalize both images
    I_ch1_norm = double(I_ch1);
    I_ch1_norm = (I_ch1_norm - min(I_ch1_norm(:)))/(max(I_ch1_norm(:)) - min(I_ch1_norm(:)));

    I_ch2_norm = double(I_ch2);
    I_ch2_norm = (I_ch2_norm - min(I_ch2_norm(:)))/(max(I_ch2_norm(:)) - min(I_ch2_norm(:)));

    I_rgb = cat(3, I_ch1_norm, I_ch2_norm, zeros(size(I_ch1_norm)));

    %imshow(I_rgb, [])

    writeVideo(vid, I_rgb)

end
close(vid)