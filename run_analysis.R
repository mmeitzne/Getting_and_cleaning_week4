

#Data from this location needs to be placed in a workind directory called
#"UCI HAR Dataset" for the following script to work
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

setwd("~/R/UCI HAR Dataset")
library(dplyr)
# *****************************************************************************

# 1. Merges the training and test datasets into one set

# Read then merge training and test data sets.
train.data <- read.table("train/X_train.txt")
test.data <- read.table("test/X_test.txt")
combined.data <- rbind(train.data, test.data)


# *****************************************************************************

# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement.

# Read the features text file
features <- read.table("features.txt", col.names=c("col", "name"))

# Get only mean and standard deviation measurements for each measurement

meanstd.features <- features[grepl("mean()", features$name, fixed=TRUE) |
                                     grepl("std()", features$name, fixed=TRUE),]

# Extract only mean and standard deviation data.
combined.meanstd.data <- combined.data[, meanstd.features$col]

# *****************************************************************************

# 3. Uses descriptive activity names to name the activities in the data set

# Read activity labels text file
activity <- read.table("activity_labels.txt", col.names=c("id", "name"))

# Read then merge training and test activity label text files
train.activity <- read.table("train/y_train.txt", col.names="id")
test.activity <- read.table("test/y_test.txt", col.names="id")
combined.activity <- rbind(train.activity, test.activity)

# Create names from activity label ids;  keep only names
combined.activity$name <- activity[combined.activity$id,]$name
combined.activity <- combined.activity[,"name", drop=FALSE]

# *****************************************************************************

# 4. Appropriately labels the data set with descriptive variable names.

# Read then merge subject lists
train.subject <- read.table("train/subject_train.txt", col.names="id")
test.subject <- read.table("test/subject_test.txt", col.names="id")


# Change subjects to factors so grouping can be performed
combined.subject$id <- as.factor(combined.subject$id)

# Bring subjects, activities and their means and stdevs together into the first 
# tidy dataset
tidy.data <- cbind(combined.subject, combined.activity, combined.meanstd.data)

# Set variable names of Tidy Data Set 1.
names(tidy.data) <- c("subject", "activity", as.character(meanstd.features$name))

# *****************************************************************************

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject


# Find avg for each variable by subject and activity and put it 
# into second tidy dataset

tidy.data.v2 <- tidy.data %>% group_by(subject, activity) %>%
        summarise_each(funs(mean))

# Set variable names of second tidy dataset
names(tidy.data.v2) <- c("subject", "activity",
        sapply(meanstd.features$name,
        function(name) paste("avg", name, sep="-")))

# *****************************************************************************


# create file for second tidy dataset
write.table(tidy.data.v2, file="tidy_data_V2.txt", row.names=FALSE)

