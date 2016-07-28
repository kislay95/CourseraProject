

#Setting the path 
path_used <- getwd()

#Reading data from files

Activity_Test <- read.table(file.path(path_used,"test","Y_test.txt"),header = FALSE)
Activity_Train <- read.table(file.path(path_used, "train", "Y_train.txt"), header = FALSE)

Subject_Train <- read.table(file.path(path_used, "train", "subject_train.txt"), header = FALSE)
Subject_Test <- read.table(file.path(path_used, "test", "subject_test.txt"), header = FALSE)

Features_Train <- read.table(file.path(path_used, "train", "X_train.txt"), header = FALSE)
Features_Test <- read.table(file.path(path_used, "test", "X_test.txt"), header = FALSE)

Features_Names <- read.table(file.path(path_used, "features.txt"), header = FALSE)


# Merging Data
Subject <- rbind(Subject_Train, Subject_Test)
Activity <- rbind(Activity_Train, Activity_Test)
Features <- rbind(Features_Train, Features_Test)

# Naming the Variables Appropriately
names(Subject) <- c("subject")
names(Activity) <- c("activity")
names(Features) <- Features_Names$V2

#Combining Columns

Intn_Data <- cbind(Subject, Activity)
Data <- cbind(Intn_Data, Features)


#Extracting only the Mean and Standard Deviation for each Measurement

Names_Sub <- Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Names$V2)]
Final_Names <- c(as.character(Names_Sub), "subject" , "activity")

Data <- subset(Data, select = Final_Names)


#Setting Activity Names

Data$activity <-  gsub("1","WALKING",Data$activity )
Data$activity <-  gsub("2","WALKING_UPSTAIRS",Data$activity )
Data$activity <-  gsub("3","WALKING_DOWNSTAIRS",Data$activity )
Data$activity <-  gsub("4","SITTING",Data$activity )
Data$activity <-  gsub("5","STANDING",Data$activity )
Data$activity <-  gsub("6","LAYING",Data$activity )

 
#Labeling Data Set Appropriately

names(Data) <- gsub("BodyBody","Body", names(Data))
names(Data) <- gsub("Acc","Accelerometer", names(Data))
names(Data) <- gsub("Gyro","Gyroscope", names(Data))
names(Data) <- gsub("Mag","Magnitude", names(Data))
names(Data) <- gsub("^t","Time", names(Data))
names(Data) <- gsub("^f","Frequency", names(Data))

#Second Tidy Data Set

New_Data <- aggregate(. ~subject + activity, Data, mean)
New_Data <- New_Data[order(New_Data$subject,New_Data$activity),]
write.table(New_Data, file = "tidy_data.txt", row.names = FALSE)








 




