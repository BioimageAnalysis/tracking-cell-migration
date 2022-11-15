clearvars
clc

dataDir = 'H:\HaCaT movies-20221101\QB-20221028-HaCaT__2022-10-28T16_46_24-Measurement 2\Images';

vid = VideoWriter('test.avi');
vid.FrameRate = 5;
open(vid)

for iT = 1:10
    
    img = readImage(dataDir, 4, 6, 1, 2, iT);
    
    img = double(img);
    img = (img - min(img, [], 'all'))/(max(img, [], 'all') - min(img, [], 'all'));
    
    writeVideo(vid, img);

    
end

close(vid)