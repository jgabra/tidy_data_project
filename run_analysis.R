#### run_analysis.R ####
# General Information

## Data was downloaded at: 2020-08-27 11:37:28 EDT

# Call libraries needed to run this code
library(dplyr) # For data manipulation
library(reshape) # This is to "melt" the various column variables for each subject to become a single column so that the final data set is truely tidy

#### Step 1 of Project Prompt ####
### Merge training and test sets ###

# Feature (Variable Name) Data set
varNames<-read.table("./UCI HAR Dataset/features.txt",col.names=c("Column","Variable"),header=FALSE) #Read and store the feautres data table that includes the variables for the variaous measurements taken


# Train Data Set #
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "Subject_Number",header=FALSE) #Read and store subject number for every data point
subject_train[,2]="Train" #Attaches the word "Train" to every data point for the subjet number to later extract the train specific data

names(subject_train)[2]<-"Origin_DataSet"#Create the variable name to track (if needed) if the data is test/train

activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "Activity",header=FALSE) #Reads/stores activity for each data point

subject_data_train<-read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE) #reads/stores subject data for each data point
names(subject_data_train)<-varNames[,2]#Labels the variables/measurements accordingly from the features file

data_train<-cbind(subject_train,activity_train,subject_data_train)# Combines all of the training data sets by binding columns

# Test Data Set #
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "Subject_Number",header=FALSE)#Read and store subject number for every data point
subject_test[,2]="Test"#Attaches the word "Test" to every data point for the subjet number to later extract the test specific data

names(subject_test)[2]<-"Origin_DataSet"#Create the variable name to track (if needed) if the data is test/train

activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "Activity",header=FALSE)#Reads/stores activity for each data point

subject_data_test<-read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE)#reads/stores subject data for each data point
names(subject_data_test)<-varNames[,2]#Labels the variables/measurements accordingly from the features file

data_test<-cbind(subject_test,activity_test,subject_data_test)# Combines all of the testing data sets by binding columns

# Combine the Two data sets (Train and Test)
combined_data<-rbind(data_train,data_test) # This appends the rows of the data (combine by row)


#### Step 2 of Project Prompt ####
### Extracts only the measurements on the mean and standard deviation for each measurement

#Only focusing on those variables with mean() or std() making the assumption that if we need both for each measurement then this is the only way. There are more measurements with "mean" in the variable name, but they do not have corresponding std() measurements.
mean_columns<-grep("mean()",names(combined_data),fixed=TRUE)#Stores column numbers for any variable/measurement with "mean()"
std_columns<-grep("std()",names(combined_data),fixed=TRUE)#Stores column numbers for any variable/measurement with "std()"
mean_std_columns<-sort(c(mean_columns,std_columns))#Combines the column numbers for variables with either "mean()" or "std()" in their names and sorts them in ascending order
combined_data_subset<-combined_data[,c(1,2,3,mean_std_columns)]#Creates a data subset with only the mean() and std() measurements

#### Step 3 of Project Prompt ####
### Name each activity in data set with descriptive activity names ###
## Below the activity data (values) are converted from numbers to their actual activity as follows:
## 1 is Walking
## 2 is Walking Upstairs
## 3 is Walking Downstairs
## 4 is Sitting
## 5 is Standing
## 6 is Laying

combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==1,"Walking") # Rreplaces 1 for Activity with "Walking"
combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==2,"Walking Upstairs") # Replaces 2 for Activity with "Walking Upstairs"
combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==3,"Walking Downstairs") # Replaces 3 for Activity with "Walking Downstairs"
combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==4,"Sitting") # Replaces 4 for Activity with "Sitting"
combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==5,"Standing") # Replaces 5 for Activity with "Standing"
combined_data_subset$Activity<-replace(combined_data_subset$Activity,combined_data_subset$Activity==6,"Laying") # Replaces 6 for Activity with "Laying"
#Now all activities are stored as descriptive strings rather than numbers


#### Step 4 of Project Prompt ####
### Label data set, appropriately, with descriptive variable names ###

#Below the variable names are expanded from the current names to be more descriptive where appropriate. Specifically,the variables from the "features.txt" are expanded further to detail: domain (Time/Frequency), Reference Name (Body/Gravity), Device (Accelerometer or Gyroscope), if the measurement is a jerk signal (yes if so), which componenet (X/Y/Z axes or magnitude), the statistic (mean/Std), and the final descriptive variable name which is a descriptive phrase from the preceding information
varNames2<-as.data.frame(names(combined_data_subset))#Pulls the current variable names
varNames2[,c(2,3,4,5,6,7,8)]<-NaN #create NaN columns as placeholders for details to be expanded (see note above or names below)
names(varNames2)<-c("OriginalName","Domain","Reference_Frame","Device","Jerk_Signal","Component","Statistic","Full_Label")#Names the columns apporpriately

#Labels the domain variable as appropriate based on prefix of original variable name
varNames2$Domain[grep("^[t][BG]",varNames2$OriginalName)]="in the Time domain"
varNames2$Domain[grep("^[f][BG]",varNames2$OriginalName)]="in the Frequency domain"

#Labels the reference frame as appropriate
varNames2$Reference_Frame[grep("Body",varNames2$OriginalName)]="for Body referrence frame with respect to the"
varNames2$Reference_Frame[grep("Gravity",varNames2$OriginalName)]="for Gravity reference frame with respect to the"

#Labels the device and resulting acceleration as appropriate
varNames2$Device[grep("Acc",varNames2$OriginalName)]="Linear Acceleration (Accelerometer)"
varNames2$Device[grep("Gyro",varNames2$OriginalName)]="Angular Acceleration (Gyroscope)"

#Labels if the original variable is also jerk
varNames2$Jerk_Signal[grep("Jerk",varNames2$OriginalName)]="the Jerk of"
varNames2$Jerk_Signal[!grepl("Jerk",varNames2$OriginalName)]=""

#Labels the component of the variable measured
varNames2$Component[grep("-X",varNames2$OriginalName)]="phone X-axis"
varNames2$Component[grep("-Y",varNames2$OriginalName)]="phone Y-axis"
varNames2$Component[grep("-Z",varNames2$OriginalName)]="phone Z-axis"
varNames2$Component[grep("Mag",varNames2$OriginalName)]="Magnitude"

#Labels the statistic of the variable measured
varNames2$Statistic[grep("mean()",varNames2$OriginalName)]="Mean of"
varNames2$Statistic[grep("std()",varNames2$OriginalName)]="Standard Deviation of"


varNames2$Full_Label=paste(varNames2$Statistic,varNames2$Jerk_Signal,varNames2$Device,varNames2$Reference_Frame,varNames2$Component,varNames2$Domain,sep=" ")#Creates a full descriptive label/name for each measurement based on the labels determined

#Updates the final column of varNames2 to have the correct first 3 names taht don't apply for the detailed information above
varNames2$Full_Label[1]="Subject_Number"
varNames2$Full_Label[2]="Original_Data_Set"      
varNames2$Full_Label[3]="Activity"

names(combined_data_subset)<-varNames2[,8]#Rename the columns names of the data set
      

#### Step 5 of Project Prompt ####
### Takes data set from step 4 to create a second, independent tidy data set ###
### with average of each variable for each activity and each subject ###


melted_combined_data_subset<-melt(combined_data_subset,id=c("Subject_Number","Original_Data_Set","Activity")) #"Melts" the data base to only have factors/levels for subject number, the origin data set (if wanted), and the activity performed. All the measured variable labels will then be listed in the 4th column with their respective values in the 5th column


narrow_combined_data_subset<-melted_combined_data_subset[,c(1,3,4,5)] #Excludes the "Original_Data_Set" factor on whether the data was test/train. No subject is in both and it is not needed per the specific request of the project prompt step 5
tidy_data_final<-narrow_combined_data_subset %>% group_by(Subject_Number,Activity,variable) %>% summarise_each(mean) #This gets the mean for every variable for each activity and each subject


wide_combined_data_subset<-combined_data_subset #creates a wide data set for those that consider the wide version "tidy"
wide_combined_data_subset$Original_Data_Set<-NULL #Gets rid of origin_dataSet as in narrow (per prompt)
tidy_data_final_wide<-wide_combined_data_subset %>% group_by(Subject_Number,Activity) %>% summarise_each(mean)# Gets the mean for every variable for each acitivty and each subject but uses the wide tidy format rather than the traditional narrow tidy format

write.table(tidy_data_final,file="tidy_data_final.txt",col.names=TRUE,row.names=FALSE)#Writes the table into a text file

# Below is to test if the table was written correctly. It just reads and views the data
# data<-read.table("tidy_data_final.txt",header=TRUE)#Reads the table that was just written
# View(data)

#### END of run_analysis.R ####
