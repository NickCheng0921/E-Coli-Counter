% written by Nick Cheng
%%  called every frame to count bacteria and record positions
function thresholdExtract(counter, testVideo, levelVal, seSizeDoub, cellFile)
clc;
disp(counter);
rgbImage = read(testVideo, counter);

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

%% use feature analysis to find bacteria positions
idBacteria = find(eccentricities);
statsDefects = stats(idBacteria);
numBacteria = num2str(numObjects);

for id = 1 : length(idBacteria)
    cellXPos = statsDefects(id).BoundingBox(1);
    cellYPos = statsDefects(id).BoundingBox(2);
    fprintf(cellFile,'C%d %.1f %.1f ', id, cellXPos, cellYPos); %write positions to file
end %loop to write cell positions to text file
fprintf(cellFile, '\n');

%% display counted cells on an image every 100th frame
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
end %if statement end

end %function end