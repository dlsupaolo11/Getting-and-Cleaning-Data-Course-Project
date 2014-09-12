run_analysis <- function() {
        ## Call the data.tables packages
        library(data.table)
        library(reshape2)
        
        ## Set initial working directory
        if (!file.exists("R/Coursera")) {
                dir.create("R/Coursera")
        }
        
        ## Download and unzip files
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destFile = "getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
        dateDownloaded <- date()
        unzip("getdata-projectfiles-UCI HAR Dataset.zip")
        
        ## Set new working directory after unzipping folder
        setwd("UCI HAR Dataset")
        
        ## Read files into data tables
        activity_labelsDT <- read.table("activity_labels.txt")
        featuresDT <- read.table("features.txt")
        
        subject_testDT <- read.table("test\\subject_test.txt")
        X_testDT <- read.table("test\\X_test.txt")
        Y_testDT <- read.table("test\\Y_test.txt")
        
        subject_trainDT <- read.table("train\\subject_train.txt")
        X_trainDT <- read.table("train\\X_train.txt")
        Y_trainDT <- read.table("train\\Y_train.txt")
        
        ## Attach descriptive activity labels to the activity codes based on content in activity_labelsDT
        setnames(Y_testDT,"V1","ActivityCode")
        setnames(Y_trainDT,"V1","ActivityCode")
        
        for (i in 1:nrow(Y_testDT)) {
                Y_testDT[i, "ActivityLabel"] <- as.character(activity_labelsDT[activity_labelsDT$V1==Y_testDT[i,"ActivityCode"],"V2"])
        }
        
        for (i in 1:nrow(Y_trainDT)) {
                Y_trainDT[i, "ActivityLabel"] <- as.character(activity_labelsDT[activity_labelsDT$V1==Y_trainDT[i,"ActivityCode"],"V2"])
        }
        
        ## Rename subject_testDT and subject_trainDT columns to something descriptive
        setnames(subject_testDT,"V1","SubjectCode")
        setnames(subject_trainDT,"V1","SubjectCode")
        
        ## Attach descriptive labels to the training and test sets
        colnames(X_testDT) <- as.character(featuresDT[,"V2"])
        colnames(X_trainDT) <- as.character(featuresDT[,"V2"])
        
        ## Clip the subject, X, and Y test data sets together
        testDT <- cbind(subject_testDT, Y_testDT, X_testDT)
        
        ## Clip the subject, X, and Y train data sets together
        trainDT <- cbind(subject_trainDT, Y_trainDT, X_trainDT)
        
        ## Combine test and training data into one data set
        UCI_HAR_DT <- rbind(testDT, trainDT)
        
        ## Keep only subject, activity labels, and the measurements on the mean and standard deviation for each measurement
        tidyUCI_HAR_DT <- UCI_HAR_DT[ , grepl("SubjectCode", names(UCI_HAR_DT)) | grepl("ActivityLabel", names(UCI_HAR_DT)) | grepl("*-mean\\(\\)-*", names(UCI_HAR_DT)) | grepl("*-std\\(\\)-*", names(UCI_HAR_DT)) | grepl("*-meanFreq\\(\\)-*", names(UCI_HAR_DT))]

        ## Create a second, independent tidy data set with the average of each variable for each activity and each subject
        tidyUCI_HAR_DT2 <- dcast(melt(tidyUCI_HAR_DT,id=c(1:2),measure.vars=c(3:81)), SubjectCode + ActivityLabel ~ variable, mean)
        
        ## Prepend the word "Average" to the measure variables column names to make it more descriptive
        colnames(tidyUCI_HAR_DT2)[3:81] <- paste("Average ", colnames(tidyUCI_HAR_DT2)[3:81], sep = "")

        ## Write tidy table to a tab delimited text file
        write.table(tidyUCI_HAR_DT2, "run_analysis.txt", sep="\t", row.names = FALSE)
}