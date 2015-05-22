Getting and Cleaning Data course assignment repositories for script and relevant files
==================================================================
Human Activity Recognition data cleaning for Coursera Getting and Cleaning Data course

==================================================================

smtan@gmail.com

==================================================================
Brief for cleaning of data:

This experiment provided 2 original raw files consisting of activity signal measurements for some volunteer subjects 
participating in "training" and the rest in "test" as well as other related ID and activities information. The total number 
of volunteer subjects is 30. All the relevant raw files and information are downloaded into a working directory before any
transformation and analysis are done. 

The raw files and relevant information download into the working directories are:

(url link for download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


y_test.txt (activity list file containing numbers corresponding to the activity_labels file)
X_test.txt (measurement signal file)
subject_test.txt (volunteer subject ID file for test cases)
subject_train.txt (volunteer subject ID file for train cases)
y_train.txt (activity list file containing numbers corresponding to the activity_labels file)
X_train.txt (measurement signal file)
features.txt  (list of all 561 the measurement signal variable names) 
activity_labels.txt (list of activities such as standing, sitting and walking)


Each of these 2 measurement files (x_test.txt and x_train.txt) are merged with their respective subject ID and activity list 
information (y_test and y_train files) and appended with the variables names for the columns. As we are interested only in the 
mean and standard deviation measurements of activity signal variables in their respective columns, the rest of the columns of 
variables are filtered off. 

The 2 transformed files are then merged to form a combined intermediate file. Using ddply function from the plyr library, a second, 
independent tidy data set with the average of each variable for each activity and each subject is created. This is output as 
summary.txt, consisting of 180 observations and 81 columns of variables that meets the principle of tidy data. Note however that the
.txt file cannot be legibly read using the usual WORD and NOTEPAD programs. A sample of the final tidy data is found in the codebook.

======================================


The dataset includes the following files/information:
====================================================

- 'README.md' (this file)

- 'codebook.md" describing the variables, the data, and transformations or work performed to clean up the data.

-  a link to a Github repository with the script for performing the analysis.

-  the final cleaned data can be read into R using read.table("summary.txt", header=TRUE)

-  the R script for the transformation and cleaning is included here:
-----------------

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

summary.data <- ddply(combine, .(Subject.ID, Activity.labels), colwise(mean)) # ddply function from plyr package

write.table(summary.data, file="summary.txt", quote=FALSE, sep=",", row.names=FALSE) # o/p to summary.txt; 
		#row.names=FALSE to avoid unwanted automated row identifiers which offsets data by 1 column

-----------------------------

Notes: 
======
The instruction for this assignment states that the final output file should be in .txt format,  and this is done in the last line of the R script. However, this format cannot be legibly read when using the usual WORD or NOTEPAD programs.

