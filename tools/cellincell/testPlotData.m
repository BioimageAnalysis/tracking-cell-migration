clearvars
clc
load('test.mat')

dt = 896.44;
tt = (1:numel(storeCellCounts.Red)) * dt/(3600);

plot(tt, storeCellCounts.Red, 'r')
hold on
plot(tt, storeCellCounts.Green, 'g')
hold off
legend('Red cells', 'Green cells')
xlabel('Hours')
ylabel('Number of cells')

%% Interaction events

%Plot interaction length
storeInteractionData = struct;

for iTr = 1:LAP.NumTracks

    ct = getTrack(LAP, iTr);

    storeInteractionData(iTr).Length = ct.Frames(end) - ct.Frames(1) + 1;
    storeInteractionData(iTr).StartFrame = ct.Frames(1);
    storeInteractionData(iTr).EndFrame = ct.Frames(end);

end

%%
allLengths = cat(2, storeInteractionData.Length);

%Filter short events
allLengths(allLengths < 3) = [];

allLengths = allLengths * (dt/3600);
histogram(allLengths)

xlabel('Hours');
ylabel('Number of events')

%%
%Make a heatmap of events
eventHeatmap = zeros(numel(storeInteractionData), reader.NumFrames);

for ii = 1:numel(storeInteractionData)

    eventHeatmap(ii,storeInteractionData(ii).StartFrame:storeInteractionData(ii).EndFrame) = 1;
    
end

imshow(eventHeatmap)
xlabel('Frame')
ylabel('Event')