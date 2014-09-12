---
title: "Getting-and-Cleaning-Data-Course-Project Codebook"
author: "Paolo Suarez"
date: "Friday, September 12, 2014"
output: html_document
---



##### Raw data:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

##### Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by - the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

##### Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

##### Objectives:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

##### Codebook:

1. The data.tables packages data.table and reshape2 were called
2. Initial working directory set to "R/Coursera"
3. Files were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped 
4. Set new working directory to "UCI HAR Dataset" after unzipping folder
5. All listed files were into corresponding data sets
- activity_labelsDT
- featuresDT
- subject_testDT
- X_testDT 
- Y_testDT
- subject_trainDT
- X_trainDT
- Y_trainDT
6. Changed "V1" column names to "ActivityCode" for the data sets:
- Y_testDT
- Y_trainDT
7. Added a column to the tables in Step 6 called "ActivityLabel" with activity name values from *activity_labelsDT* correspding to the activity codes
8. Changed "V1" column names to "SubjectCode" for the following data sets:
- subject_testDT
- subject_trainDT
9. Changed column names to describe the actual features based on the listed features in **featuresDT** for the following data sets:
- X_testDT
- X_trainDT
10. Joined the subjects, activities, and feature *test* data by clipping the subject, X, and Y test data sets together using ```cbind()``` into **testDT**
10. Joined the subjects, activities, and feature *train* data by clipping the subject, X, and Y test data sets together using ```cbind()``` into **trainDT**
12. Combined the test and training data sets into one combined data set using ```rbind()``` into **UCI_HAR_DT**
13. Removed uneeded columns and kept only the subject, activity labels, and the measurements on the mean and standard deviation for each measurement and saving the resulting data set into **tidyUCI_HAR_DT**
14. Created a second, independent tidy data set with the average of each variable for each activity and each subject into **tidyUCI_HAR_DT2**
15. Prepended the word "Average" to the measure variables / feature column names to make it more descriptive in **tidyUCI_HAR_DT2**, since the average of the measures are stored
16. Wrote the final tidy table to a tab delimited text file called *run_analysis.txt* and ommitted the row names
