# TidyData_UCI_HAR_DataSet
Performing tidy data with R on UCI HAR Dataset

# Scope
The purspose of this project is to create a tidy data set from the UCI HAR dataset. A full description of the UCI HAR dataset
can be obtained at his site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data files for the project can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Included Files

The following files are included in this project:
  - An R script file called run_analysis.R which performs the following opeations:
  1. Imports the test, train and subject data files
  2. Merges the test, train and subject data files into one single data file.
  3. Extracts only the measurements of the mean and standard deviation for each measurement
  4. Adds labels to the data and cleans up the variable names.
  5. Creates a tidy dataset of the the averaged for each varaiables. 
  
  - A codebook showing all the variables and summaries calculated
  
  - A tidy datase of the averaged data for each variable
