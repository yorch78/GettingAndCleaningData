# Coursera - Getting and Cleaning Data - Project

This course project corresponds to the Getting and Cleaning Data Coursera course project.

In this link you can find the instructions for the project: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

The main script of this project is the R script 'run_analysis.R'. It contains the following steps:

1. Download the dataset from the internet if not exists in the working directory.
2. Load the activity and feature catalogue.
3. Load datasets: training and test, just filtering to keep only columns containing mean or standard deviation data.
4. Loads the activity and subject data for each dataset. All columns are merged with their dataset.
5. Merge the two datasets binding their rows.
6. Create factors from the 'activity' and 'subject' columns.
7. Create a tidy dataset summarizing the average (mean) value of each variable for each subject and activity pair.

The execution of this script produces as a result the file 'tidy.txt'.