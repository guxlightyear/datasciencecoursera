# run_analysis.R
# This file provides the solution to the final project in course Getting and Cleaning Data
# Course provided by John Hopkins university in Coursera

# Project Instructions
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# The data used in this project has been originally sourced from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# 1. Merges the training and the test sets to create one data set.

# Read the information from the source data
features     = read.table('./UCI HAR Dataset/features.txt',header=FALSE); #imports features.txt
activityType = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE); #imports activity_labels.txt

subjectTrain = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); #imports y_train.txt

subjectTest  = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest        = read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE); #imports x_test.txt
yTest        = read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); #imports y_test.txt


# Add meaningful column names
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

colnames(subjectTest)  = "subjectId";
colnames(xTest)        = features[,2]; 
colnames(yTest)        = "activityId";

# Combine train data
trainingData = cbind(yTrain,subjectTrain,xTrain);

# Combine test data
testData = cbind(yTest,subjectTest,xTest);


# Merge train + test
combinedData = rbind(trainingData,testData);

# Column names (used elsewhere in this script)
colNames  = colnames(combinedData);



# 2. Extract only the measurements on the mean and standard deviation for each measurement.

# Subset the columns we are interested in: activityId, subjectId, mean and stanard deviations.
validColNames <- grepl("activityId|subjectId|.*-mean\\(\\)$|.*-std\\(\\)$", colNames)
combinedData <- combinedData[validColNames]



# 3. Uses descriptive activity names to name the activities in the data set

# Merging activity types with the resulting data set to get descriptive activity names
combinedData = merge(combinedData,activityType,by='activityId',all.x=TRUE);


# 4. Appropriately label the data set with descriptive activity names.
colNames  = colnames(combinedData); 

# Apply transformations to all column names
for (i in 1:length(colNames)) {
  # Make the t more explicit
  colNames[i] = gsub("^t","time_",colNames[i])
  
  # Make the f more explicit
  colNames[i] = gsub("^f","freq_",colNames[i])
  
  # Make the mean/std deviation more explicit
  colNames[i] = gsub("-std\\()$","_std",colNames[i])
  colNames[i] = gsub("-mean\\()$","_mean",colNames[i])
}
colnames(combinedData) = colNames;

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# Create a new table, combinedDAta without the activityType column
combinedData  = combinedData[,names(combinedData) != 'activityType'];

# Summarizing the combinedData table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(combinedData[,names(combinedData) != c('activityId','subjectId')],by=list(activityId=combinedData$activityId,subjectId = combinedData$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
