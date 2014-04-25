#loading required package reshape2
hasReshape <- suppressWarnings(require("reshape2", quietly = T))

if(!hasReshape) {
  
  warning("Package 'reshape2' not found.", call. = F)
  warning("Install the required package before proceeding.", call. = F)
  
} else if (!file.exists("UCI HAR Dataset.zip")) {
  
  warning("File 'UCI HAR Dataset.zip' not found.", call. = F)
  
} else {
  
  #unzip the content of the zip, assuming that it is in the current folder
  unzip("UCI HAR Dataset.zip")
  
  #load activity names
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  colnames(activity_labels) <- c("ActivityCode", "ActivityName")
  
  #load and merge subject row
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject <- rbind(subject_test, subject_train)
  colnames(subject) <- c("Subject")
  
  #remove temporary variables
  rm(hasReshape, subject_test, subject_train)
  
  #load and merge activity code row
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  activity_codes <- rbind(y_test, y_train)
  colnames(activity_codes) <- c("ActivityCode")
  
  #remove temporary variables
  rm(y_test, y_train)
  
  #merge subject and activity rows
  dataset <- merge(activity_codes, activity_labels, sort = F)
  dataset <- cbind(subject, dataset)
  
  #remove temporary variables
  rm(activity_labels, subject, activity_codes)
  
  #load features
  features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)
  colnames(features) <- c("FeatureRow", "FeatureName")
  
  #load and merge measurements set
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  xset <- rbind(x_test, x_train)
  colnames(xset) <- features$FeatureName
  
  #remove temporary variables
  rm(x_test, x_train)
  
  #subsetting measurements on mean() and std()
  mean_std_cols <- grep("mean\\(\\)|std\\(\\)", features$FeatureName)
  xset <- xset[mean_std_cols]
  
  #remove temporary variables
  rm(features, mean_std_cols)
  
  #combine subjects, activities and measurements
  dataset <- cbind(dataset, xset)
  
  #remove temporary variables
  rm(xset)
  
  #apply melting and casting to get the average
  #of each variable for each activity and each subject
  dataset <- melt(dataset, id = c(1:3))
  dataset <- dcast(dataset, Subject + ActivityCode + ActivityName ~ variable, mean)
  
  #write tidy data set to a txt file (uci_har_clean_dataset.txt)
  write.table(dataset, "uci_har_tidy_dataset.txt", quote = F, row.names = F)
  
}