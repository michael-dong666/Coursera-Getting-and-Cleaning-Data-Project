# Code book -- UCI HAR Data Summary
This code book is about the variables, data, and transformations used to create the final tidy dataset.

## Identifiers
* `Subject_ID`: The ID of the test subject, ranging from 1 to 30.
* `Activity_Name`: The type of activity performed when the measurements were taken.
  * Values: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.
  
## Transformations and Cleaning Steps
1. **Merged** the training and test datasets to create one single dataset. 
2. **Extracted** only the measurements on the mean and standard deviation (`std()`) for each measurement.
3. **Applied descriptive activity name** from `activity_labels.txt` to replace numeric activity IDs.
4. **Relabeled columns** with descriptive names (e.g. Replacing prefixes `t` with `Time_`).
5. **Summarized** the data by taking the average of each variable for each activity and each subject.

## Measurements(Signal Averages)
All measurement variables are unitless ratios. Each value represents the **average** calculation for that subject and activity.
* `Time_BodyAccelerometer_Mean_X / Y / Z`
* `Time_BodyAccelerometer_StandardDeviation_X / Y / Z`
* `Time_GravityAccelerometer_Mean_X / Y / Z`
* `Time_GravityAccelerometer_StandardDeviation_X / Y / Z`
* `Time_BodyAccelerometerJerk_Mean_X / Y / Z`
* `Time_BodyAccelerometerJerk_StandardDeviation_X / Y / Z`
* `Time_BodyGyroscope_Mean_X / Y / Z`
* `Time_BodyGyroscope_StandardDeviation_X / Y / Z`
* `Frequency_BodyAccelerometer_Mean_X / Y / Z`
* `Frequency_BodyAccelerometer_StandardDeviation_X / Y / Z`