title: Getting-and-Cleaning-Data-Course-Project
author: Wei Zhang
date: 5/29/2020

############################################################################################################
##                            Project Requirements
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
##      3. Uses descriptive activity names to name the activities in the data set
##      4. Appropriately labels the data set with descriptive variable names.
##      5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##         variable for each activity and each subject.
############################################################################################################


### Project Files:
=======================
1.  run_analysis.R
2.  tidy_dataset.csv
3.  README.md
4.  CodeBook.md for tidy data set


### Project Files Location:
===========================
Project working directory:     /RStudio/Getting-and-Cleaning-Data-Course-Project/
dataset location:              /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/
Train files location:          /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/train/
Test files location:           /RStudio/Getting-and-Cleaning-Data-Course-Project/dataset/test/


### Data Source
================
Human Activity Recognition Using Smartphones Dataset
Version 1.0

The data source includes the following files:
==============================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the featrunure vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


=========================================================================================
### run_analysis.R
=========================================================================================

Packages:

## Install pacakges
install.packages(dplyr)
install.packages(tidyr)
install.packages(stringr)

## lOad to current session
library(dplyr)
library(tidyr)
library(stringr)


### Implement Project Requirements 
==================================

1. Merges the training and the test set to create one data set.
================================================================
        
        Step1:  load train and test files into dataframes

                Files                                   DataFrame       Dimension
                dataset/train/X_train.txt               x_train         [1] 7352  561   
                dataset/train/y_train.txt               y_train         [1] 7352    1
                dataset/train/subject_train.txt         subject_train   [1] 7352    1
                
                dataset/test/X_test.txt                 X_test          [1] 2947  561
                dataset/test/y_test.txt                 y_test          [1] 2947    1
                dataset/test/subject_test.txt           subject_test    [1] 2947    1
                
                code:
                
                #Note: X_train.txt is large, colClasses = "numeric" reduces read time from 6.75s to 2.55s
                
                ##---------load train files---------##

                x_train <- read.table("dataset/train/X_train.txt", colClasses = "numeric")
                y_train <- read.table("dataset/train/y_train.txt")
                subject_train <- read.table("dataset/train/subject_train.txt")
                
                ##---------load test files---------##
                
                x_test <- read.table("dataset/test/X_test.txt", colClasses = "numeric")
                y_test <- read.table("dataset/test/y_test.txt", header = FALSE, na.strings = "NA")
                subject_test <- read.table("dataset/test/subject_test.txt", header = FALSE, na.strings = "NA")
                

        
        Step2:  combine train and test dataframes by cbind and rbind

        
                Train DataFrame         Test DataFrame          Combined DataFrame      
                x_train                 X_test                  x_combined              
                y_train                 y_test                  y_combined              
                subject_train           subject_test            subject_combined        
                
                
                Combined dataframes:
                ====================
                
                x_combined:     feature measurement observations including train and test. x_train and x_test                                   both have the same column number 561, can be combined by rbind
                                x_train         [1] 7352  561
                                X_test          [1] 2947  561
   
                y_combined:     activity observations including train and test. y_train and y_test                                              both have the same column number 1, can be combined by rbind
                                y_train         [1] 7352    1
                                y_test          [1] 2947    1

                subject_combined: 
                                subject for each observation including train and test. subject_train and                                        subject_test both have the same column number 1, can be combined by rbind
                                subject_train   [1] 7352    1
                                subject_test    [1] 2947    1
                                
                                
                Code:

                x_combined <- rbind(x_train, x_test)  
                y_combined <- rbind(y_train, y_test) 
                subject_combined <- rbind(subject_train, subject_test) 
                

                                
        Step3: genereate the complete final dataset -> mainDataSet

                mainDataSet:    add subject and activity as columns to feature measurement x_combined dataframe.
        
                ## the 3 dataframes below have the same row number, can be combined by cbind
                x_combined              [1] 10299   561
                y_combined              [1] 10299     1
                subject_combined        [1] 10299     1
                
                code:
                
                mainDataSet <- cbind(subject_combined, y_combined, x_combined) 
                
                #dimension of mainDataSet:  [1] 10299   563
         
                
                
2. Extracts only the measurements on the mean and standard deviation for each measurement.
==========================================================================================

        Step1:  build regular expression to match name pattern
        
                From feature_info.txt:
                
                These signals were used to estimate variables of the feature vector for each pattern:  
                '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
                
                tBodyAcc-XYZ
                tGravityAcc-XYZ
                tBodyAccJerk-XYZ
                tBodyGyro-XYZ
                tBodyGyroJerk-XYZ
                tBodyAccMag
                tGravityAccMag
                tBodyAccJerkMag
                tBodyGyroMag
                tBodyGyroJerkMag
                fBodyAcc-XYZ
                fBodyAccJerk-XYZ
                fBodyGyro-XYZ
                fBodyAccMag
                fBodyAccJerkMag
                fBodyGyroMag
                fBodyGyroJerkMag
                
                The set of variables that were estimated from these signals are: 
                
                mean(): Mean value
                std(): Standard deviation
                ....
                
                Based on the above info, the name pattern should be
                1. end with mean() or std()
                Or
                2. end with mean()-XYZ or std()-XYZ (XYZ means X or Y or Z)
                
                regular expression: (mean|std)\\(\\)(-[X-Z])?$
                
                
        Step2:  assign feature names in feature.txt to columns of the mainDataset arrived from Project                          Requirement#1
                
                ##load features.txt
                features <- read.table("dataset/features.txt")
                
                ## check features dataframe structure
                > head(features, 2)
                  V1                V2
                1  1 tBodyAcc-mean()-X
                2  2 tBodyAcc-mean()-Y

                ##assign subject, activity, feature names to mainDataSet columns
                colnames(mainDataSet) <- c("subject", "activity", features$V2)

                
                
        Step3:  keep subject and activity columns, extracts only the measurements on the mean and standard                      deviation for each measurement, 

        mainDataSet_extract <- mainDataSet[c(1:2, grep('(mean|std)\\(\\)(-[X-Z])?$', colnames(mainDataSet)))]
        
        #st#mainDataSet_extract is the reuqired extracted dataset, its dimension: [1] 10299    66
 
                
                
3. Uses descriptive activity names to name the activities in the data set 
==========================================================================

        When adding y_combined(activity observations) to mainDataSet, the values of activity are integer. To                re-assign descriptive names, need to have y_combined dataframe inner_join with activty label                    dataframe to get a 2 columns dataset labeled_y_combined, col1=activity_id, col2=descriptive label.
        

        ##load activity_labels.txt
        activity_label <- read.table("dataset/activity_labels.txt")
        
        > str(activity_label)
        'data.frame':	6 obs. of  2 variables:
         $ V1: int  1 2 3 4 5 6
         $ V2: chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...
         
         > str(y_combined)
        'data.frame':	10299 obs. of  1 variable:
         $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
        
        ##join y_combined with activity_label, use inner_join to keep the order of y_combined unchanged. 
        labeled_y_combined <- inner_join(y_combined, activity_label, by="V1")
        
        'data.frame':	10299 obs. of  2 variables:
         $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
         $ V2: chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
        
        ## assign activity column of the extracted main dataset with descriptive names in labeled_y_combined
        mainDataSet_extract$activity <- labeled_y_combined$V2
    
        
4. Appropriately labels the data set with descriptive variable names.
==========================================================================

        The abbreviated names of featurs can be restored with full words for easy understanding
        
        #Note: str_replace_all needs stringr package, install and load to current session

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
                                                             
                                          
                                                             
5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
variable for each activity and each subject.
====================================================================================================

        Use dplyr and tidyr, all mean() and std() feature variables can be collapsed into one column "mean() &          std()", mean() on these variables per activity per subject goes to "average" column
        
        tidy_dataset <- mainDataSet_extract %>% 
                group_by(subject, activity) %>% 
                summarise_all(mean) %>% 
                gather(key="mean() & std()", value="average", -c('subject', 'activity'))
                

====================================================================================================

6. Write and read tidy_dataset.csv file
        
        ##format average column to scientific notation
        tidy_dataset$average <- format(tidy_dataset$average, scientific = TRUE)
                
        ##write tidy_DataSet to tidy_dataset.csv file
        write.csv(tidy_dataset, file = "tidy_dataset.csv", row.names = FALSE)
        
        ##Read tidy_dataset.csv
        df <- read.csv("tidy_dataset.csv")
        View(df)
        