This README contains a list of the files and the steps performed to create a tidy dataset of the UCI HAR data.  The
final table created is a wide dataset and follows the principles of tidy data.  

The downloaded file can be read into a dataframe with the following command:
	tidydata <- read.table("./tidy_sensor_data.txt", header = TRUE)

The dataset includes the following files:
=========================================
- 'README.txt' : An explanation of the process of manipulating the signal dataset files into a tidy dataset.
- 'run_analysis.R' : R script merges training and test datasets collected from the accelerometers of the Samsung Galaxy S smartphone
- 'CODEBOOK.txt' :  
- 'tidy_sensor_data.txt' : Tidy data of sensor data created by run_analysis.R

The following data files were used from the UCI HAR Dataset:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Explanation of steps of analysis and script:
============================================
1. First, the features.txt is read into a table.  These are the names of the different signal readings.
2. A vector colIndexes is created for the column indexes of for the mean and standard deviation features.  This will 
	be used to subset the test and train data for only these columns.
2. The test signal data is read from the file X_test.txt into a data frame, using the featurenames vector from
	step 1 for the column names.
3. The test data is subset using the colIndexes vector.
4. The subject_test.txt file is read into a numeric vector.  Each line is the subject identifier and corresponds
	to an individual reading of the test data.
5. The vector from step 4 is added as a new column to the test data frame.
6. The y_test.txt file is read into vector.  Each line is an identifier for the type of activity the subject
	was performing for a signal reading and corresponds to an individual readin of the test data.
7. The vector from step 6 is added as a new column to the test data frame.
8 - 13  The same steps performed for test data are performed for the train data.
14. The test and train data frames are combined into a single data frame called alldata.
15. The activity_labels.txt file is read into a data frame.  Tie activityid to activity labels.
16. The alldata is merged with the activity labels to tie the activityid to the descriptive activity label.
17. Now that the descriptive column, activitylabel, is added, the activity id is removed.
18. The data is grouped by the subjectid and the activitylabel in grouped_data data frame.
19. A new data frame is created with the mean of each group of data readings.
20. The final tidy dataset is written to a text file with write.table.
 








