Description
The requirements are:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Functions

mergedata which will handle the the 1st, 3rd, and 4th requirements extractmeanstd which will handle the 2nd, 3rd, and 4th requirements meltdataandwritetidyset which will handle the 5th requirement and write out the tidy set file

A helper function readtidyset is provided to read the generated tidyset inside R.

mergedata

Purpose: to merge all the data from the various text files into a single giant data table. No subset or extractions performed on the data set once merged.

Parameters: directory: a character vector that indicates the folder residing inside the working directory

Value: alldata: a merged data table containing training and test data and 3 additional columns for subject, activity, and activity id. This amounts to 10299 observations of 564 variables

extractmeanstd

Purpose: Performs subset on the giant data set of merged data to extract just the mean and std related data

Parameters: dataset: a data table containing the training set and test set data and 3 additional columns for subject, activity, and activity id directory: a character vector that indicates the folder residing inside the working directory

Value: extracteddataset: after performing subset on the dataset parameter, this is a data table that contains just 10299 observations of 69 variables basically the same 3 additional columns of subject, activity, and activity id plus the 66 columns whose headers contain the characters mean() and std()

meltdataandwritetidyset

Purpose: Performs melt data, casting back to tidy data format, and then writing the data out to a text file

Parameters: extractedmeanstddataset: a data table containing the training set and test set data and 3 additional columns for subject, activity, and activity id but has already extracted out the mean and std columns pathtotidysetfile: a character vector that indicates the path to write the tidy set file to

Value: nil

readtidyset

Purpose: Reads the tidy set file back into data table

Parameters: pathtotidysetfile: a character vector that indicates the path to the tidy set file

Value: datatable of data inside the tidy set file
