library(reshape2)

# Read in training set & training labels
train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_lab <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read in test set & test labels
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_lab <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read in features
feat <- read.table("UCI HAR Dataset/features.txt")

set_col_lab <- feat[,2]	# labels are in second column of df

## Step 4: Appropriately label the data set with descriptive variable names
colnames(train_set) <- set_col_lab
colnames(train_lab) <- "Activity"
colnames(train_subject) <- "Subject"

colnames(test_set) <- set_col_lab
colnames(test_lab) <- "Activity"
colnames(test_subject) <- "Subject"

# Merge training data
train <- cbind(train_lab,train_subject,train_set)

# Merge testing data
test <- cbind(test_lab,test_subject,test_set)

## Step 1: Merge the training and the test sets to create one data set
data <- rbind(train,test)

# Read in Axctivity Labels
act_lab <- read.table("UCI HAR Dataset/activity_labels.txt")

colnames(act_lab) <- c("Activity","Activity_Name")


## Step 3: Use descriptive activity names to name the activities in the data set
data <- (merge(act_lab,data,by = 'Activity'))[,-1]


## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
data_m <- data[,grep("mean",colnames(data))]
data_std <- data[,grep("std",colnames(data))]

data_2 <- cbind(data[,1:2],data_m,data_std)

colnames(data_2)[1:2] <- c("Activity_Name","Subject")


## Step 5: From the data set, create a second, independent tidy data set with the average of each variable for each activity and each subject

# Melt df to show separate out ids and variables
data_melt <- melt(data_2,id=c("Activity_Name","Subject"))

# dcast to calculate mean for each id (for each variable column)
data_out <- dcast(data_melt,Activity_Name+Subject~variable,mean)


# Write output table into a .txt file
write.table(data_out,file="run_analysis_output.txt",row.name=FALSE)


