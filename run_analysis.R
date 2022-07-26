# 1. Merges the training and the test sets to create one data set.

setwd("~/Library/Mobile Documents/com~apple~CloudDocs/R/Cousera/Getting and Cleaning Data/week4/Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test")
x_test <- read.table("x_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
test <- cbind(subject_test, y_test, x_test) 

setwd("~/Library/Mobile Documents/com~apple~CloudDocs/R/Cousera/Getting and Cleaning Data/week4/Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train")
x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
train <- cbind(subject_train, y_train, x_train)

testrain <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/R/Cousera/Getting and Cleaning Data/week4/Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset")
features <- read.table("features.txt")
add2row <- data.frame("V1" = c("NA", "NA"), "V2" = c("subid", "activity"))
newfeatures <- rbind(add2row, features)
colnames(testrain) <- newfeatures$V2 
testrain_meanstd <- select(testrain, subid, activity, contains("mean()"), contains("std()"))

# 3. Uses descriptive activity names to name the activities in the data set

activity <- read.table("activity_labels.txt")
testrain_meanstd$activity <- activity[testrain_meanstd$activity, 2]

# 4. Appropriately labels the data set with descriptive variable names. 

names(testrain_meanstd)<-gsub("Acc", "Accelerometer", names(testrain_meanstd))
names(testrain_meanstd)<-gsub("Gyro", "Gyroscope", names(testrain_meanstd))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subgroup_testrain_meanstd <- group_by(testrain_meanstd, subid, activity)
finaldata <- summarise_all(subgroup_testrain_meanstd, mean)


