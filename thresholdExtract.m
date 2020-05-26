% written by Nick Cheng
function thresholdExtract(counter, testVideo, levelVal, seSizeDoub, cellFile)
clc;
disp(counter);
rgbImage = read(testVideo, counter);

%use calibrated values
BW = im2bw(rgbImage,levelVal);
%flip black and white (easier to see)
BW = imcomplement(BW);

se = strel('disk', seSizeDoub);
BWNew = imopen(BW, se);

%% extract features
imageRegion = regionprops(BWNew, 'centroid');
[labeled, numObjects] = bwlabel(BWNew, 4);
stats = regionprops(labeled,'Eccentricity', 'Area', 'BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

%% use feature analysis to count bacteria
idBacteria = find(eccentricities);
statsDefects = stats(idBacteria);
numBacteria = num2str(numObjects);
%writing numBacteria to File gives weird results, numObjects correctly
%matches title image
fprintf(cellFile,'%d\n', numObjects);

end