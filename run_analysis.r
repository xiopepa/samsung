## Create one R script called run_analysis.R that does the following:







## Assumed that the data are in /data
## ---
##  |
##  |---run_analysis.R
##  |
##  |---data/UCI HAR Dataset/

## in case you are not sure, 
## you can double check with the github repo 
## where this file is based in

## 1. Merges the training and the test sets to create one data set.
mergeData <- function(directory) {
  ## Dataset in test and train sets
  path <- paste("./", directory, "/test/X_test.txt", sep="")
  testData <- read.table(path)
  path <- paste("./", directory, "/train/X_train.txt", sep="")
  trainData <- read.table(path)
  
  ## Activity labels
  path <- paste("./", directory, "/activity_labels.txt", sep="")
  activityLabels <- read.table(path)
  
  ## Test and training subject labels
  path <- paste("./", directory, "/train/subject_train.txt", sep="")
  subjectTrain <- read.table(path)
  path <- paste("./", directory, "/test/subject_test.txt", sep="")
  subjectTest <- read.table(path)
  
  ## Test and training y labels
  path <- paste("./", directory, "/train/y_train.txt", sep="")
  yTrain <- read.table(path)
  path <- paste("./", directory, "/test/y_test.txt", sep="")
  yTest <- read.table(path)
  
  ## merge y test and training activity labels
  yTrainLabels <- merge(yTrain,activityLabels,by="V1")
  yTestLabels <- merge(yTest,activityLabels,by="V1")
  
  ## merge the test and training data and the respective labels together
  trainData <- cbind(subjectTrain,yTrainLabels,trainData)
  testData <- cbind(subjectTest,yTestLabels,testData)
  
  ## now then we'll merge the test and training data together
  allData <- rbind(trainData,testData)
  
  return (allData)
}

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## This is handled inside this function extract_mean_std(data_set, directory)
extractMeanStd <- function(dataSet, directory) {
  path <- paste("./", directory, "/features.txt", sep="")
  featuresData <- read.table(path)
  ## usually the columns is a data.table where V1 is the column number
  ## and V2 is the actual name
  ## subset only those rows where the name contains the word mean and std
  meanStdRows <- subset(featuresData,  grepl("(mean\\(\\)|std\\(\\))", featuresData$V2) )
  
  ## set the column headers for combined data with Subject, activity_id, activity
  colnames(dataSet) <- c("Subject","Activity_Id","Activity",as.vector(featuresData[,2]))
  
  ## extract the data from the merged data where the column names are mean OR std
  meanColumns <- grep("mean()", colnames(dataSet), fixed=TRUE)
  stdColumns <- grep("std()", colnames(dataSet), fixed=TRUE)
  
  ## put both mean and std columns into single vector
  meanStdColumnVector <- c(meanColumns, stdColumns)
  
  ## sort the vector 
  meanStdColumnVector <- sort(meanStdColumnVector)
  
  ## extract the columns with std and mean in their column headers
  extractedDataSet <- dataSet[,c(1,2,3,meanStdColumnVector)]
  return (extractedDataSet)
}

## 3. Uses descriptive activity names to name the activities in the data set
## this is done inside the merge_data and extract_mean_std functions
## 4. Appropriately labels the data set with descriptive activity names.
## this is also done inside the merge_data and extract_mean_std functions
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## This is done inside the meltData function
meltDataWriteTidySet <- function(dataSet, pathTidyFile) {
  ## let's melt the data
  require(reshape2)
  meltedData <- melt(dataSet, id=c("Subject","Activity_Id","Activity"))
  
  ## cast the data back to the tidyData format
  tidyData <- dcast(meltedData, formula = Subject + Activity_Id + Activity ~ variable, mean)
  
  ## format the column names
  colNamesVector <- colnames(tidyData)
  colNamesVector <- gsub("-mean()","Mean",colNamesVector,fixed=TRUE)
  colNamesVector <- gsub("-std()","Std",colNamesVector,fixed=TRUE)
  colNamesVector <- gsub("BodyBody","Body",colNamesVector,fixed=TRUE)
  
  ## put back in the tidy column names
  colnames(tidyData) <- colNamesVector
  
  ## write the output into a file
  write.table(tidyData, file=pathTidyFile, sep="\t", row.names=FALSE)
}

mergedData <- mergeData("data/UCI HAR Dataset")
extractedMeanStdDataSet <- extractMeanStd(mergedData, "data/UCI HAR Dataset")
meltDataWriteTidySet(extractedMeanStdDataSet, "./tidyset.txt")

## just to double check you can read the tidyset if you wished
readTidySet <- function(pathTidyFile) {
  tidySet <- read.table(pathTidyFile)
  
  return (tidySet)
}