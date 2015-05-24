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
