#Getting and Cleaning Data - Final Project

This repository contains the script run_analysis.R and the aim of this README is to explain what the script does and how it can be invoked by an user.

First of all, the script run_analysis.R assumes that the original data has been downloaded and unzipped to your R working directory. Original data for the project [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

You can find a full description to the data linked [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The script is divided into 5 parts as exlained below.

### Libraries Used
dplyr

##1. Merge the training and the test sets to create one data set.

Since the data contains two data sets: training and test, the first step is to load and merge these two data sets. These is achieved in three parts.

###1.1. The first step loads training results.
The training results are loaded in a data frame named *train*.

The first column is the subject, loaded from the 'train/subject\_train.txt' file, followed by the features vector (which has 561 columns each with a fix width of 16) loaded from the 'train/X\_train.txt' file. The last column is the activity id, loaded from the 'train/y_train.txt' file.

    train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
    train<-cbind(train,read.fwf("./UCI HAR Dataset/train/X_train.txt",widths=rep(16,561)))
    train<-cbind(train,read.table("./UCI HAR Dataset/train/y_train.txt"))

###1.2. The second step loads the test results.
The test results are loaded in a data frame named *test*.

The first column is the subject, loaded from the 'test/subject\_test.txt' file, followed by the features vector (which has 561 columns each with a fix width of 16) loaded from the 'test/X\_test.txt' file. The last column is the activity id, loaded from the 'test/y_test.txt' file

    test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
    test<-cbind(test,read.fwf("./UCI HAR Dataset/test/X_test.txt",widths=rep(16,561)))
    test<-cbind(test,read.table("./UCI HAR Dataset/test/y_test.txt"))

###1.3. Merging the two datasets.
Finally, the two data frames *test* and *train* are merged into a new data frame named *dataset* using rbind.

    dataset<-rbind(train,test)

##2. Extract only the measurements on the mean and standard deviation for each measurement.

This second step uses the names included on the "features.txt" file to include only those variables in the features vector that include mean and standard variation for each measurement, instead of including the whole 561 variables.

This is achieved in 2 steps.

###2.1. Extract variable names that contain "mean" or "std" from the "features.txt" file
The "features.txt" file is loaded into a data.frame named *labels*

    labels<-read.table("./UCI HAR Dataset/features.txt",sep=" ")

Using the function grep(), we find those variables that either match 'mean' or 'std' in the *labels* data frame. The column numbers of these variables is saved in a new numeric vector named *meanstd*. Notice that 1 is added at the beginning - the reason is that the first column of the *dataset* data frame actually contains the subject id (instead of the first variable of the features vector) so this is an adjustment for that.

    meanstd<-1+grep("mean|std",labels[,2])

There are some angular vairables found on the features vector (eg. *angle(tBodyAccMean,gravity)*) that are not being picked up here. The reason is that although they include the word "Mean" you can see that the mean is passed as a parameter to a function, but what is being returned is an angle, not a mean and/or standard variation making it irrelevant for our purposes.

###2.2. Subset clean data set only including meand and std variables

The *meanstd* vector is used to subsect the *dataset* data frame including only those variabled that include means and standard deviations. The result is passed to a new data frame *cleandataset*

    cleandataset<-dataset[,c(1,meanstd,563)]

The first column of *dataset* is still the subject ID. The following columns are the ones containing only meand and standard deviation measurements from the features vector (these are included on the *meanstd* vector). The last column (563) includes the activity ID.

##3. Use descriptive activity names to name the activities in the data set

The last column of *dataset* includes an activity ID. Each activity ID has a corresponding descriptive name that can be found on the "activity_labels.txt" file. This file is going to be use to add an activity name to each measurement in 2 steps.

###3.1. Load activity names

The activity names are loaded from the activity_labels.txt file into a data frame named *activity*. The first column of this data frame contains the activity ID and the second column includes the activity name.

    activity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")

###3.2. Merge with *cleandataset*

This is achieved by using cbind, adding a new column to *cleandataset* including the activity name taken from the activity_labels.txt file. This is achieved by returning the second column of the *activity* data frame (defined on the previous step) depending on the activity id (found on the last column of the cleandataset data frame). As you can seecleandataset[,dim(cleandataset)[2]] returns the last column of the data frame.

    cleandataset<-cbind(cleandataset,activity[cleandataset[,dim(cleandataset)[2]],2])

##4. Appropriately label the data set with descriptive variable names.

The labeling with descriptive names is achieved in two steps.

###4.1. Initialization of col names from the features.txt file directly.

The first step is to load the raw labels from the features.txt file (labels being loaded are only those for meand and standard deviation measurements). To do so the data frame *labels* (step 2.1) is being used (since the labels where already loaded there before). *labels* is being subset to only include those variables that include "mean" or "std" as done on step 2.1. (this is done so that it matches current columns included on cleandataset).

    colnames(cleandataset)<- c("subject", #First column is the subject
                          
                          #Following columns are the features. Right now the
                          #names assigned come from the features.txt file directly.
                          #They include mean and std variables
                          as.character(labels[grep("mean|std",labels[,2]),2]),
                          
                          #Activity ID
                          "activity_ID",
                          
                          #Activity Names
                          "activity")

You can see that the vector passed to colnames(cleandataset) is divided in 4 main parts:
-1. subject: The first column of *cleandataset* is the subject ID
-2. raw labels from the "features.txt" file: The following columns of *cleandataset* are mean/std measurements from the features vector.
-3. activity ID: The penultimate column of *cleandataset* is the activity ID
-4. activity: The last column of *cleandataset* is the activity name (see step 3.2)

###4.2. Creating descriptive variable names

The second step is to edit the raw labels obtained from "features.txt" to make them more user friendly and desctiptive. This is achieved by calling the function gsub() several times as shown below.

Removing "()" from the variable names

    colnames(cleandataset)<-gsub("\\(|\\)", "",colnames(cleandataset))

Renaming Axis

    colnames(cleandataset)<-gsub("-X","_X_Axis",colnames(cleandataset))
    colnames(cleandataset)<-gsub("-Y","_Y_Axis",colnames(cleandataset))
    colnames(cleandataset)<-gsub("-Z","_Z_Axis",colnames(cleandataset))

Removing "BodyBody" duplication

    colnames(cleandataset)<-gsub("^fBodyBody","fBody",colnames(cleandataset))
  
Renaming mean, std, acc, mag, body, jerk and gyro including an underscore to make the variables easier to read

    colnames(cleandataset)<-gsub("-std","_StdDev",colnames(cleandataset))
    colnames(cleandataset)<-gsub("-mean","_Mean",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Acc","_Acceleration",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Mag","_Magnitude",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Body","_Body",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Jerk","_Jerk",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Gyro","_Gyro",colnames(cleandataset))

Changing the prefix t and f for [Time] and [Frequency] to make the domain of the variable easier to read (time vs. frequency domain)

    colnames(cleandataset)<-gsub("^t|^t_","[Time]",colnames(cleandataset))
    colnames(cleandataset)<-gsub("^f|^f_","[Freq]",colnames(cleandataset))

Renaming 'Acceleration\_Jerk' as 'Linear\_Jerk', 'Gyro\_Jerk' as 'Angular\_Jerk' and 'Gyro' as 'Angular_Speed'

    colnames(cleandataset)<-gsub("Acceleration_Jerk","Linear_Jerk",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Gyro_Jerk","Angular_Jerk",colnames(cleandataset))
    colnames(cleandataset)<-gsub("Gyro","Angular_Speed",colnames(cleandataset))

##5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

To achieve this, the function summarise_each() of the *dplyr* library is being used as follows.

    library(dplyr)

##5.1. Grouping by subject and activity

The first step is to use group\_by to group the data by subject, activity_ID and activity

    group<-group_by(cleandataset,subject,activity_ID,activity)

##5.2. Summarise results into a final data frame

Then, summarise_each is used to produce the average for each variable per activity/subject. Although as.data.frame is not necessary, this would produce a clean data frame *finaldata*.

    finaldata<-as.data.frame(summarise_each(group,funs(mean)))
    
Colnames are edited to include "Average" since we're averaging all variables

    colnames(finaldata)<-gsub("]","]Average_",colnames(finaldata))

##Writing out the final dataset to a clean file

The *finaldata* data set is saved in a file named "finaldata.txt"

    write.table(finaldata,file="finaldata.txt",row.name=FALSE)
