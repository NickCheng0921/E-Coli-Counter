#Test Analysis Program for my Matlab E Coli Counter / Motion Tracker
from matplotlib import pyplot as plt
#open File, has to be in same directory
testFile = open("cellFile.txt", 'r')
#go line by line through file
for i in testFile:
    lineArr = i.split()
    #get x values
    xVal = []
    for j in range(len(lineArr)):
        if((j-1)%4 == 0 or j==1):
            xVal.append(float(lineArr[j]))
    #get y values
    yVal = []
    print()
    for j in range(len(lineArr)):
        if((j-2)%4 == 0 or j==2):
            yVal.append(float(lineArr[j]))
    #get minAxis of fitted ellipse
    axis = []
    print()
    for j in range(len(lineArr)):
        if((j-3)%4 == 0 or j==3):
            axis.append(float(lineArr[j]))
    #display data
    fig = plt.scatter(xVal,yVal)
    #break #only test 1 line for now
testFile.close()

print("Program Finished")