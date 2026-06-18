# Coursera-Getting-and-Cleaning-Data-Project
This is a repo for my Coursera Getting and Cleaning Data Project. The data are collected from the accelerometers from the Samsung Galaxy S smartphone. The result yielded is the average value of each variable for each activity listed.
## Files in this repo
*`run_analysis.R`: The R script used to load, merge, clean, and summarize the data.
*`CodeBook.md`: A document that describes the variables, the data, and the transformations performed to clean up the data.
*`sec_tidy_dataset.txt`: The final tidy dataset.

## How to run the analysis
1. Download the data source zip folder and unzip it on your local computer.
2. Place the `run_analysis.R` script inside the main unzipped folder (`UCI HAR Dataset`).
3. Open RStudio and set your working directory to that folder.
4. Run the `run_analysis.R` script using `source("run_analysis.R")`.
5. A new file named `sec_tidy_dataset.txt` will automatically generate in your folder.