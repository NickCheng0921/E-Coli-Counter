% written by Nick Cheng
function calibrateThreshold(testVideo)
%% read and binarize the image
clc;
close;
%rgbImage = imread('img1.png');
rgbImage = read(testVideo,1);

%default threshold value
levelVal = 0.3;

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
%default noise size
seSize = 0;

while(true)
    %get radius input and convert to a double
    seSize = inputdlg('Enter radius of filter in pixels, enter nothing to continue:',...
             'Sample', [1 50]); %seSize is a string
    if(seSize == "") 
        break
    end
    close;
    seSizeDoub = str2double(seSize{1});
    %apply noise filter and display results to user
    se = strel('disk', seSizeDoub);
    BWNew = imopen(BW, se);
    imshowpair(BWNew, rgbImage, 'montage');
end %of while loop

end