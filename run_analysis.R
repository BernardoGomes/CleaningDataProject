#
#coursera 
#getting and cleaning data
#course project

#load necessary libraries

library(utils)
library(dplyr)
library(tidyr)
library(plyr)


#file url
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#my local path
path <- "C:/Users/Bernardo/Documents/Coursera/03 - Getting and Cleaning Data/RStudio/Project"
#set my local path to guarantee i´m working at the right place
setwd(path)
#local file name
localfile <- "data.zip"
#check to see if it is already there
if(!file.exists(localfile))
{
    #if it isn't, download it
    setInternet2(use=TRUE)
    download.file(fileurl, destfile=localfile, mode="wb")
}
#directory to unzip the files
folder <- "unzipped_data"
if(!file.exists(folder))
    dir.create(folder)

#unzip the files 
unzip(localfile, overwrite=TRUE, exdir=folder)

#locating the files 
features.names.path <- './unzipped_data/UCI HAR Dataset/features.txt'
training.path <-  './unzipped_data/UCI HAR Dataset/train/X_train.txt'
test.path <- './unzipped_data/UCI HAR Dataset/test/X_test.txt'
activities.path <- './unzipped_data/UCI HAR Dataset/activity_labels.txt'
activity.training.path <- './unzipped_data/UCI HAR Dataset/train/Y_train.txt'
activity.test.path <- './unzipped_data/UCI HAR Dataset/test/Y_test.txt'
subject.train.path <- './unzipped_data/UCI HAR Dataset/train/subject_train.txt'
subject.test.path <- './unzipped_data/UCI HAR Dataset/test/subject_test.txt'


#check to see if the files exist
if(file.exists(training.path) &&
       file.exists(features.names.path) && 
       file.exists(test.path))
{
    #we´re good to go
    #read the files   
    features <- read.table(features.names.path, stringsAsFactors = FALSE)
    training.set <- read.table(training.path)
    test.set <- read.table(test.path)
    activities.set <- read.table(activities.path)
    training.activity.set <- read.table(activity.training.path)
    test.activity.set <- read.table(activity.test.path)
    training.subject.set <- read.table(subject.train.path)
    test.subject.set <- read.table(subject.test.path)
    
    #setting the column names to the activities.set 
    colnames(activities.set) <- c("activity.id", "activity.description")
    
    #just a little control over the loaded data
    print(paste('number of features:',nrow(features))) #should be 561
    print(paste('number of training rows:', nrow(training.set))) #should be 7352
    print(paste('number of testing rows:',nrow(test.set))) #should be 2947
    
    #creating an additional column in each set
    training.set <- mutate(training.set, type.of.observation = "training")
    test.set <- mutate(test.set, type.of.observation = "testing")
    
    #merging the type of activity to each set
    training.set <- cbind(training.set, training.activity.set)
    test.set <- cbind(test.set, test.activity.set)
    
    #merging the subject to each set
    training.set <-cbind(training.set, training.subject.set)
    test.set <- cbind(test.set, test.subject.set )
    
    #merging the training and test sets
    full.set <- rbind(training.set, test.set)
    
    #applying the colnames to the full set
    features <- rbind(features,c(nrow(features)+1,"type.of.observation"))
    features <- rbind(features,c(nrow(features)+1,"activity.id"))
    features <- rbind(features,c(nrow(features)+1,"subject.id"))
    
    column.names <- make.names(features[,2], unique=TRUE, allow_=TRUE)
    colnames(full.set) <- column.names
    
    #merging the full.set with the activity description

    full.set <- join(full.set, activities.set)
    
    
    #getting the correct columns to the tidy dataset
    means.set <- select(full.set, contains("mean"))
    std.set <- select(full.set, contains("std"))    
    
    
    tidy.set <- cbind(means.set, std.set, 
                      select(full.set, contains("type.of.observation")), 
                      select(full.set, contains("activity.description")),
                      select(full.set, contains("subject.id")))
    
    #summarizing the tidy.set
    sum.set <- group_by(tidy.set, subject.id, activity.description)

    
    
    summary(sum.set)
    teste <- tbl_df(sum.set)
    
    
    summarise(sum.set, mean())
        
    
    print(dim(full.set))
}




