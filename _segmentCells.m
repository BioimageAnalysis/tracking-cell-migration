function mask = segmentCells(I, threshold)

I = double(I);

Idg1 = imgaussfilt(I, 4);
Idg2 = imgaussfilt(I, 1);

Idog = Idg2 - Idg1;

mask = Idog > 20;

% Idog = medfilt2(Idog, [3 3]);
% 
% tt = imregionalmax(Idog);
% tt = tt & mask;



% % 
% % Ifilt = imgaussfilt(I, 1);
% % 
% % Ifilt2 = imtophat(Ifilt, strel('disk', 10));
% % 
% % Ifilt2 = imadjust(Ifilt2);
% % 
% % mask = Ifilt2 > threshold;
% % 
% % % mask = imclose(mask, strel('disk', 2));
% % mask = imopen(mask, strel('disk', 1));
% % mask = bwareaopen(mask, 40);
% % 
dd = -bwdist(~mask);
dd(~mask) = false;
dd = imhmin(dd, 0.7);

L = watershed(dd);

mask(L == 0) = false;
mask = imclearborder(mask);


% Iout = double(I);
% Iout = (Iout - min(Iout, [], 'all'))/(0.5 .* max(Iout, [], 'all') - min(Iout, [], 'all'));
% 
% showoverlay(Iout, bwperim(mask));
