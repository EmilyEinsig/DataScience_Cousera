# README file for Getting and Cleaning Data Course Project

## The R script called run_analysis.R: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Input Data
Source URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

Data background info: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



## Output Data
Data is written to run_analysis_output.txt file in working directory.


## Directions to run script:
1. Download run_analysis.R script into your working directory.
2. Download data and place into your working directory.
  a. Data must be in: (working directory)/UCI HAR Dataset folder structure. For example, the X_test.txt file should be found in (working directory)/UCI HAR Dataset/test.
3. In R console, type: source("run_analysis.R")

Output file will be created in the working directory upon script completion.