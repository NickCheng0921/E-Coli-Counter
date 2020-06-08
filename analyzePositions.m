function analyzePositions(nFrames)
clc;
close;
cellFile = fopen('cellFile.txt', 'r');
%only plots last frame right now
for i = 1 : 1
    fileRow = fgetl(cellFile);
    x = split(fileRow, "C");
    x(1) = []; %split leaves an empty element at start, this removes it
end
%get x and y values from cell text file for specific frame
xVal = [];
yVal = [];
for i = 1 : length(x)
    val  = split(x(i), " ");
    xVal(end + 1) = str2double(val(1));
    yVal(end + 1) = str2double(val(2));
end

fig1 = figure;
h = scatter(xVal, yVal);
set(h, 'Marker', 'square');
saveas(fig1, 'figure1.png');
