# get_data_course_project
Course project for get data Coursera course

The repository contains the following files: 

    'run_analysis.R' : Runs analysis on data set from the Human Activity Recognition Using Smartphone Dataset Version 1.0

    'tidy_data_summary.txt' : A summary text file with mean values for each mean/std column corresponding to each subject     and activity.  

Requirement: 

    You must have the dplyr library to run run_analysis.R 

Instructions: 

    To run run_analysis.R in R. You must first download the dataset from:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

    Your working directory must also be set to the main directory of the UCI HAR dataset, which containsthe "test" and       "train" folder.

    To view tidy_data_summary.txt, your working directory can be set to the one containing tidy_data_summary.txt. Then       you may upload this file to R using the following command: 

    tidy_data_summary <- read.table("tidy_data_summary.txt", header=TRUE)
