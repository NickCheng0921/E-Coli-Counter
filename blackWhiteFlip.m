%% read and binarize the image
rgbImage = imread('img1.png');
while(true)
    %break;
    level = inputdlg('Enter threshold level between 0 and 1, enter nothing to continue:',...
             'Sample', [1 50]);
    if(level == "") 
        break
    end
    close;
    %convert dialog box threshold input to a double
    levelVal = str2double(level{1});
    %binarize image
    BW = im2bw(rgbImage,levelVal);
    %flip black and white (easier to see)
    BW = imcomplement(BW);
    %create figure and display results
    f1 = figure('Name', 'Threshold Selection Window');
    imshowpair(BW, rgbImage, 'montage');
end

%% remove noise with structuring elements
while(true)
    %get radius input and convert to a double
    seSize = inputdlg('Enter radius of filter in pixels, enter nothing to continue:',...
             'Sample', [1 50]);
    if(seSize == "") 
        break
    end
    close;
    seSizeDoub = str2double(seSize{1});
    %apply noise filter and display results to user
    se = strel('disk', seSizeDoub);
    BWNew = imopen(BW, se);
    imshowpair(BWNew, rgbImage, 'montage');
end

%% extract features
imageRegion = regionprops(BWNew, 'centroid');
[labeled, numObjects] = bwlabel(BWNew, 4);
stats = regionprops(labeled,'Eccentricity', 'Area', 'BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

%% use feature analysis to count bacteria
idBacteria = find(eccentricities);
statsDefects = stats(idBacteria);

figure, imshow(rgbImage);
hold on;
for id = 1 : length(idBacteria)
    h = rectangle('Position', statsDefects(id).BoundingBox); %draw box around bacteria
    set(h, 'EdgeColor', [.75 0 0]);
    hold on;
end
if id > 10
    title(['There are', num2str(numObjects), 'bacteria in frame']);
end
hold off;