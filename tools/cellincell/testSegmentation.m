clearvars
clc

A = cicAnalyzer;
analyzeImage(A)

Ired = readImage(reader, 2, 6, 2, 1, 1, 144);
Igreen = readImage(reader, 2, 6, 2, 1, 2, 144);

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

%%
Irgb = cat(3, Ired_norm, 1.5 * Igreen_norm, zeros(size(Ired), 'double'));

showoverlay(Irgb, bwperim(maskOverlap), 'color', [1 1 1])

