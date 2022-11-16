clearvars
clc

dataDir = 'H:\HaCaT movies-20221101\QB-20221028-HaCaT__2022-10-28T16_46_24-Measurement 2\Images';

LAP = LAPLinker;
LAP.TrackDivision = true;
LAP.DivisionScoreRange = [0 20];

vid = VideoWriter('test.avi');
vid.FrameRate = 5;
open(vid)

for iT = 1:102
    
    I = readImage(dataDir, 4, 6, 1, 1, iT);
    
    %%
    mask = imbinarize(I, 'adaptive', 'Sensitivity', 0.2);
    mask = imclose(mask, strel('disk', 2));
    mask = imopen(mask, strel('disk', 1));
    
    mask = imclearborder(mask);
    mask = bwareaopen(mask, 50);
    
    dd = -bwdist(~mask);
    dd(~mask) = false;
    dd = imhmin(dd, 1);
    
    L = watershed(dd);
    
    mask(L == 0) = false;
    
    data = regionprops(mask, 'Centroid');
    
    LAP = assignToTrack(LAP, iT, data);
    
    Iout = double(I);
    Iout = (Iout - min(Iout, [], 'all'))/(max(Iout, [], 'all') - min(Iout, [], 'all'));
    
    Iout = showoverlay(Iout, bwperim(mask));
    for iAT = LAP.activeTrackIDs
        ct = getTrack(LAP, iAT);
        Iout = insertText(Iout, ct.Centroid(end, :), int2str(iAT), ...
            'TextColor', 'white', 'BoxOpacity', 0);
    end
    
    writeVideo(vid, Iout);
    
end
close(vid)

% imshowpair(imadjust(I), bwperim(mask))



