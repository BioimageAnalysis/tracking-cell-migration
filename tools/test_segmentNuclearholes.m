dataDir = 'Z:\transferred files-09162024\HaCat-EKAR-H2B-3rd-2__2024-09-06T15_46_58-Measurement 1\Images';

fn1 = 'r04c06f02p01-ch1sk63fk1fl1.tiff';
fn2 = 'r04c06f02p01-ch2sk63fk1fl1.tiff';

fn3 = 'r04c06f02p01-ch3sk63fk1fl1.tiff';

I1 = imread(fullfile(dataDir, fn1));
I2 = imread(fullfile(dataDir, fn2));
I3 = imread(fullfile(dataDir, fn3));


I = I1 + I2;

%%

Ib = imgaussfilt(I, 1);
Ic = imclose(Ib, strel('disk', 7));
Id = Ic - Ib;

Id = double(Id);
Id = (Id - min(min(Id)))/(max(max(Id)) - min(min(Id)));

I3 = double(I3);
I3 = (I3 - min(min(I3)))/(max(max(I3)) - min(min(I3)));

Ie = max(Id, I3);

imshow(Ie, [])

%%
mask = Ie > 0.05;
mask = imopen(mask, strel('disk', 2));

dd = -bwdist(~mask);
dd = imhmin(dd, 1);
dd(~mask) = -Inf;

LL = watershed(dd);

mask(LL == 0) = false;

mask = bwareaopen(mask, 20);

data = regionprops(mask, 'Circularity', 'PixelIdxList');
%histogram([data.Circularity])

for ii = 1:numel(data)
    if data(ii).Circularity < 0.5
        mask(data(ii).PixelIdxList) = false;
    end
end

%maskTooBig = bwareaopen(mask, 200);

imshowpair(I, bwperim(mask))