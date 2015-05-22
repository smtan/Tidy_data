 Codebook for Human Activity Recognition data cleanup– Coursera Getting and Cleaning Data


Subject.ID (1st column of dataset):

	ID of 30 volunteers for the activity analysis experiment
 	Integer 1 to 30


Activity.labels (2nd column of dataset):

	List of the 6 types of activities of data type character recorded during the experiment:

		Walking
		Walking_upstairs
		Walking_downstairs
		Sitting
		Standing
		Laying

		Each individual volunteer subject will perform all 6 of these activities. Hence there will be a total of
		180 (30 x 6) observations.


Measurements of activity signal column variables (all subsequent column of dataset):

	81 types of activity signals as column variables of data type numeric in the summary table (column data) of analysis. 
	The measurement signal values have been normalised between -1 and +1. X# at the beginning of each variable name denotes 
	identifier from the original larger dataset (see sample of final data at the end of this codebook).

		These measurement signals were used to estimate variables of the feature vector for each pattern:  
		'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

		tBodyAcc-XYZ
		tGravityAcc-XYZ
		tBodyAccJerk-XYZ
		tBodyGyro-XYZ
		tBodyGyroJerk-XYZ
		tBodyAccMag
		tGravityAccMag
		tBodyAccJerkMag
		tBodyGyroMag
		tBodyGyroJerkMag
		fBodyAcc-XYZ
		fBodyAccJerk-XYZ
		fBodyGyro-XYZ
		fBodyAccMag
		fBodyAccJerkMag
		fBodyGyroMag
		fBodyGyroJerkMag

		The set of variables that were estimated from these signals are: 

		mean(): Mean value
		std(): Standard deviation
		meanFreq(): Weighted average of the frequency components to obtain a mean frequency
		angle(): Angle between to vectors.

		Additional vectors obtained by averaging the signals in a signal window sample. These are 
		used on the angle() variable:

		gravityMean
		tBodyAccMean
		tBodyAccJerkMean
		tBodyGyroMean
		tBodyGyroJerkMean

	The full list of the measurement signal column variables used for the final dataset is appended here:
		1 tBodyAcc-mean()-X
		2 tBodyAcc-mean()-Y
		3 tBodyAcc-mean()-Z
		4 tBodyAcc-std()-X
		5 tBodyAcc-std()-Y
		6 tBodyAcc-std()-Z
		41 tGravityAcc-mean()-X
		42 tGravityAcc-mean()-Y
		43 tGravityAcc-mean()-Z
		44 tGravityAcc-std()-X
		45 tGravityAcc-std()-Y
		46 tGravityAcc-std()-Z
		81 tBodyAccJerk-mean()-X
		82 tBodyAccJerk-mean()-Y
		83 tBodyAccJerk-mean()-Z
		84 tBodyAccJerk-std()-X
		85 tBodyAccJerk-std()-Y
		86 tBodyAccJerk-std()-Z
		121 tBodyGyro-mean()-X
		122 tBodyGyro-mean()-Y
		123 tBodyGyro-mean()-Z
		124 tBodyGyro-std()-X
		125 tBodyGyro-std()-Y
		126 tBodyGyro-std()-Z
		161 tBodyGyroJerk-mean()-X
		162 tBodyGyroJerk-mean()-Y
		163 tBodyGyroJerk-mean()-Z
		164 tBodyGyroJerk-std()-X
		165 tBodyGyroJerk-std()-Y
		166 tBodyGyroJerk-std()-Z
		201 tBodyAccMag-mean()
		202 tBodyAccMag-std()
		214 tGravityAccMag-mean()
		215 tGravityAccMag-std()
		227 tBodyAccJerkMag-mean()
		228 tBodyAccJerkMag-std()
		240 tBodyGyroMag-mean()
		241 tBodyGyroMag-std()
		253 tBodyGyroJerkMag-mean()
		254 tBodyGyroJerkMag-std()
		266 fBodyAcc-mean()-X
		267 fBodyAcc-mean()-Y
		268 fBodyAcc-mean()-Z
		269 fBodyAcc-std()-X
		270 fBodyAcc-std()-Y
		271 fBodyAcc-std()-Z
		294 fBodyAcc-meanFreq()-X
		295 fBodyAcc-meanFreq()-Y
		296 fBodyAcc-meanFreq()-Z
		345 fBodyAccJerk-mean()-X
		346 fBodyAccJerk-mean()-Y
		347 fBodyAccJerk-mean()-Z
		348 fBodyAccJerk-std()-X
		349 fBodyAccJerk-std()-Y
		350 fBodyAccJerk-std()-Z
		373 fBodyAccJerk-meanFreq()-X
		374 fBodyAccJerk-meanFreq()-Y
		375 fBodyAccJerk-meanFreq()-Z
		424 fBodyGyro-mean()-X
		425 fBodyGyro-mean()-Y
		426 fBodyGyro-mean()-Z
		427 fBodyGyro-std()-X
		428 fBodyGyro-std()-Y
		429 fBodyGyro-std()-Z
		452 fBodyGyro-meanFreq()-X
		453 fBodyGyro-meanFreq()-Y
		454 fBodyGyro-meanFreq()-Z
		503 fBodyAccMag-mean()
		504 fBodyAccMag-std()
		513 fBodyAccMag-meanFreq()
		516 fBodyBodyAccJerkMag-mean()
		517 fBodyBodyAccJerkMag-std()
		526 fBodyBodyAccJerkMag-meanFreq()
		529 fBodyBodyGyroMag-mean()
		530 fBodyBodyGyroMag-std()
		539 fBodyBodyGyroMag-meanFreq()
		542 fBodyBodyGyroJerkMag-mean()
		543 fBodyBodyGyroJerkMag-std()
		552 fBodyBodyGyroJerkMag-meanFreq()
		555 angle(tBodyAccMean,gravity)
		556 angle(tBodyAccJerkMean),gravityMean)
		557 angle(tBodyGyroMean,gravityMean)
		558 angle(tBodyGyroJerkMean,gravityMean)
		559 angle(X,gravityMean)
		560 angle(Y,gravityMean)
		561 angle(Z,gravityMean)
		



Transformation from the original files:

	All original relevant raw files are downloaded into a working directory from which the data cleaning and transformation 
	are done. (url link for download of raw file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

	The 2 original raw files from the experiment consist of activity signal measurements for some volunteer subjects 
	participating in "training" and the rest in "test". The total number of volunteer subjects is 30 as mentioned 
	previously. Each of these 2 files are merged with their respective subject ID and activity list (walking, standing...)
	information and appended with the measurement signal variable names for the columns. 

	As we are interested only in the mean and standard deviation measurements of activity signal variables in their 
	respective columns, the rest of the columns of variables are filtered off. The 2 transformed files are then merged 
	to form a combined intermediate file. Using ddply function from the plyr library, a second, independent tidy data 
	set with the average of each variable for each activity and each subject is created. This is output as summary.txt.

	For reference, the code for the final calculation is:
	> summary.data <- ddply(combine, .(Subject.ID, Activity.labels), colwise(mean))

	where "combine" is the merged dataset prior to the final transformation to obtain the required average values for each
	activity and subject.



The final Data file:
	
 	This is stored as summary.txt in the same working directory. When downloaded and read with an appropriate program, there are 180 
	rows or observations and 81 columns of variables (described above). 
	


Notes: 
======
The instruction for this assignment states that the final output file should be in .txt format,  and this is done in the last line of
the R script. However, this format cannot be legibly read when using the usual WORD or NOTEPAD programs unless using R or RStudio 
read.table function. Hence a sample outout of this file is produced here for easy reference of the "tidiness" of the dataset 
(using read.table function):

=================================================================================================================================
Subject.ID		Activity.labels	X1.tBodyAcc.mean...X	X2.tBodyAcc.mean...Y	X3.tBodyAcc.mean...Z
1			laying		0.2215982		-0.040513953		-0.11320355	
1			sitting		0.2612376		-0.001308288		-0.10454418	
1			standing	0.2789176		-0.016137590		-0.11060182	

=================================================================================================================================	


