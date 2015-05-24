

###############################################################################
# Step 1. Merge the training and the test sets to create one data set.
###############################################################################
# set file variables 
featurefile <- "./UCI HAR Dataset/features.txt"
activityfile <- "./UCI HAR Dataset/activity_labels.txt"
testfile.X <- "./UCI HAR Dataset/test/X_test.txt"
testfile.Y <- "./UCI HAR Dataset/test/Y_test.txt"
testfile.Subject <- "./UCI HAR Dataset/test/subject_test.txt"
trainfile.X <- "./UCI HAR Dataset/train/X_train.txt"
trainfile.Y <- "./UCI HAR Dataset/train/Y_train.txt"
trainfile.Subject <- "./UCI HAR Dataset/train/subject_train.txt"


# Load X data.  
features <- read.csv(featurefile, sep=" ", header=FALSE)
initial <- read.table(testfile.X, header=FALSE, nrows=100)
classes <- sapply(initial, class)
testData.X <- read.table(testfile.X, col.names=features$V2, colClasses=classes)
trainData.X <- read.table(trainfile.X, col.names=features$V2, colClasses=classes)

# Load Y data 
testData.Y <- read.table(testfile.Y, col.names="activityId")
trainData.Y <- read.table(trainfile.Y, col.names="activityId")

# Load Subject data
testData.Subject <- read.table(testfile.Subject, col.names="subject")
trainData.Subject <- read.table(trainfile.Subject, col.names="subject")

# Combine activity (Y), subjects (Subject) and measurements (X) by columns with cbind()
testData <- cbind(testData.Y, testData.Subject, testData.X)
trainData <- cbind(trainData.Y, trainData.Subject, trainData.X)

# Combine test and train to be one dataset with rbind()
combinedData <- rbind(testData, trainData)

###############################################################################
# Step 2: Extracts only the measurements on the mean and standard deviation 
# for each measurement.
###############################################################################
# Use grep() with a regex statement that isolate the correct columns to keep
columnNames <- names(combinedData)
meanAndStdOnly <- grep("activityId|subject|\\.mean\\.|\\.std\\.", columnNames, ignore.case = "TRUE")

# Create new dataset with the correct columns
combinedData.MeanAndStdOnly <- combinedData[,meanAndStdOnly]

# Code for checking my work
# head(combinedData.MeanAndStdOnly)
# combinedData.MeanAndStdOnly[1:10, 1:8 ]
# nrow(combinedData.MeanAndStdOnly)


###############################################################################
# Step 3: Use descriptive activity names to name the activities in the data set
###############################################################################
# get the Activity names from the activity file
activityData <- read.table(activityfile, col.names=c("activityId", "activity"))

# I will be merging two data sets by their common column "activityId".
combinedData.MeanAndStdOnly.WithActivityName <- merge(activityData, combinedData.MeanAndStdOnly) 

# Remove the activityId column from the data set since I now have the name
combinedData.MeanAndStdOnly.WithActivityName$activityId <- NULL

# Code to validate this step
# head(combinedData.MeanAndStdOnly.WithActivityName)


###############################################################################
# Step 4: Appropriately labels the data set with descriptive variable names. 
###############################################################################
# This  step was already done when I designated the "col.names=features$V2" 
# when reading the table.

###############################################################################
# Step 5: From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
###############################################################################
# Use dplyr's group_by() and summarise_each() funtions.
library(dplyr)
tidyData <- group_by(combinedData.MeanAndStdOnly.WithActivityName, subject, activity) %>% summarise_each(funs(mean))

write.table(tidyData, file="tidyData.txt", row.name=FALSE)

