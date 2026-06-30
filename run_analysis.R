# run_analysis.R

library(dplyr)
library(readr)

# 1. Get the Metadata
# Load the feature and activity names first
col_info <- read.table("features.txt", stringsAsFactors = FALSE)
all_col_names <- col_info$V2
activities <- read.table("activity_labels.txt", col.names = c("act_id", "activity"), stringsAsFactors = FALSE)

# 2. Combine the Train Data
train_y <- read_table("train/y_train.txt", col_names = "act_id")
train_x <- read_table("train/X_train.txt", col_names = all_col_names)
train_sub <- read_table("train/subject_train.txt", col_names = "subject")

# Put them together
full_train <- cbind(train_sub, train_y, train_x)

# 3. Combine the Test Data
test_y <- read_table("test/y_test.txt", col_names = "act_id")
test_x <- read_table("test/X_test.txt", col_names = all_col_names)
test_sub <- read_table("test/subject_test.txt", col_names = "subject")

# Put them together
full_test <- cbind(test_sub, test_y, test_x)

# 4. Merge Train and Test
# Put the test rows under the train rows
combined <- rbind(full_train, full_test)

# 5. Select Out the Mean and Standard Deviation Columns
# Keep subject, act_id, and columns with mean() or std() in the name only
filtered <- combined %>%
  select(subject, act_id, contains("mean"), contains("std"))

# Just a quick check to see if the number of columns is correct; it should be 88
ncol(filtered)

# 6. Add Easy-to-understand labels for Activities
# Get the activity table to have access to names like WALKING
labeled <- filtered %>%
  left_join(activities, by = "act_id") %>%
  select(subject, activity, everything()) %>%
  select(-act_id)

# 7. Clean up Variable Names
# Replace the prefixes with human-readable words
current_names <- names(labeled)

current_names <- gsub("^t", "Time_", current_names)
current_names <- gsub("^f", "Frequency_", current_names)
current_names <- gsub("Acc", "Accelerometer_", current_names)
current_names <- gsub("Gyro", "Gyroscope_", current_names)
current_names <- gsub("Mag", "Magnitude_", current_names)
current_names <- gsub("BodyBody", "Body", current_names)
current_names <- gsub("-mean\\(\\)", "_Mean", current_names)
current_names <- gsub("-std\\(\\)", "_StandardDeviation", current_names)
current_names <- gsub("-", "_", current_names)

names(labeled) <- current_names

# 8. Generate the second tidy dataset
# Group by subject and activity, then calculate the mean for every entry
final <- labeled %>% group_by(subject, activity) %>% summarize(across(everything(), mean, na.rm = TRUE), .groups = "drop")

# 9. Save the final dataset
# Write it to a text file without row names as requested
write.table(final, "sec_tidy_dataset.txt", row.name = FALSE)

# Project is finished!
print("The dataset is created!")
