# Getting_and_cleaning_week4
Create tidy dataset from samsung data

The script run_analysis.R uses data in this file: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data should be placed in a working directory called "UCI HAR Dataset"

Descriptions of the variables are in the codebook.txt file

The script run_analysis.R is well commented and describes the steps used to transform
the raw data into a tidy dataset.

Here is a high level summary of what the script does:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.
