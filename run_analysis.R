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

    
    #for some reason grouping and summarizing the tidy.set 
    #with 
    
    #sum.set <- group_by(tidy.set, subject.id, activity.description)
    #and summarise is not working. 
    
    #so this is the way i am working around it
    
    #creating a subject collection
    subjects <- arrange(distinct(select(tidy.set, subject.id)),subject.id)
    
    #setting the column names for the result set
    column.names <- colnames(tidy.set[1:86])
    #adding the extra columns
    column.names[87] <- "activity.id"
    column.names[88] <- "subject.id"
    
    #ajust the column names
    column.names <- str_replace_all(column.names, "std","Standard")
    
    result <- as.data.frame(matrix(nrow=0, ncol=88))
    for(i in 1:nrow(subjects))
    {
        for(j in 1:nrow(activities.set))
        {
            subject <- subjects[i,]
            act <- activities.set[j,2]
            #print(paste(subject, act))
    
            filtered.set <- filter(tidy.set, activity.description == act, subject.id == subject)
            average.data <- colMeans(filtered.set[1:86])
            average.data[87] <- act
            average.data[88] <- subject
            
            result <- rbind(result,average.data)
        }
    }
    
    colnames(result) <- column.names
    
    result <- join(result, activities.set)
    
    #View(result)
    
    #write the result file
    write.table(result, file= "tidy.data.txt", row.name=FALSE)

}




