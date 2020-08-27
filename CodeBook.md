---
title: "CodeBook"
author: "JNG"
date: "8/27/2020"
output: 
  html_document: 
    fig_caption: yes
---

CodeBook for Tidy_data_final dataset
--------------------------------------

This is the CODE BOOK for the Tidy Data Project for Coursera, JHU course
“Getting and Cleaning Data”

There are a total of 11880 observations with 4 variables to form a narrow tidy data set

-   Subject_Number: The subject number that the data corresponds to.
    There are 30 subjects (e.g. 1 means Subject 1)
-   Original_Data_Set: THIS IS REMOVED FROM THE FINAL DATA SET PER
    PROJECT PROMPT  
    This variable indicates if the data came from the train or test data
    set originally with 2 total choices
    * Train  
    * Test
-   Activity: Activity performed by the subject during the specified
    measurement with 6 total choices
    * Walking (1 in input files)  
    * Walking Upstairs (2 in input files)  
    * Walking Downstairs (3 in input files)  
    * Sitting (4 in input files)  
    * Standing (5 in input files)  
    * Laying (6 in input files)  
-   Variable: This is the variable indicating one of 66 different measurements from the mean or standard deviation measurements from the input. Details below:  
    * Statistic  
        + Mean  
        + Standard Deviation  
    * Jerk Signal
        + (if present) Jerk function
    * Device/Type of Acceleration  
        + Linear Acceleration (Accelerometer)  
        + Angular Acceleration (Gyroscope)
    * Reference Fram
        + Body
        + Gravity
    * Component
        + X-axis of the phone
        + Y-axis of the phone
        + Z-axis of the phone
        + Magnitude
    * Domain
        + Time Domain
        + Frequency Domain (for Fourier Transforms)



Input Files Code Book
---------------------

The input data was provided by the course per a project prompt and came from:  
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" class="uri">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>  

For the Code Book of the input files, please refer to the following
documents provided by the data set as follows  
(Note: Files names below refer to what is provided in the zip file for
the input data)  

-   README.txt - Provides an overall readme information
for the data  
-   activity_labels.txt - Provides the activity label for the
corresponding number as the data inputed has activity labeled by
number  
-   features_info.txt - provides more detailed information on what the
measurement variables  
-   features.txt - provides the column order for the measurement variable
data provided in the x_train and x_test text files

Additional information regarding the input files:  

-   subject_train.txt - The subject number that corresponds to the measurement data rows in x_train.txt  
-   subject_test.txt - The subject number that corresponds to the measurement data rows in x_test.txt  
-   x_train.txt - Training Measurement data (columns are features.txt)  
-   y_train.txt - Activity number that corresponds to the measurement data rows in x_train.txt  
-   x_test.txt - Activity number that corresponds to the measurement data rows in x_test.txt
-   y_test.txt - Testing Measurement data (columns are features.txt)  
