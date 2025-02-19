clearvars
clc

cpmask = 'X:\ML data\predictions\cellpose_1739921107\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1_r2c2f3_masks.tiff';

gtmask = 'X:\ML data\validation\QB-Hacat-EKAR-H2BmCherry-11012024__2024-11-01T16_56_55-Measurement 1_r2c2f3_masks.tiff';

for iF = 1

    Icp = imread(cpmask, iF);
    Icp_mask = Icp > 0;

    Igt = imread(gtmask, iF);

    %Do simple comparisons

    diffMask = Igt - Icp_mask;

    imshow(diffMask, [])

    


end