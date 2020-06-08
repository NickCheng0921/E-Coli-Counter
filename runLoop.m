%written by NC
%video info
vidName = '02.19.2020-100uM-LRhamnose-1-3.avi';
testVideo = VideoReader(vidName);
lastFrame = read(testVideo, inf);
nFrames = testVideo.NumberOfFrames;

cellFile = fopen('cellFile.txt', 'w');

%variables used in calibration function
global levelVal seSizeDoub;
calibrateThreshold(testVideo);

%% analyze frame by frame  
close;
clc;
for i = 1 : nFrames
    counter = i;
    thresholdExtract(counter, testVideo, levelVal, seSizeDoub, cellFile);
end

fclose(cellFile);
analyzePositions(nFrames);