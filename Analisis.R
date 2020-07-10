#courseproject getting and cleaning data coursera 
library(dplyr)
library(data.table)

wd<- getwd()
filename <- paste(wd, "/Coursera_DS3_Final.zip", sep = '')

# Checking existence of data
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

#saving features and activity data
features <- read.table("./UCI HAR Dataset/features.txt") #column2 represents the column name for x_train 
activities <- read.table("./UCI HAR Dataset/activity_labels.txt") #use as key for y_train

#reading train folder
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subjects
x_train<- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(x_train)<- features[,2]
y_train<- read.table("./UCI HAR Dataset/train/y_train.txt")
        #create new columns in x_train with the info of y_train and subject
x_train$activity<- y_train[,1]
x_train$subject<- subject_train[,1]


#reading test folder, same process as above
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[,2]
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
        #create new columns in x_test with the info of y_test and subject
x_test$activity <- y_test[,1]
x_test$subject <- subject_test[,1]


###
###
                ###Reading completed, proceeding to merge data
###
###
                ###1)Merges the training and the test sets to create one data set.
data<- rbind(x_train, x_test)
                
                ###2)Extracts only the measurements on the mean and standard deviation for each measurement.

info<- data%>%select(activity, subject, contains('mean'), contains('sd'))

                ###3)Uses descriptive activity names to name the activities in the data set

for (i in 1:nrow(info)) {  #assigning the activity to the number
        for (j in 1:6) {
                if(info[i,1]==activities[j,1]) {
                        info[i,1]<- activities[j,2]
                        break
                }
        }
}

                ###4)Appropriately labels the data set with descriptive variable names.

colnames(info)<- tolower(names(info))%>% gsub(pattern = '-', replacement = '')%>%
        gsub(pattern = '\\()', replacement = '')


                ###5)creates a second, independent tidy data set with the average of each variable for each activity and each subject.


tid<- info %>%
        group_by(subject, activity) %>%
                summarise_all(.funs = mean)



