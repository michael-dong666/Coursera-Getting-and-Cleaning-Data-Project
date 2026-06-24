> # run_analysis.R
> 
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> library(readr)
> 
> # 1. Get the Metadata
> # Load the feature and activity names first
> col_info <- read_table("features.txt", col_names = FALSE)
Parsed with column specification:
cols(
  X1 = col_character()
)
> all_col_names <- as.character(col_info$X2)
Warning message:
Unknown or uninitialised column: `X2`. 
> activities <- read_table("activity_labels.txt", col_names = c("act_id", "activity"))
Parsed with column specification:
cols(
  act_id = col_double(),
  activity = col_character()
)
> 
> # 2. Combine the Train Data
> print("Reading training folder...")
[1] "Reading training folder..."
> 
> train_y <- read_table("train/y_train.txt", col_names = "act_id")
Parsed with column specification:
cols(
  act_id = col_double()
)
> train_x <- read_table("train/X_train.txt", col_names = all_col_names)
Parsed with column specification:
cols()
> train_sub <- read_table("train/subject_train.txt", col_names = "subject")
Parsed with column specification:
cols(
  subject = col_double()
)
> 
> # Put them together
> full_train <- cbind(train_subjects, tr)
Error in cbind(train_subjects, tr) : object 'train_subjects' not found
> full_train <- cbind(train_sub, train_y, train_x)
> 
> # 3. Combine the Test Data
> print("Reading test folder...")
[1] "Reading test folder..."
> 
> test_y <- read_table("test/y_test.txt", col_names = "act_id")
Parsed with column specification:
cols(
  act_id = col_double()
)
> test_x <- read_table("test/X_test.txt", col_names = all_col_names)
Parsed with column specification:
cols()
> test_sub <- read_table("test/subject_test.txt", col_names = "subject")
Parsed with column specification:
cols(
  subject = col_double()
)
> 
> # Put them together
> full_test <- cbind(test_sub, test_y, test_x)
> 
> # 4. Merge Train and Test
> # Put the test rows under the train rows
> combined <- rbind(full_train, full_test)
> 
> # 5. Select Out the Mean and Standard Deviation Columns
> # Keep subject, act_id, and columns with mean() or std() in the name only
> filtered <- combined %>% select(subject, act_id, contains("mean()"), contains("std()"))
> 
> # 6. Add Easy-to-understand labels for Activities
> # Get the activity table to have access to names like WALKING
> labeled <- filtered %>% left_join(activities, by = "act_id") %>% select(subject, activity, everything(), -act_id)
> 
> # 7. Clean up Variable Names
> # Replace the prefixes with human-readable words
> current_names <- names(labeled)
> 
> current_names <- gsub("^t", "Time_", current_names)
> current_names <- gsub("^f", "Frequency_", current_names)
> current_names <- gsub("Acc", "Accelerometer_", current_names)
> current_names <- gsub("Gyro", "Gyroscope_", current_names)
> current_names <- gsub("Mag", "Magnitude_", current_names)
> current_names <- gsub("BodyBody", "Body", current_names)
> current_names <- gsub("-mean\\(\\)", "_Mean", current_names)
> current_names <- gsub("-std\\(\\)", "_StandardDeviation", current_names)
> current_names <- gsub("-", "_", current_names)
> 
> names(labeled) <- current_names
> 
> # 8. Generate the second tidy dataset
> # Group by subject and activity, then calculate the mean for every entry
> final <- labeled %>% group_by(subject, activity) %>% summarize(across(everything(), mean, na.rm = TRUE), .groups = "drop")
> 
> # 9. Save the final dataset
> # Write it to a text file without row names as requested
> write.table(final, "sec_tidy_dataset.txt", row.name = FALSE)
> print("The dataset is created!")
[1] "The dataset is created!"
