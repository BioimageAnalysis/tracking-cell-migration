clearvars
clc
close all

dataDir = 'Z:\CIC Datasets\qb-RPE-MDA-20250207__2025-02-07T18_09_39-Measurement 1\processed\20250411';

row = 3;
col = 6;
nFrames = 144;
deltaT = 15; %mins

%Bin all data together - storeCellCounts and storeInteractionData

files = dir(fullfile(dataDir, sprintf('r%02dc%02d*.mat', row, col)));

storeAllCounts_Red = zeros(1, nFrames);
storeAllCounts_Green = zeros(1, nFrames);

for iFile = 1:numel(files)

    load(fullfile(files(iFile).folder, files(iFile).name));

    storeAllCounts_Red = storeAllCounts_Red + storeCellCounts.Red;
    storeAllCounts_Green = storeAllCounts_Green + storeCellCounts.Green;

    figure(1);
    subplot(1, 2, 1)
    plot((1:144) * deltaT, storeCellCounts.Red);
    hold on
    subplot(1, 2, 2)
    plot((1:144) * deltaT, storeCellCounts.Green);
    hold on
end

figure(1)
subplot(1, 2, 1)
hold off
subplot(1, 2, 2)
hold off

%%
figure(2)
plot((1:144) * deltaT, storeAllCounts_Red)
hold on
plot((1:144) * deltaT, storeAllCounts_Green)
hold off

