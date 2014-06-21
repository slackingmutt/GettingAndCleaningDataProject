###########################################################
#
# Coursera Getting and Cleaning Data Project
# June 20, 2014
# D. Lingle
#
# Note that a data table is used
# Assumption: the working directory contains data in subdirectories
#
###########################################################
library(data.table)
# read the training and test data
# train
train.data <- data.frame(read.table("./train/X_train.txt"))
train.activity <- data.frame(read.table("./train/y_train.txt"))
train.subjects <- data.frame(read.table("./train/subject_train.txt"))
# test
test.data <- data.frame(read.table("./test/X_test.txt"))
test.activity <- data.frame(read.table("./test/y_test.txt"))
test.subjects <- data.frame(read.table("./test/subject_test.txt"))
# combine the training, test and subject data into individual data frames
project.data <- rbind(train.data,test.data)
project.activity <- rbind(train.activity,test.activity)
project.subjects <- rbind(train.subjects,test.subjects)
# read the observed variables as features
features <- data.frame(read.table("./features.txt"))
# label the data columns with the features
names(project.data) <- features[,2]
# Get the activities into the data
# First convert the coded numbers into descriptive text
names(project.activity) <- "Activity"
# note that the result of this operation is a vector
convert.code.to.names <- c('1' = 'Walking','2' = 'Walking_upstairs','3' = 'Walking_downstairs',
                           '4' = 'Sitting','5' = 'Standing','6' = 'Laying')
Activity <- convert.code.to.names[project.activity$Activity]
# add activity to the project data
project.data <- cbind(Activity,project.data)
# add the subjects to the project,data
names(project.subjects) <- "Subjects"
project.data <-cbind(project.subjects,project.data)
# locate the features that denote means or stds
ms.feat <- grep("mean|std",as.character(features[,2]))
# subset those columns from the entire data set
project.data <- project.data[,ms.feat]
# Consolidating the rows by means is easier with a data.table
project.data <- data.table(project.data)
# specify the columns to be used to compute the mean
keys <- setdiff(names(project.data),c("Subjects","Activity"))
# now compute the statistic
project.mean <- project.data[,lapply(.SD,mean),by=c("Subjects","Activity"),.SDcols=keys]
dim(project.mean)
#[1] 180  79
# now set the key to get the data sorted
setkey(project.mean,Subjects)
