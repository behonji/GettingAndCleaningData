# GettingAndCleaningData
This repository contains code for the class project.

## R Code
The R code to run is in the file named "run_analysis.R".  This code assumes that you have
downloaded the data for the project in the working directory.  The data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Folder Structure
The downloaded data contains a folder named "UCI HAR Dataset" that has all the subfolders 
and files within it.  Both the "run_analysis.R" file and the "UCI HAR Dataset" folder should be
in the working directory.

After running the script in run_analysis.R, a file named tidyData.txt will be created.

## How to read the data
You can read this file by running the following R script.

data <- read.table("tidyData.txt", header = TRUE)

## What the run_analysis.R file does
The file is documented internally to correspond to the 5 steps in the project.

Step 1: Combine the data to one data set.
The source data is broken up into test and training data.  It also has the activities and
subjects in separate files.  The code combines these four sets of data by adding the activity and subject as columns to both the test and training data.  Then uses a row binding technique to combine the test and training data.

Step 2: Only get Mean and Standard Deviation columns
The code extracts only the measurements of the mean and standard deviation columns. 

Step 3: Get Activity Names
The code uses a merge to join to the text name of the activity

Step 4: Appropriately label the data set variables
This was actually done in the load process.

Step 5: Create a separate tidy data set
With one pipeline command, the code summarizes (gets the mean) the variables by subject and activity.