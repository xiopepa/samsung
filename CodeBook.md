CodeBook
Description: a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

Assumptions

It is assumed that the Samsung data is unzipped into the working directory /data.

In other words, it should be like this:
  
  ---
  |
  |---run_analysis.R
|
  |---data/UCI HAR Dataset/
  Variables

105-107

mergedData <- mergeData("data/UCI HAR Dataset")
extractedMeanStdDataSet <- extractMeanStd(mergedData, "data/UCI HAR Dataset")
meltDataWriteTidySet(extractedMeanStdDataSet, "./tidyset.txt")

These are the lines of code that the process cleans the data.

Major variables at the global environment are therefore:
  
  mergedData: the data table containing the merged training and test dataset from X_test.txt and X_train.txt. This amounts to 10299 observations with 564 columns. The columns include the 561 features stated in features.txt and added Subject, Activity Id, and Activity columns which are taken from the various activities.txt and y labels. Column headers are included.
extractedMeanStdDataSet: the data table containing 10299 observations of 69 columns. This is derived by subsetting the merged_data from above. The 69 columns include the subject, activity, activity id columns. The other 66 columns are the columns with either the characters mean() or std() in the column headers. Column headers are included.
mergeData

Data of mergeData

We take data from the following text files:
  
  test/X_test.txt will give us the local variable, testData containing all the 541 columns of raw data in the test set
train/X_train.txt will give us the local variable, trainData containing all the 541 columns of raw data in the training set
activities.txt will give us the local variable, activityLabels containing all the different types of activities: WALKING, WALKING_UPSTAIRS, SITTING, etc
train/subject_train.txt will give us the local variable, subjectTrain containing all the possible subject data inside the training set.
test/subject_test.txt will give us the local variable, subjectTest containing all the possible subject data inside the test set.
train/y_train.txt will give us the local variable, yTrain containing all the possible label data inside the training set.
test/y_test.txt will give us the local variable, yTest containing all the possible label data inside the test set.
Transformations inside merge_data

yTrainLabels is the merged data table of the label data based on the activity labels for training set because y_train alone tells us just 1, 2,3 when we want to have tha actual labels displayed as WALKING, etc.
yTestLabels is the merged data table of the label data based on the activity labels for test set because y_test alone tells us just 1, 2,3 when we want to have tha actual labels displayed as WALKING, etc.

trainData is the merged data table of the training data with the subject, activity, activity id, and the other 541 variables

testData is the merged data table of the test data with the subject, activity, activity id, and the other 541 variables

allData is the merged version of trainData and testData

extractMeanStd

Data of extractMeanStd

Inside the function extractMeanStd, we take data from the following text files:
  
  features.txt will give us the local variable, features_data containing all the 541 features and their names
Transformations inside extractMeanStd

meanStdRows is the subset data from the features_data where just the mean() and std() columns are extracted.
perform a colnames() on the giant data set to have the 3 new columns and the column headers for subject, activity, and activity id
meanColumns is the extracted data from the data_set where the mean() columns are extracted.
stdColumns is the extracted data from the data_set where the std() columns are extracted.
meanStdColumnVector is the vector containing the meanColumns and stdColumns and sorted.
extractedDataSet is the final data table containing the mean and std columns and the 3 additional columns of Suject, Activity, and Activity Id
meltDataWriteTidySet

Data of meltDataWriteTidySet

All local variables inside this function are all derived after transformations
Transformations inside meltDataWriteTidySet

meltedData is the data after performing meltData on the data_set parameter so that we can isolate down to just 66 observations.
tidyData is the data after performing dcast on the melted_data so that we can get the mean of the related activities across the different variables of the data.
colNames_vector is the data vector containing new formatted column headers where we replace mean() with Mean, std() with Std, and BodyBody with Body
tidyData will then be "crowned" with the new column headers from colNamesVector