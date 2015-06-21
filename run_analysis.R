# 1. Merges the training and the test sets to create one data set
# change dir to such as .../UCI HAR Dataset/

# upload X data
X_train_temp <- read.table("train/X_train.txt")
X_test_temp <- read.table("test/X_test.txt")
X <- rbind(X_train_temp, X_test_temp) #10299*561

# upload Y data
Y_train_temp <- read.table("train/y_train.txt")
Y_test_temp <- read.table("test/y_test.txt")
Y <- rbind(Y_train_temp, Y_test_temp) #10299*1

# upload Subject (S) data
S_train_temp <- read.table("train/subject_train.txt")
S_test_temp <- read.table("test/subject_test.txt")
S <- rbind(S_train_temp, S_test_temp) #10299*1


# 2. Extracts only the measurements on the mean and standard deviation for each measurement

# upload features data
desired_features <- read.table("features.txt")
# identify indicies of desired feature and set them into X
features_indices <- grep("-mean\\(\\)|-std\\(\\)", desired_features[, 2])
X <- X[, features_indices] #10299 * 66
# set the names appropriately 
names(X) <- desired_features[features_indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))


# 3. Uses descriptive activity names to name the activities in the data set

# upload activities data
activities <- read.table("activity_labels.txt")
# remove '_' for consistency and set values 
activities[, 2] = gsub("_", "", activities[, 2])
Y[,1] = activities[Y[,1], 2]  #10299*1
# set the name to activity 
names(Y) <- "activity"


# 4. Appropriately labels the data set with descriptive variable names

# set the names appropriately 
names(S) <- "subject"
# combine all 3 (Subject, Y , X)
combined <- cbind(S, Y, X) #10299*68


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# set up the tidy result data frame
Subject_num <- length(table(S)) #30
Activities_num <- dim(activities)[1] #6
Column_num <- dim(combined)[2] #68
tidy <- matrix(NA, nrow=Subject_num * Activities_num, ncol=Column_num)
tidy <- as.data.frame(tidy) #180*68
colnames(tidy) <- colnames(combined)  

# variables for loop
row <- 1
uniqueSubjects <- unique(S)[,1]

# loop that goes through all subjects and activities to calculate the average accordingly  
for (i in 1:Subject_num) {
    for (j in 1:Activities_num) {
        tidy[row, 1] = uniqueSubjects[i]
        tidy[row, 2] = activities[j, 2]
        tmp <- combined[combined$subject==i & combined$activity==activities[j, 2], ]
        tidy[row, 3:Column_num] <- colMeans(tmp[, 3:Column_num])
        row = row+1
    }
}

# export the tidy results 
write.table(tidy, "tidy_result_Q5.txt", row.name=FALSE)
