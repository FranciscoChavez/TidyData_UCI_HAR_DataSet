

## run_analysis.R
## by: Francisco J. Chavez



#Install necessary libraries
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre7')
install.packages("rJava")
library(rJava)

install.packages("xlsx")
library(xlsx)

library(stringr)
library(dplyr)


##Check if working directory is the UCI HAR Dataset Directory
myDir <- getwd()
myDir


## Read the x_test, y_test and subject_test files from the test folder
setwd("test")
getwd()
x_test <- read.table("X_test.txt")
y_test <- read.table("Y_test.txt")
subject_test <- read.table("subject_test.txt")

## Read the x_test, y_test and subject_test files from the test folder
setwd("..")
setwd("train")
getwd()

x_train <- read.table("X_train.txt")
y_train <- read.table("Y_train.txt")
subject_train <- read.table("subject_train.txt")

## Review the datasets 
View(x_test)
View(x_train)

View(y_test)
View(y_train)

View(subject_test)
View(subject_train)

##1. merge the train and test files

xsignals<- rbind(x_test, x_train)
ysignals<- rbind(y_test, y_train)
subjects <- rbind(subject_test, subject_train)

## Review the merged datasets
View(xsignals)
dim(xsignals)
View(ysignals)
dim(ysignals)
View(subjects)
dim(subjects)

## Get the list of features and make syntatically valid names
setwd("..")
getwd()
features <- read.table("features.txt")[,2]
listOfFeatures <- make.names(features, unique=TRUE)

dim(xsignals)
names(xsignals) <- listOfFeatures
View(xsignals)
dim(xsignals)

##Extract only the measurements on the mean and standard deviation for each 
##measurement

columnIndexes = sapply(listOfFeatures, function(colname){grepl(colname, pattern= "\\.std.") | 
    grepl(colname, pattern= "\\.mean.")})

xsignals <- xsignals[, columnIndexes] 
dim(xsignals)

## Bind the Subject and Activity Columns into one dataset
dim(subjects)
dim(ysignals)
View(subjects)
View(ysignals)

data <- cbind(subjects, ysignals)
dim(data)

#Add labels to the combined data
names(data) <- c("subject", "activity")
View(data)

## bind varoables to data and order by activity
data <- cbind(data, xsignals)
data <- data[order(data[,2]),]
View(data)

##Read the labels (activities) and add labels to the activity column

labels <- read.table("activity_labels.txt")[,2]
View(labels)
data[,2] <- factor(data[,2], labels= labels)
View(data)

## Clean up variable names for activities.
names(data) <- str_replace_all(names(data), "[.][.]", "")
names(data) <- str_replace_all(names(data), "[.]X","XAxis")
names(data) <- str_replace_all(names(data), "[.]Y","YAxis")
names(data) <- str_replace_all(names(data), "[.]Z","ZAxis")
names(data) <- str_replace_all(names(data), ".mean","Mean")
names(data) <- str_replace_all(names(data), ".std","StandardDeviation")
names(data) <- str_replace_all(names(data), "BodyBody","Body")
names(data) <- str_replace_all(names(data), "tBody","Body")
names(data) <- str_replace_all(names(data), "fBody","FFTBody")
names(data) <- str_replace_all(names(data), "tGravity","Gravity")
names(data) <- str_replace_all(names(data), "fGravity","FFTGravity")
names(data) <- str_replace_all(names(data), "Acc","Acceleration")
names(data) <- str_replace_all(names(data), "Gyro","AngularVelocity")
names(data) <- str_replace_all(names(data), "Mag","Magnitude")
View(data)
dim(data)

grouped_data <- group_by(data, subject, activity)
View(grouped_data)
summarized_data <- summarise_each(grouped_data, funs(mean))
View(summarized_data)
dim(grouped_data)
dim(summarized_data)
write.table(grouped_data, row.name=FALSE, file='tidy_dataset.txt')
write.table(summarized_data, row.name=FALSE, file='tidyaveraged_dataset.txt')

