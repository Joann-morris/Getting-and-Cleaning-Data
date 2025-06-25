# CodeBook

## Overview
This CodeBook describes the data processing steps and the variables in the `tidy_dataset.txt` file.

## Source Data
The dataset is derived from the "Human Activity Recognition Using Smartphones" dataset.

## Data Processing Steps
1. Merged the training and test sets.
2. Extracted only measurements on mean and standard deviation.
3. Replaced activity codes with descriptive names.
4. Labeled the dataset with descriptive variable names.
5. Created a tidy dataset with averages.

## Variables
- `subject`: The ID of the subject who performed the activity.
- `activity`: The activity performed (e.g., Walking, Sitting).
- Remaining columns are the mean values of various measurements.

## Summary
The final dataset contains the average of each measurement grouped by subject and activity.
