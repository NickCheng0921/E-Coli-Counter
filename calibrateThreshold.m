% written by Nick Cheng
%%  called once at start to get user input values for threshold value and
%%  filter size
function [seSizeDoub, levelVal] = calibrateThreshold(testVideo)
%% read and binarize the image
clc;
close;
rgbImage = read(testVideo,1);

%get user value for threshold
levelVal = 0.3;
% had an error before where BW isn't created on default threshold,
% redeclaring it here
BW = im2bw(rgbImage,levelVal);
BW = imcomplement(BW);
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
    %f1 = figure('Name', 'Threshold Selection Window');
    imshowpair(BW, rgbImage, 'montage');
end
disp('thresh level');
disp(levelVal);

%% remove noise with structuring elements
%seSize used to be default value, but it has some weird scalar error with
%strel now, if used as default?
seSizeDoub = 2;
while(true)
    %get radius input and convert to a double
    filterDialogue = inputdlg('Enter radius of filter in pixels, enter nothing to continue:',...
             'Sample', [1 50]); %seSize is a string
    if(filterDialogue == "") 
        break
    end
    seSizeDoub = str2double(filterDialogue{1});
    close;
    %apply noise filter and display results to user
    se = strel('disk', seSizeDoub);
    BWNew = imopen(BW, se);
    imshowpair(BWNew, rgbImage, 'montage');
end %of while loop

end