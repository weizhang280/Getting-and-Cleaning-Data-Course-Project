title: CodeBook for tidy_dataset.csv
author: Wei Zhang
date: 5/29/2020

### Variables in tidy dataset

subject 
        An identifier of the subject who carried out the experiment
            
            value: 1:30

    
activity:
        Each person performed six activities wearing a smartphone
            
            WALKING
            WALKING_UPSTAIRS
            WALKING_DOWNSTAIRS
            SITTING
            STANDING
            LAYING

       
mean() & std()
        mean() and std() variables (total=66) for each measurement in the below list from feature_info.txt
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
         
         
             [1] "time_domain_Body_Acceleration-mean()-X_direction"          
             [2] "time_domain_Body_Acceleration-mean()-Y_direction"          
             [3] "time_domain_Body_Acceleration-mean()-Z_direction"          
             [4] "time_domain_Body_Acceleration-std()-X_direction"           
             [5] "time_domain_Body_Acceleration-std()-Y_direction"           
             [6] "time_domain_Body_Acceleration-std()-Z_direction"           
             [7] "time_domain_Gravity_Acceleration-mean()-X_direction"       
             [8] "time_domain_Gravity_Acceleration-mean()-Y_direction"       
             [9] "time_domain_Gravity_Acceleration-mean()-Z_direction"       
            [10] "time_domain_Gravity_Acceleration-std()-X_direction"        
            [11] "time_domain_Gravity_Acceleration-std()-Y_direction"        
            [12] "time_domain_Gravity_Acceleration-std()-Z_direction"        
            [13] "time_domain_Body_Acceleration_Jerk-mean()-X_direction"     
            [14] "time_domain_Body_Acceleration_Jerk-mean()-Y_direction"     
            [15] "time_domain_Body_Acceleration_Jerk-mean()-Z_direction"     
            [16] "time_domain_Body_Acceleration_Jerk-std()-X_direction"      
            [17] "time_domain_Body_Acceleration_Jerk-std()-Y_direction"      
            [18] "time_domain_Body_Acceleration_Jerk-std()-Z_direction"      
            [19] "time_domain_Body_Velocity-mean()-X_direction"              
            [20] "time_domain_Body_Velocity-mean()-Y_direction"              
            [21] "time_domain_Body_Velocity-mean()-Z_direction"              
            [22] "time_domain_Body_Velocity-std()-X_direction"               
            [23] "time_domain_Body_Velocity-std()-Y_direction"               
            [24] "time_domain_Body_Velocity-std()-Z_direction"               
            [25] "time_domain_Body_Velocity_Jerk-mean()-X_direction"         
            [26] "time_domain_Body_Velocity_Jerk-mean()-Y_direction"         
            [27] "time_domain_Body_Velocity_Jerk-mean()-Z_direction"         
            [28] "time_domain_Body_Velocity_Jerk-std()-X_direction"          
            [29] "time_domain_Body_Velocity_Jerk-std()-Y_direction"          
            [30] "time_domain_Body_Velocity_Jerk-std()-Z_direction"          
            [31] "time_domain_Body_Acceleration_Magnitude-mean()"            
            [32] "time_domain_Body_Acceleration_Magnitude-std()"             
            [33] "time_domain_Gravity_Acceleration_Magnitude-mean()"         
            [34] "time_domain_Gravity_Acceleration_Magnitude-std()"          
            [35] "time_domain_Body_Acceleration_Jerk_Magnitude-mean()"       
            [36] "time_domain_Body_Acceleration_Jerk_Magnitude-std()"        
            [37] "time_domain_Body_Velocity_Magnitude-mean()"                
            [38] "time_domain_Body_Velocity_Magnitude-std()"                 
            [39] "time_domain_Body_Velocity_Jerk_Magnitude-mean()"           
            [40] "time_domain_Body_Velocity_Jerk_Magnitude-std()"            
            [41] "frequency_domain_Body_Acceleration-mean()-X_direction"     
            [42] "frequency_domain_Body_Acceleration-mean()-Y_direction"     
            [43] "frequency_domain_Body_Acceleration-mean()-Z_direction"     
            [44] "frequency_domain_Body_Acceleration-std()-X_direction"      
            [45] "frequency_domain_Body_Acceleration-std()-Y_direction"      
            [46] "frequency_domain_Body_Acceleration-std()-Z_direction"      
            [47] "frequency_domain_Body_Acceleration_Jerk-mean()-X_direction"
            [48] "frequency_domain_Body_Acceleration_Jerk-mean()-Y_direction"
            [49] "frequency_domain_Body_Acceleration_Jerk-mean()-Z_direction"
            [50] "frequency_domain_Body_Acceleration_Jerk-std()-X_direction" 
            [51] "frequency_domain_Body_Acceleration_Jerk-std()-Y_direction" 
            [52] "frequency_domain_Body_Acceleration_Jerk-std()-Z_direction" 
            [53] "frequency_domain_Body_Velocity-mean()-X_direction"         
            [54] "frequency_domain_Body_Velocity-mean()-Y_direction"         
            [55] "frequency_domain_Body_Velocity-mean()-Z_direction"         
            [56] "frequency_domain_Body_Velocity-std()-X_direction"          
            [57] "frequency_domain_Body_Velocity-std()-Y_direction"          
            [58] "frequency_domain_Body_Velocity-std()-Z_direction"          
            [59] "frequency_domain_Body_Acceleration_Magnitude-mean()"       
            [60] "frequency_domain_Body_Acceleration_Magnitude-std()"        
            [61] "frequency_domain_Body_Acceleration_Jerk_Magnitude-mean()"  
            [62] "frequency_domain_Body_Acceleration_Jerk_Magnitude-std()"   
            [63] "frequency_domain_Body_Velocity_Magnitude-mean()"           
            [64] "frequency_domain_Body_Velocity_Magnitude-std()"            
            [65] "frequency_domain_Body_Velocity_Jerk_Magnitude-mean()"      
            [66] "frequency_domain_Body_Velocity_Jerk_Magnitude-std()"  

        
average
        the mean() of each variable in "mean() & std()" column for each activity and each subject
    
