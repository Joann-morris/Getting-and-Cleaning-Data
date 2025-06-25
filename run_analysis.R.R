library(dplyr)

filename <- "dataset.zip"

if (!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method = "auto")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "featureNames"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$featureNames, check.names = TRUE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$featureNames, check.names = TRUE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

merged_data <- cbind(subject_data, y_data, x_data)

selected_columns <- grepl("mean|std", names(x_data), ignore.case = TRUE)
selected_data <- merged_data[, c(TRUE, TRUE, selected_columns)]

selected_data$code <- activities$activity[match(selected_data$code, activities$code)]

names(selected_data) <- gsub("^t", "Time", names(selected_data))
names(selected_data) <- gsub("^f", "Frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))

tidy_data <- selected_data %>%
  group_by(subject, code) %>%
  summarise(across(everything(), mean))

write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)



