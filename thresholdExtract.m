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
    %imageRegion = regionprops(BWNew, 'centroid');
[labeled, numObjects] = bwlabel(BWNew, 4);
stats = regionprops(labeled,'Eccentricity', 'Area', 'BoundingBox');
    %areas = [stats.Area];
eccentricities = [stats.Eccentricity];
%% use feature analysis to count bacteria
idBacteria = find(eccentricities);
statsDefects = stats(idBacteria);
numBacteria = num2str(numObjects);
%% display results every 100th frame
if ~mod(counter, 100)
close;
figure, imshow(rgbImage);
hold on;
for id = 1 : length(idBacteria)
    h = rectangle('Position', statsDefects(id).BoundingBox); %draw box around bacteria
    set(h, 'EdgeColor', [.75 0 0]);
    hold on;
end
title(['There are ', numBacteria, ' bacteria in frame']);
hold off;
end
%writing numBacteria to File gives weird results, numObjects correctly
fprintf(cellFile,'%d\n', numObjects);

end