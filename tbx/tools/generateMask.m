function generateMask(inputFile)
%GENERATEMASK  Generate a mask from a TIFF stack
%
%  This is a utility function to use the segmentCells function in the
%  ECMCellTracker class to make a mask for manual correction. The function
%  expects that the input file be a TIFF-stack of the nuclei (i.e., the
%  raw images need to be stacked in the third dimension).

nFrames = numel(imfinfo(inputFile));

for iT = 1:nFrames

    I = imread(inputFile, iT);

    mask = ECMCellTracker.segmentCells(I, 1);

    %showoverlay(I, bwperim(mask))

    if iT == 1
        imwrite(mask, 'Mask.tif', 'Compression', 'none')
    else
        imwrite(mask, 'Mask.tif', 'Compression', 'none', 'writeMode', 'append')
    end
end

end