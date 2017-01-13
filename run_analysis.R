# Chris Schroeder
# Coursera, Getting and Cleaning Data
# January 8, 2017
# Course Project

run_analysis <- function() {
    
    library(dplyr)
    setwd("C:/Users/schroc/Documents/Coursera/CleaningData/FinalProject")
    
    # read activity_labels.txt into a table
    # shows information about the variables used on the feature vector
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                                 col.names = c("activityid", "activityname"),
                                 stringsAsFactors = FALSE)
    
    # read features.txt into a table
    # list of all features
    features <- read.table("./UCI HAR Dataset/features.txt",
                           col.names = c("featureid", "featurename"),
                           stringsAsFactors = FALSE)
    
    # Create vector of mean and std column indices to subset data
    colIndexes <- c(grep("mean", features$featurename), grep("std", features$featurename))
    
    
    ##################################
    ##  read test data into tables  ##
    ##################################
    
    # X_test.txt
    # test data set
    # column names set to character vector of all feature names
    testdata <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$featurename)
    
    # Extracts only the measurements on the mean and standard deviation for each measurement
    testdata <- testdata[,colIndexes]
    
    # subject_test.txt 
    # Each row identifies the subject who performed the activity for each window sample.
    # Its range is from 1 to 30.
    subjectTest <- scan("./UCI HAR Dataset/test/subject_test.txt", what = integer())
    # add subjectid column to testdata
    testdata$subjectid <- subjectTest
    
    # y_test.txt
    # labelids for each testdata obvservation, which correspond to the 6 activity names
    #testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activityid")
    testlabels <- scan("./UCI HAR Dataset/test/y_test.txt", what = integer())
    
    # add column for activityid to testdata from testlabels to tie type of activity
    #   to each observation
    testdata$activityid <- testlabels
    
    
    ###################################
    ##  read train data into tables  ##
    ###################################
    
    # X_train.txt
    # train data set
    # column names set to character vector of all feature names
    traindata <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$featurename)
    
    # Extracts only the measurements on the mean and standard deviation for each measurement
    traindata <- traindata[,colIndexes]
    
    # subject_train.txt 
    # Each row identifies the subject who performed the activity for each window sample.
    # Its range is from 1 to 30.
    subjectTrain <- scan("./UCI HAR Dataset/train/subject_train.txt", what = integer())
    # add subjectid column to testdata
    traindata$subjectid <- subjectTrain
    
    # y_train.txt
    # labelids for each traindata obvservation, which correspond to the 6 activity names
    # traionlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activityid")
    trainlabels <- scan("./UCI HAR Dataset/train/y_train.txt", what = integer())
    
    # add column for activityid to traindata from trainlabels to tie type of activity
    #   to each observation
    traindata$activityid <- trainlabels
    
    
    
    ###########################
    ##  Combine data frames  ##
    ###########################
    alldata <- rbind(testdata,  traindata)
    
    
    
    # merge activityLabels and alldata on activityid. The activity labels for each obvervation
    #   will be added to test data
    merged_data <- merge(alldata, activityLabels)
    
    # remove acitivityid, since activity name has replaced it as a descriptive version
    merged_data <- merged_data[ , !(names(merged_data) %in% "activityid")]
    
    
    # group the existing tidy dataset by 
    # not completely sure if this is how the data should be grouped... yet
    grouped_data <- group_by(merged_data, subjectid, activityname, add = TRUE)
    
    
    # create new tidy data set with the average of each variable for each activity and each subject.
    groupmean_data <- summarize_each(grouped_data, funs(mean))
    
    
    # Write table to file
    write.table(groupmean_data, "./tidy_sensor_data.txt", row.names = TRUE)
    
    
    # Test reading the file, 
    # testread <- read.table("./tidy_sensor_data.txt", header = TRUE)
}




