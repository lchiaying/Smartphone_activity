## STEP 1 #### 
# Merges the training and the test sets to create one data set.
Xtrain <- read.table("data/train/X_train.txt", header=F)
ytrain <- read.table("data/train/y_train.txt", header=F)
strain <- read.table("data/train/subject_train.txt", header=F)

Xtest <- read.table("data/test/X_test.txt", header=F)
ytest <- read.table("data/test/y_test.txt", header=F)
stest <- read.table("data/test/subject_test.txt", header=F)

features <- read.table("data/features.txt", header=F, as.is=T)

data <- rbind(cbind(Xtrain, ytrain, strain),
              cbind(Xtest, ytest, stest))
names(data) <- c(features[, 2], "label", "subject")


## STEP 2 ####
# Extracts only the measurements on the mean and standard deviation for each   
# measurement.
data <- data[, c(grep("(mean|std)\\(\\)", names(data), value=T), 
                 "label", "subject")]



## STEP 3 ####
# Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("data/activity_labels.txt", 
                              header=F, col.names=c("label", "activity"))
data$activity <- activity_labels$activity[data$label]


## STEP 4 ####
# Appropriately labels the data set with descriptive variable names.
library(data.table)
value.mapping <- 
  data.table(short = c("Mag", "X", "Y", "Z"),
             long = c("Magnitude", "X-direction", "Y-direction", "Z-direction"),
             key = "short")
signal.mapping <- 
  data.table(short = c("Body", "Gravity", "Acc", "Gyro", "Jerk"),
             long = c("Body", "Gravity", "Acceleration", "Gyroscope", "Jerk"),
             key = "short")

makeDescriptiveName <- function(s) {
  stat <- ifelse("mean()" %in% s, "mean", "standardDeviation")
  domain <- ifelse("t" %in% s, "inTimeDomain", "inFrequencyDomain")
  value <- value.mapping[.(s[s %in% value.mapping$short]), long]
  signal <- signal.mapping[.(s[s %in% signal.mapping$short]), long]
  
  paste(c(stat, paste(signal, collapse=""), value, domain), collapse=".")
}

oldVarNames <- names(data)[1:(ncol(data)-3)]
newVarNames <- sapply(strsplit(gsub("([A-Z][a-z])", "-\\1", oldVarNames), "-"),
                      makeDescriptiveName)

names(data)[1:(ncol(data)-3)] <- newVarNames


## STEP 5 ####
# From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
tidyData <- as.data.table(data)[, lapply(.SD, mean), 
                                by=.(subject, activity, label)]

write.table(tidyData, file="tidyData.txt", row.names=F)
