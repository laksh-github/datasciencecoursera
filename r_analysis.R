#read x test into features_test
features_test = read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
#read x train into features_train
features_train = read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#read y test into activity_test
activity_test = read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
#read y train into activity_train
activity_train = read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)

#read subject_test into subject_test
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
#read subject train into subject_train
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

#combine train and test dataframes
features = rbind(features_train, features_test)
subject = rbind(subject_train, subject_test)
activity = rbind(activity_train, activity_test)

#read features column names
featureNames = read.table("UCI HAR Dataset/features.txt", header = FALSE)
colnames(features) = featureNames$V2

#filter mean and std from features (data) columns
MSDfeatures = grep("mean|std", featureNames$V2 )
features = features[, MSDfeatures]

#add column names to subject and activity
colnames(subject) = "subject"
colnames(activity) = "activity"

#combine features,  subject and activity
final_data = cbind(features, subject, activity)

#read activity lables
activity_lables = read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
#and give column names to join the dataframe with final_data dataframe 
colnames(activity_lables) = c("activity", "activityName")


library("plyr")

#join by "activity" in final_data & activity_lables
final_data1 = join(final_data, activity_lables, by = "activity", match = "first")

#update the column names to descriptive variable names
names(final_data1) = gsub("Acc", "Accelerometer", names(final_data1))
names(final_data1) = gsub("^t", "time", names(final_data1))
names(final_data1) = gsub("^f", "frequency", names(final_data1))
names(final_data1) = gsub("BodyBody", "Body", names(final_data1))
names(final_data1) = gsub("Mag", "Magnitude", names(final_data1))
names(final_data1) = gsub("Freq", "Frequency", names(final_data1))

#aggregate the mean of each variable for each activity and each subject.
final_data2 = aggregate(. ~subject + activity, final_data1, mean)
final_data2 = final_data2[order(final_data2$subject,final_data2$activity),]
write.table(final_data2, "tidy_dataset.txt", row.names = FALSE)
