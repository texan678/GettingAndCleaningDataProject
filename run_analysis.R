library(plyr)
library(data.table)
#setwd("c:/Users/v-smmark/Documents/R/class/Coursera Data Scientist/Getting and Cleaning Data/project")

if (!file.exists("./class/Coursera Data Scientist/Getting and Cleaning Data/project/etl")) {
  dir.create("etl")
}

measureNames <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

trainSubjectId <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainActivityId <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainMeasureValues <- read.table("./UCI HAR Dataset/train/x_train.txt")

colnames(trainSubjectId) <- c("Subject ID")
colnames(trainActivityId) <- c("Activity ID")
colnames(trainMeasureValues) <- measureNames[,2]

testSubjectId <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivityId <- read.table("./UCI HAR Dataset/test/y_test.txt")
testMeasureValues <- read.table("./UCI HAR Dataset/test/x_test.txt")
colnames(testMeasureValues) <- measureNames[,2]

colnames(testSubjectId) <- c("Subject ID")
colnames(testActivityId) <- c("Activity ID")
colnames(testMeasureValues) <- measureNames[,2]

trainData <- cbind(trainSubjectId, trainActivityId, trainMeasureValues)
testData <- cbind(testSubjectId, testActivityId, testMeasureValues)

allData <- rbind(trainData, testData)

meanMeasureNames <- measureNames[grep("mean()", measureNames[,2], fixed=TRUE),2]
stdMeasureNames <- measureNames[grep("std()", measureNames[,2], fixed=TRUE),2]

filteredMeasureNames <- c(meanMeasureNames, stdMeasureNames)

allDataFiltered <- allData[,c("Subject ID", "Activity ID", filteredMeasureNames)]

activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
colnames(activityNames) <-c("Activity ID", "Activity Name")

allDataFiltered <- join(allDataFiltered, activityNames)
finalDataSet1 <-allDataFiltered[,c(1,2,69,3:68)]
finalDataSet1[1:3, c(1,2,3,4,69)]

allDataTable <- as.data.table(finalDataSet1)
finalDataSet2 <-allDataTable[, lapply(.SD, mean), by = c("Subject ID", "Activity ID", "Activity Name"),
                             .SDcols = 4:69]

#write.table(finalDataSet1, file="ds1.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
write.table(finalDataSet2, file="ds2.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)

