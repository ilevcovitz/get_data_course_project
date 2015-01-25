library(dplyr)

#download general files
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#download train data sets
train_X <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

#download test data sets
test_X <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")


#combine train and test data
X <- rbind(test_X, train_X)
y <- rbind(test_y, train_y)
subject <- rbind(test_subject, train_subject)

#make data frame y into descriptive names using activity labels file
y_descriptive <- merge(y, activity_labels, by.x="V1", by.y="V1")
y <- y_descriptive$V2

#give X data set descriptive names based on features file
names(X) <- features$V2

#combine columns of data sets
data <- cbind(subject,y,X)

#name other columns of data descriptive names
names(data)[1] <- "subject"
names(data)[2] <- "activity"

#find all columns containing the words "std" and "mean"
std_columns <- grep("std",names(data))
mean_columns <- grep("mean",names(data))
mean_std_columns <- c(std_columns, mean_columns)

#subset data frame with only subject column, activity column and columns containing mean and std information.
#order() is used to have columns in original order they appeared in dataset 
data <- data[,order(c(1,2,mean_std_columns)) ]

#replace dashes in name with underscore. Replace parenthesis in names too. Escape characters are used for parenthesis.
names(data) <- gsub("-","_",names(data))
names(data) <- gsub("\\(\\)","",names(data))

#CREATE NEW TIDY DATA FRAME NAMED tidy_data

#create a dataframe with each subject paired with corresponding activities. 
groups <- summarize(group_by(data,subject,activity))
groups <- data.frame(groups)

tidy_data <- data.frame()

#for each subject, activity combination, calculate column means
for(i in 1:nrow(groups) ){
  
  subset <- filter(data, subject==groups[i,1] & activity==groups[i,2])
  #want to select only numerical columns
  subset <- subset[,3:ncol(data)]
  #take mean
  subset_mean <- colMeans(subset)
  #bind new row to tidy_data
  tidy_data <- rbind(tidy_data,subset_mean)
}
#add non numeric columns to tidy data
tidy_data <- cbind(groups, tidy_data)
#give appropriate names to columns
names(tidy_data) <- names(data)

write.table(tidy_data, "tidy_data_summary.txt", row.name=FALSE)
