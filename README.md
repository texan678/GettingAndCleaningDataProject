**Coursera Data Science - Getting and Cleaning Data - Course Project**

run_analysis.R

Purpose: Performs extract, transform and load (ETL) tasks on data sourced from University of California, Irvine study that logged data on human motion using sensors in common smart phones. Specifically, the R script merges train and test data provided by the study, and then filters the measured values to a subset only including mean and standard deviation calculations. Additionally, the ETL script creates a second summary dataset providing the averages of all measures in the merged data set, broken down by study participant and the type of motion performed.

Algorithm: Each row in the overall data provided by the study consists of columns from several different files. Below is a list by IDs (columns that uniquely identify row) and measures (columns resulting from calculations).

IDs: 
subject_train.txt, 
subject_test.txt, 
y_train.txt, 
y_test.txt

Measures: 
x_train.txt, 
x_test.txt

In addition, two files provide descriptions of the measures and the type of motion activities performed.

features.txt, 
activity_labels.txt

Each of the "train" files for ID and measure columns contain the same number of rows. The script loads each "train" file into its own data frame in R and assigns a column name. For the measures, the names from features.txt are assign to the corresponding columns. The 3 data frames are then combined into a single data frame for train data. 

The script then repeats the same process for the "test" files, creating a separate combined data frame for test data. Rows from the train and test data frames are then combined into a consolidated dataset with all records from the study. 

The measureNames data frame is then subset to create a vector with only those measures including a mean or standard deviation. The vector of names is used to subset the consolidated data frame. The plyr library is used to join the consolidated data frame with the activity descriptions. The columns are reordered, putting the IDs first and then the measures.

The second, summary dataset is produced by creating a data table from the data frame resulting from the above process. lapply is used to summarize each unique combination of ID's with the mean of the measure columns. Both data sets can then be writen to files as needed. 
