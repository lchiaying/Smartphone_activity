# Data Cleaning of Samsung Smartphones Dataset

This repository contains code for cleaning the Samsung smartphone dataset, to producing a final tidy data set containng the average measurements for each subject and each activity.

The original dataset was downloaded from the UCI Machine Learning repository website, [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), and unzipped into the folder `data/`.

The file `run_analysis.R` contains the code to prepare the tidy dataset, doing the following, as required in the project description.

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names.
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The final tidy dataset is stored in the file `tidyData.txt`, in space-delimited format. It contains data for the average of each variable for each activity and each subject, thus it has 180 rows (30 subjects and 6 unique activities). The accompanying codebook `tidyData_info.txt` explains the features in the dataset.