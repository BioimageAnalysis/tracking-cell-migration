function mask = segmentCells(I, threshold)

Ifilt = imgaussfilt(I, 1);
Ifilt2 = imtophat(Ifilt, strel('disk', 10));

mask = Ifilt2 > threshold;

% mask = imclose(mask, strel('disk', 2));
mask = imopen(mask, strel('disk', 1));

mask = imclearborder(mask);
mask = bwareaopen(mask, 50);

dd = -bwdist(~mask);
dd(~mask) = false;
dd = imhmin(dd, 0.7);

L = watershed(dd);

mask(L == 0) = false;

