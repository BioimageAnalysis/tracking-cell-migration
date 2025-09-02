clearvars
clc

fpath = 'D:\Work\Research\HaCat-cell-migration\data\20250902';
fn = 'r03c04f01p01';

cmap = colormap('hot');

vid = VideoWriter(fullfile(fpath, [fn, '_ratio.avi']));
vid.FrameRate = 7.5;
open(vid)

for iT = 1:288

    I_ch1 = double(imread(fullfile(fpath, [fn, '_ch1.tif']), iT));
    I_ch2 = double(imread(fullfile(fpath, [fn, '_ch2.tif']), iT));

    I_ratio = ((I_ch2 ./ I_ch1)/2) + 0.00001;
    I_ratio(I_ratio > 1) = 1;
    I_ratio = uint8(I_ratio * 255);

    I_rgb = cat(3, cmap(I_ratio + 1, 1), ...
        cmap(I_ratio + 1, 2), cmap(I_ratio + 1, 3));
    I_rgb = reshape(I_rgb, 609, 638, []);

    writeVideo(vid, I_rgb);
end

close(vid)