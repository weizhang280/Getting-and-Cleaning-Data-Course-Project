############################################################################################################
##      Author: Wei Zhang
##      Date: 5/27/2020

##                            Course3 project Requirements
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
##      3. Uses descriptive activity names to name the activities in the data set
##      4. Appropriately labels the data set with descriptive variable names.
##      5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##         variable for each activity and each subject.
############################################################################################################

## lOad library
library(dplyr)
library(tidyr)
library(stringr)

############################################################################################################
##      1. Merges the training and the test sets to create one data set.
############################################################################################################

##Project working directory:     /RStudio/Getting-and-Cleaning-Data-Course-Project/
##dataset location:              /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/
##Train files location:          /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/train/
##Test files location:           /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/test/

##---------load train files---------##

##Note: X_train.txt is large, colClasses = "numeric" reduces read time from 6.75s to 2.55s
x_train <- read.table("dataset/train/X_train.txt", colClasses = "numeric")
y_train <- read.table("dataset/train/y_train.txt")
subject_train <- read.table("dataset/train/subject_train.txt")

##---------load test files---------##

x_test <- read.table("dataset/test/X_test.txt", colClasses = "numeric")
y_test <- read.table("dataset/test/y_test.txt", header = FALSE, na.strings = "NA")
subject_test <- read.table("dataset/test/subject_test.txt", header = FALSE, na.strings = "NA")

##---------combine train and test dataframe---------##

## verify by dim: the 2 dataframes in each rbind below have the same column number
x_combined <- rbind(x_train, x_test)  
y_combined <- rbind(y_train, y_test) 
subject_combined <- rbind(subject_train, subject_test) 

##-------add subject, activity to x_combined to get the complete final data set---------##

## verify by dim: the 3 dataframes in cbind below have the same row number.
mainDataSet <- cbind(subject_combined, y_combined, x_combined)  


############################################################################################################
##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
############################################################################################################

##---------Assign feature variable names to mainDataSet columns---------##

##load features.txt
features <- read.table("dataset/features.txt")

##assign subject, activity, feature names to mainDataSet columns
colnames(mainDataSet) <- c("subject", "activity", features$V2)

##---------Extracts only the measurements on the mean and standard deviation for each measurement---------##

mainDataSet_extract <- mainDataSet[c(1:2, grep('(mean|std)\\(\\)(-[X-Z])?$', colnames(mainDataSet)))]

## mainDataSet_extract dimension: dim(mainDataSet_extract)       [1] 10299    66


############################################################################################################
##      3. Uses descriptive activity names to name the activities in the data set
############################################################################################################

##load activity_labels.txt
activity_label <- read.table("dataset/activity_labels.txt")

##join y_combined with activity_label, use inner_join to keep the order of y_combined unchanged. 
labeled_y_combined <- inner_join(y_combined, activity_label, by="V1")

## assign activity column of the extracted main dataset with descriptive names in labeled_y_combined
mainDataSet_extract$activity <- labeled_y_combined$V2


############################################################################################################
##      4. Appropriately labels the data set with descriptive variable names.
############################################################################################################

#Note: str_replace_all needs stringr package, refer to library(stringr) at the beginning

colnames(mainDataSet_extract) <- names(mainDataSet_extract) %>% str_replace_all(c("^t"="time_domain", 
                                                             "^f"="frequency_domain",
                                                             "BodyBody"="Body",
                                                             "Body"="_Body", 
                                                             "Acc"="_Acceleration",
                                                             "Gyro"="_Velocity", 
                                                             "Gravity"="_Gravity", 
                                                             "Mag"="_Magnitude", 
                                                             "Jerk" ="_Jerk", 
                                                             "-X"="-X_direction",
                                                             "-Y"="-Y_direction",
                                                             "-Z"="-Z_direction"
                                                             ))


############################################################################################################
##     5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##         variable for each activity and each subject.
############################################################################################################

tidy_dataset <- mainDataSet_extract %>% 
        group_by(subject, activity) %>% 
        summarise_all(mean) %>% 
        gather(key="mean() & std()", value="average", -c('subject', 'activity'))

##format average column to scientific notation
tidy_dataset$average <- format(tidy_dataset$average, scientific = TRUE)
     
##write tidy_DataSet to tidy_dataset.csv file
write.csv(tidy_dataset, file = "tidy_dataset.csv", row.names = FALSE)

