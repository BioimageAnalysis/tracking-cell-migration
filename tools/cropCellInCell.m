clearvars
clc

dataFolder = 'Y:\Jian''s work\Quanbin\hs\078c33ec-e2d4-43fe-8bed-8c928250327a\images\r02c06';

files = dir(fullfile(dataFolder, 'r02c06f01p01-ch01t*.tiff'));

vid = VideoWriter('r02c06f01_new.avi');
open(vid)
for iF = 1:numel(files)

    fn = sprintf('r02c06f01p01-ch01t%02d.tiff', iF);

    I_ch1 = imread(fullfile(files(iF).folder, fn));

    ch2FN = replace(fn, '-ch01', '-ch02');
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