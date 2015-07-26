#1. Merge the training and the test sets to create one data set.

#1.1. The first step is to load training results

#First column is the subject
train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
#Followed by the features vector
train<-cbind(train,read.fwf("./UCI HAR Dataset/train/X_train.txt",widths=rep(16,561)))
#The last column is the activity label
train<-cbind(train,read.table("./UCI HAR Dataset/train/y_train.txt"))

#1.2. The second step loads the test results

#First column is the subject
test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
#Followed by the features vector
test<-cbind(test,read.fwf("./UCI HAR Dataset/test/X_test.txt",widths=rep(16,561)))
#The last column is the activity label
test<-cbind(test,read.table("./UCI HAR Dataset/test/y_test.txt"))

#1.3. Merging the two datasets using rbind. Dataset merged in the "dataset" variable
dataset<-rbind(train,test)

################################################################
#2. Extract only the measurements on the mean and standard deviation for
#each measurement.

#2.1. Extract variable names that contain "mean" or "std" from the "features.txt"
#file using the grep function to match either mean or std.
labels<-read.table("./UCI HAR Dataset/features.txt",sep=" ")
meanstd<-1+grep("mean|std",labels[,2]) #1 is added since the first column is the subject

#2.2. Subset clean data set only including meand and std variables
cleandataset<-dataset[,c(1,meanstd,563)] #The last column is added manually and it includes
                                         #The activity label

################################################################
#3.  Use descriptive activity names to name the activities in the data set

#3.1. Load activity names from the activity_labels.txt file into a variable
#called "activity". The second column includes the activity name.
activity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")

#3.2. Merge with cleandataset
#This is achieved by using cbind, adding a column including the activity name
#taken from the activity_labels.txt file. This is achieved by returning
#the second column of the "activity" variable (defined on the previous step)
#depending on the activity label (found on the last column of the cleandataset data frame).
#As you can seecleandataset[,dim(cleandataset)[2]] returns the last column of the data frame
cleandataset<-cbind(cleandataset,activity[cleandataset[,dim(cleandataset)[2]],2])

################################################################
#4. Appropriately label the data set with descriptive variable names.
#4.1. Initialization of col names from the features.txt file directly.
colnames(cleandataset)<-  #First column is the subject
                          c("subject",
                          
                          #Following columns are the features. Right now the
                          #names assigned come from the features.txt file directly.
                          #They include mean and std variables
                          as.character(labels[grep("mean|std",labels[,2]),2]),
                          
                          #Activity ID
                          "activity_ID",
                          
                          #Activity Names
                          "activity")

#4.2. Creating descriptive variable names
#Removing "()" from the variable names
colnames(cleandataset)<-gsub("\\(|\\)", "",colnames(cleandataset))
#Renaming Axis
colnames(cleandataset)<-gsub("-X","_X_Axis",colnames(cleandataset))
colnames(cleandataset)<-gsub("-Y","_Y_Axis",colnames(cleandataset))
colnames(cleandataset)<-gsub("-Z","_Z_Axis",colnames(cleandataset))
#Removing "BodyBody" duplication
colnames(cleandataset)<-gsub("^fBodyBody","fBody",colnames(cleandataset))
#Renaming mean, std, acc, mag, body, jerk and gyro including an underscore
#to make the variables easier to read
colnames(cleandataset)<-gsub("-std","_StdDev",colnames(cleandataset))
colnames(cleandataset)<-gsub("-mean","_Mean",colnames(cleandataset))
colnames(cleandataset)<-gsub("Acc","_Acceleration",colnames(cleandataset))
colnames(cleandataset)<-gsub("Mag","_Magnitude",colnames(cleandataset))
colnames(cleandataset)<-gsub("Body","_Body",colnames(cleandataset))
colnames(cleandataset)<-gsub("Jerk","_Jerk",colnames(cleandataset))
colnames(cleandataset)<-gsub("Gyro","_Gyro",colnames(cleandataset))
#Changing the prefix t and f for [Time] and [Frequency] to make the domain of
#the variable easier to read (time vs. frequency domain)
colnames(cleandataset)<-gsub("^t|^t_","[Time]",colnames(cleandataset))
colnames(cleandataset)<-gsub("^f|^f_","[Freq]",colnames(cleandataset))
#Renaming 'Acceleration_Jerk' as 'Linear_Jerk', 'Gyro_Jerk' as 'Angular_Jerk'
#and 'Gyro' as 'Angular_Speed'
colnames(cleandataset)<-gsub("Acceleration_Jerk","Linear_Jerk",colnames(cleandataset))
colnames(cleandataset)<-gsub("Gyro_Jerk","Angular_Jerk",colnames(cleandataset))
colnames(cleandataset)<-gsub("Gyro","Angular_Speed",colnames(cleandataset))

################################################################
#5. From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.

#Use the dplyr library to create the average for each variable per activity/subject
library(dplyr)

#Use group_by to group the data by subject, activity_ID and activity
group<-group_by(cleandataset,subject,activity_ID,activity)

#Use summarise_each to produce the average for each variable per activity/subject
#*although as.data.frame is not necessary, this would produce a clean data frame
finaldata<-as.data.frame(summarise_each(group,funs(mean)))

#Colnames are edited to include "Average" since we're averaging all variables
colnames(finaldata)<-gsub("]","]Average_",colnames(finaldata))

#Writing out the final data to a file "finaldata.txt"
write.table(finaldata,file="finaldata.txt",row.name=FALSE)