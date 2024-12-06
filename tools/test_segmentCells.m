%This script is for debugging/optimizing nuclear segmentation

file = 'Z:\11012024\Hacat-EKAR-H2BmCherry-1\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1\Images\r02c02f03p01-ch3sk2fk1fl1.tiff';

Inucl = imread(file);

masks = ECMCellTracker.segmentCells(Inucl, 20);

Iout = double(Inucl);
Iout = (Iout - min(Iout(:)))/(max(Iout(:)) - min(Iout(:)));


imshowpair(imadjust(Iout), bwperim(masks))


