%written by NC
%video info, change vidName to select different videos
vidName = '02.19.2020-100uM-LRhamnose-1-3.avi';
testVideo = VideoReader(vidName);
lastFrame = read(testVideo, inf);
nFrames = testVideo.NumberOfFrames;

cellFile = fopen('cellFile.txt', 'w');

%variables used in calibration function, threshold value and particle
%radius for filter
global levelVal seSizeDoub;
[seSizeDoub, levelVal] = calibrateThreshold(testVideo);
disp('calibration done');
disp(seSizeDoub);
disp(levelVal);

%% analyze frame by frame  
close;
clc;
for i = 1 : nFrames
    counter = i;
    thresholdExtract(counter, testVideo, levelVal, seSizeDoub, cellFile);
end

fclose(cellFile);
analyzePositions(nFrames);