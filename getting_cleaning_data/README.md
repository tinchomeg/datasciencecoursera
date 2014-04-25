#Getting and Cleaning Data Project

###Listing of files
The entire code for the project is contained in the R Script 'run_analysis.R'

###Description of script
This script follows the following steps to generate a tidy dataset from the original files:    
* Load the required package 'reshape2'
* Extract the contents of the file 'UCI HAR Dataset.zip'
* Read the file 'activity_labels.txt' with the activity codes and names
* Read both files 'test/subject_test.txt' and 'train/subject_train.txt' and bind them together
* Read both files 'test/test/y_test.txt' and 'train/y_train.txt' and bind them together
* Bind together subjects and activity codes for each measurement, and merge with activity names
* Read file 'features.txt' with the feature names for each column of the measurements file
* Read both files 'test/test/X_test.txt' and 'train/X_train.txt' and bind them together
* Get column indices for features on mean and standard deviation
* Subset measurements selecting only the columns from the previous step
* Bind together subjects, activities and measurements in one dataset
* Apply melting and casting to get the average of each variable for each activity and each subject
* Write final tidy dataset to file 'uci_har_clean_dataset.txt'