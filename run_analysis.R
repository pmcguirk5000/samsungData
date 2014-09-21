library(plyr)

#load training data
trainingSet <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
trainingLabels <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- as.interger(subject_train)

#load test data
testSet <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
testLabels <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)

features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)




#Question1 - combine the training and test sets
combinedSet <- rbind(trainingSet, testSet)
combinedLabels <- rbind(trainingLabels, testLabels)
combinedSubject <- rbind(subject_train, subject_test)

#Question2 - grep out the mean and std dev for each measurement
meanStd<- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
combinedSetMeanStd <- combinedSet[, meanStd]

#Question3- use descriptive activity names to name the activities in the data set
combinedLabels[, 1] = activity_labels[combinedLabels[, 1], 2]
colnames(combinedLabels) <- 'activity'
colnames(combinedSubject) <- 'subject'

#Question4 - appropriately label data set with descriptive variable names
dataSet <- cbind(combinedSubject, combinedSetMeanStd, combinedLabels)

#Question5 - from the data set in step 4, 
#create a second, independent tidy data set 
# with the average of each variable for each activity and subject
tidyDataSet <- aggregate(dataSet, list(activity = dataSet$activity, subject = dataSet$subject), mean)
