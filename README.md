---
title: "README"
author: "JNG"
date: "8/27/2020"
output: 
  html_document: 
    fig_caption: yes
---

# Tidy Data Project
Tidy Data Project for Coursera, JHU course "Getting and Cleaning Data". It involves combining several data tables, renaming variables, extracting variables, and ultimately make a tidy data set with mean values for each variable.

# What you should do
Here are steps on what you should do when using and/or reviewing the scripts:
      
      1. The folder titled "UCI HAR Dataset" should be in the directory that the code is being run. A link to the dataset to use is below but also included in this github repository.
      
      2. Make sure that the following libraries are already installed as they are called in the script
            dyplr
            reshape
            
      3. The script run_analysis.R is commented very well but if you want an overview of what it does, please refere below to the run_analysis.R section.
      
      4. If you wish to read the final tidy data set please use the r code below:
      
            data<-read.table("tidy_data_final.txt",header=TRUE)
            View(data)
      
      5. Please do not copy the code for your own project.
      


# Data
The data was provided by the course per a project prompt

The data set came from:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data set used was downloaded at: 2020-08-27 11:37:28 EDT

For the purposes of the project, the inertial sub data sets were ignored since 
they are to be excluded in the final data for not being mean() or std() type measurements

# CodeBook.md
CodeBook.md is the R markdown document for the CodeBook related to this project. There you will find specifics


# run_analysis.R Script
Per the project promt this script will do the following things:

  1. Merges the training and test data sets to create one data set
        a. Before the script really starts the libraries dyplr and reshape are called
        b. First, the **measured variables** text files is read and stored as a table
        c. The train and test data are then read and stored from the various respective text files
            * In case there is a need to break the data into train and test, I also create a, "Origin_DataSet" label of "Train" or "Test" as appropriate
            * The **measured variable** names stored in **1b** are assigned the names of the respective data stored.
            * Column binding is used to combine all of the train data and all of the test data to have two separate data frames, data_train and data_test
            * Row binding is then used to combine the train data
        d. For the purposes of the project, the inertial sub data sets were ignored since 
they are to be excluded in the final data for not being mean() or std() type measurements
        
  2. Extractly only the measurements on the mean and standard deviation for 
      each measurement
        a. For the purposes of this project, it is assumed that they are referring to only those measured variables that are "mean()" or "std()".  There are more measurements with "mean" in the variable name but they do not have corresponding "std" measurements.Therefore, **only the mean() and std()
variables are kept.**
        b. the grep funcion is used to extract which variable names have mean() and std()
        
  3. Uses descriptive activity names to name the activities in the data set
        a. The replace function is used to replace the Activity Numbers to their respective Activity Labels which are more descriptive. Please refer to the **CodeBook** for the specific activities
        
  4. Appropriately labels the data set with descriptive variable names
        a.Tthe variable names are expanded from the current names to be more descriptive where appropriate. Specifically,the variables from the "features.txt" are expanded further to detail: 
          * Domain (Time/Frequency)
          * Reference Name (Body/Gravity)
          * Device (Accelerometer or Gyroscope)
          * If the measurement is a jerk signal (yes if so)
          * Which componenet (X/Y/Z axes or magnitude)
          * The statistic (mean/Std)
          * The final descriptive variable name which is a descriptive phrase from the preceding information (e.g. "Mean of  Linear Acceleration (Accelerometer) for Body referrence frame with respect to the phone X-axis in the Time domain")
        b. Step **4a** is achieveieved in the following manner
          * A Variable Name data fram was created from the names of the combined data set
          * Extra columns for the expaned variables lised in **4a** are added with NaN values as a default
          * For each expanded subvariable (e.g. Domain) the grep function was used to identify the respective subcategory (e.g. Time or Frequency) that it fits into. This was achieved through the data sets original readme file and the features)info.txt file.
          * The final descriptive variable name was the last column and was created using the paste function
          * The final descriptive names are then assigned as column names for the combined data (e.g. "Mean of  Linear Acceleration (Accelerometer) for Body referrence frame with respect to the phone X-axis in the Time domain")
        
  5. After step 4, the resulting data set is used to create a second, 
      independent tidy data set with the averave of each variable for each 
      activity and each subject.
        a. Per Hadley Wickham's "Tidy Data" article, I chose to go with a **narrow** data set with one value per row. Thus, there are 5 columns using the melt function:
            1. The Subject Number (Number 1 to 30)
            2. Origin Data Set (Test or Train)
            3. Activity (e.g. Sitting)
            4. Measured Variable (e.g. "Mean of  Linear Acceleration (Accelerometer) for Body referrence frame with respect to the phone X-axis in the Time domain"))
            5. Value for the respective levels
        b. The subjects are different in the testing and training data sets. In other words, there are no subjects that are in both the training and testing data sets. Therefore, the Origin_DataSet column **is removed** for this final step per the given instructions.
        c. The summarise_each function is then used to calculate the mean of every variable for each activity and each subject
        d. The data is ultimately written to a text files while storing the headers
        e. If you wish to read the final data, please use the code below:
              data<-read.table("tidy_data_final.txt",header=TRUE)
              View(data)
              
              
## This is the end of the README
