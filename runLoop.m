%written by NC
%video info, change vidName to select different videos
vidName = 'colivid.avi';
testVideo = VideoReader(vidName);
lastFrame = read(testVideo, inf);
nFrames = testVideo.NumberOfFrames;

cellFile = fopen('cellFile.txt', 'w');

%variables used in calibration function, threshold value and particle
%radius for filter
global levelVal seSizeDoub;
[seSizeDoub, levelVal] = calibrateThreshold(testVideo);
disp('calibration done');

%% analyze frame by frame  
close;
clc;
for i = 1 : nFrames
    counter = i;
    thresholdExtract(counter, testVideo, levelVal, seSizeDoub, cellFile);
end

fclose(cellFile);
%analyzePositions(nFrames);
