# samsung
Analysis data samsung

## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Activity                  Variables
1. Read activity labels: activity_labels
2. Read data column names: features
3. Extract only the measurements on the mean and standard deviation for each measurement: extract_features
4. Read and process X_test & y_test data: X_test, Y_test, subject_test
5. Extract only the measurements on the mean and standard deviation for each measurement.
6. # Load activity labels
7. Bind data
8. Read and process X_train & y_train data: X_train, Y_train
9. subject_train
10. Extract only the measurements on the mean and standard deviation for each measurement: X_train
11. Load activity data
12. Merge test and train data
13. Apply mean function to dataset using dcast function
