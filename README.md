# tidy_dataset readme file

1. Load features, activity, subject's test and train datasets into tables.
2. Combine both test and train datasets for features, activity and subject, into their respective tables.
3. Read feature table's column names from features.txt into featureNames table.
4. Filter on mean and std columns from featureNames table, and then, fetch only those columns from 'features' table.
5. Combine features, subject and activity into single table final_data.
6. Read activity_lables.
7. Join acitivity_lables and final_data tables on acitivityID
8. Rename column names to more readable format
9. Aggregate the mean of each variable for each avtivity and each subject.
10. Write to tidy_dataset.txt file.
