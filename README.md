# Getting-and-Cleaning-Data

The following are the instructions to run the code (run_analysis.R) for the Getting and cleaning data project. 

1. Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Open R (R-Studio) and set the dir to where the data (in step 1) was saved. Example: C:\Users\Me\Desktop\Getting-and-Cleaning-Data\UCI HAR Dataset

3. Set the source to the 'run_analysis.R' 

4. Set up to use data via read.table("tidy_result_Q5.txt"). This is the result table (dim of 180 * 68) that shows average of each variable for each of the activities for each of the subject. There are 6 activities with 30 subjects all together. 
