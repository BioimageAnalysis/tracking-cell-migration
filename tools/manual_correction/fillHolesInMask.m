function fillHolesInMask(fileIn)
%FILLHOLESINMASK  Fills holes in mask
%
%  FILLHOLESINMASK(FILE) will fill holes in a TIFF stack. The idea is to
%  use it to fill in holes from manual correction of cell masks.

nFrames = numel(imfinfo(fileIn));

[fpathOut, fnameOut] = fileparts(fileIn);

for iT = 1:nFrames

    mask = imread(fileIn, iT);
    mask = mask > 0;
    mask = imfill(mask, 'holes');

    if iT == 1
        imwrite(mask, fullfile(fpathOut, [fnameOut, '_filled.tif']), 'compression', 'none')
    else
        imwrite(mask, fullfile(fpathOut, [fnameOut, '_filled.tif']), 'compression', 'none', 'writemode', 'append')
    end
    

end


end