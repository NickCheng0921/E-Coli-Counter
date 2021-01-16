#Test Analysis Program for my Matlab E Coli Counter / Motion Tracker
from matplotlib import pyplot as plt
from PIL import Image
import os

images = []
#try catch mkdir already exists 
try:
    os.mkdir('Bacteria_Images')
except OSError:
    pass
#open File, has to be in same directory
testFile = open("cellFile.txt", 'r')
counter = 0
lineArr = []
#go line by line through file
for i in testFile:
    counter += 1
    lineArr = i.split()
    #get x values
    xVal = []
    for j in range(len(lineArr)):
        if((j)%3 == 1 or j==1):
            xVal.append(float(lineArr[j]))
    #get y values
    yVal = []
    for j in range(len(lineArr)):
        if((j)%3 == 2 or j==2):
            yVal.append(float(lineArr[j]))
    #display data
#color maps for scatterplot https://matplotlib.org/examples/color/colormaps_reference.html
    #color indexes are relative to each other based on t value, actual value doesn't matter
    t = []
    for j in range(len(xVal)):
        t.append(1)
    fig = plt.scatter(xVal,yVal, c = t, cmap = "spring")
    plt.title("Frame " + str(counter))
    #Images takes pngs and appends them to images[]
    #I have not yet found a way to append a pyplot plot to the images[] directly
    plt.savefig('Bacteria_Images/bacteriaPlot' + str(counter) + '.png')
    images.append(Image.open('Bacteria_Images/bacteriaPlot' + str(counter) + '.png'))
    plt.show()
    #break 

testFile.close()

#convert data to gif 
images[0].save('bacteria.gif', save_all=True, append_images=images[1:], optimize=False, duration=40, loop=0)
print("Program Finished")
