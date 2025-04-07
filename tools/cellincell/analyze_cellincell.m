clearvars
clc

reader = HarmonyReader('Z:\CIC Datasets\qb-RPE-MDA-20250207__2025-02-07T18_09_39-Measurement 1\hs');

for iT = 1:reader.NumFrames

    Ired = readImage(reader, 2, 6, 2, 1, 1, iT);
    Igreen = readImage(reader, 2, 6, 2, 1, 2, iT);

    % figure(1)
    maskRed = imbinarize(Ired, 'adaptive');
    maskRed = imopen(maskRed, strel('disk', 3));
    % showoverlay(Ired, bwperim(maskRed))

    maskGreen = imbinarize(Igreen, 'adaptive');
    maskGreen = imopen(maskGreen, strel('disk', 3));
    % figure(2);
    % showoverlay(Igreen, bwperim(maskGreen))

    %%
    maskOverlap = maskGreen & maskRed;
    maskOverlap = imfill(maskOverlap, 'holes');
    maskOverlap = bwareaopen(maskOverlap, 100);

    Ired_norm = double(Ired);
    Ired_norm = (Ired_norm - min(Ired_norm(:)))/(max(Ired_norm(:)) - min(Ired_norm(:)));

    Igreen_norm = double(Igreen);
    Igreen_norm = (Igreen_norm - min(Igreen_norm(:)))/(max(Igreen_norm(:)) - min(Igreen_norm(:)));

end