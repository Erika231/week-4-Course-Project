# Loading libraries
library(dplyr) 
library(plyr)

##First I downloaded the zip file, then I unziped it in a folder I created for the course 

# Then I read the train and test datasets 
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# As a third step I read the feature vector and the activity labels
features <- read.table("./data/UCI HAR Dataset/features.txt")
activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")

#For simplicity I assign some variables names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")

############1.
#I merge the datasets using the cbind and rbind command and create new variables 
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
merged.data<- rbind(train, test)

############2.
colNames <- colnames(merged.data)


meanstddev <- (grepl("activityID", colNames) |
                   grepl("subjectID", colNames) |
                   grepl("mean..", colNames) |
                   grepl("std...", colNames)
)


Mmeanatdvdesv <- merged.data[ , meanstddev == TRUE]
Mmeanatdvdesv

############3.
activnames <- merge(Mmeanatdvdesv, activityLabels,
                              by = "activityID",
                              all.x = TRUE)
setWithActivityNames

############4.
# Already done this in previous steps 
############5.
##Finally I tide the dataset and get a tidy dataset
Finaldata <- aggregate(. ~subjectID + activityID, activnames, mean)
Finaldata <- Finaldata[order(Finaldata$subjectID, Finaldata$activityID), ]

write.table(Finaldata, "tidytdataset.txt", row.names = FALSE)


