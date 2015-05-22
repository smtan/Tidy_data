# script for Getting and Cleaning Data course assignment

features = readLines("features.txt") # read the features into a line to be used as column names

xtest <- read.table("X_test.txt", col.names=features) # read X test data
meancols = grep("mean+",  names(xtest)) # select mean column
stdcols = grep("std+", names(xtest)) # select standard deviation column
meantest <- xtest[,meancols] # subset only columns with mean values
stdtest <- xtest[,stdcols] # subset only columns with standard deviation values
xtest2 <- cbind(meantest, stdtest) # combine mean and standard deviation columns to form test file
ytest <- read.table("y_test.txt", col.names="Activity.labels")
ytest[ytest==1] <- "walking"
ytest[ytest==2] <- "walking_upstairs"
ytest[ytest==3] <- "walking_downstairs"
ytest[ytest==4] <- "sitting"
ytest[ytest==5] <- "standing"
ytest[ytest==6] <- "laying"
testsubject <- read.table("subject_test.txt", col.names="Subject.ID") # read subject ID file
testcom <- cbind(testsubject, ytest, xtest2) # form the combined test file

xtrain <- read.table("X_train.txt", col.names=features)
meancolstr = grep("mean+",  names(xtrain))
stdcolstr = grep("std+", names(xtrain))
meantrain <- xtrain[,meancolstr]
stdtrain <- xtrain[,stdcolstr]
xtrain2 <- cbind(meantrain, stdtrain)
ytrain <- read.table("y_train.txt", col.names="Activity.labels")
ytrain[ytrain==1] <- "walking"
ytrain[ytrain==2] <- "walking_upstairs"
ytrain[ytrain==3] <- "walking_downstairs"
ytrain[ytrain==4] <- "sitting"
ytrain[ytrain==5] <- "standing"
ytrain[ytrain==6] <- "laying"
trainsubject <- read.table("subject_train.txt", col.names="Subject.ID")
traincom <- cbind(trainsubject, ytrain, xtrain2)

combine <- rbind(traincom, testcom) # merge test and train files

library(plyr)
#library(dplyr) - alternate method to produce final summary table using dplyr summarise_each function
#combine %.%
#    group_by(Subject.ID, Activity.labels) %.%
#    summary.data <- summarise_each(funs(mean))


summary.data <- ddply(combine, .(Subject.ID, Activity.labels), colwise(mean)) # ddply function from plyr package

#write.table(summary.data, file="summary.csv", quote=FALSE, sep=",", row.names=FALSE) ## if csv file is required

write.table(summary.data, file="summary.txt", row.names=FALSE)# o/p to summary.txt; row.names=FALSE to avoid unwanted automated row identifiers which offsets data by 1 column