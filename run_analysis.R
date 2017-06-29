## Initial settings.
packages <- c('data.table', 'reshape2')
sapply(packages, require, character.only=TRUE, quietly=TRUE)

setwd('~/Desktop/coursera/GettingAndCleaningData/GettingAndCleaningData')

library(reshape2)

filename <- 'getdata_dataset.zip'

## Download the dataset and unzip it.
if (!file.exists(filename)){
  fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip '
  download.file(fileURL, filename, method='curl')
}  

if (!file.exists('UCI HAR Dataset')) { 
  unzip(filename) 
}

# Load activity labels and features catalogue from the dataset.
activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table('UCI HAR Dataset/features.txt')
features[,2] <- as.character(features[,2])


# Extract only the data of features corresponding to mean and standard deviation.
featuresSelected <- grep('.*mean.*|.*std.*', features[,2])
featuresSelected.names <- features[featuresSelected,2]
featuresSelected.names = gsub('-mean', 'Mean', featuresSelected.names)
featuresSelected.names = gsub('-std', 'Std', featuresSelected.names)
featuresSelected.names <- gsub('[-()]', '', featuresSelected.names)


# Load data from the datasets and bind all together for train data and for test data.
train <- read.table('UCI HAR Dataset/train/X_train.txt')[featuresSelected]
trainActivities <- read.table('UCI HAR Dataset/train/Y_train.txt')
trainSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table('UCI HAR Dataset/test/X_test.txt')[featuresSelected]
testActivities <- read.table('UCI HAR Dataset/test/Y_test.txt')
testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
test <- cbind(testSubjects, testActivities, test)


# Merge the bind datasets just binding their rows and add labels.
allMeasuredData <- rbind(train, test)
colnames(allMeasuredData) <- c('subject', 'activity', featuresSelected.names)


# Convert activities and subjects into factors.
allMeasuredData$activity <- factor(allMeasuredData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allMeasuredData$subject <- as.factor(allMeasuredData$subject)

allMeasuredData.melted <- melt(allMeasuredData, id = c('subject', 'activity'))
allMeasuredData.mean <- dcast(allMeasuredData.melted, subject + activity ~ variable, mean)

write.table(allMeasuredData.mean, 'tidy.txt', row.names = FALSE, quote = FALSE)