
#README
-----------
run_analysis.R
ver. 1.0

Since the difference between codebook and readme is not clear to me, I analyze in readme the whole process of getting and cleaning data.

My script has 3 parts. 

1.The first one - Merging, concerns the first part of our task and is divided into few smaller steps:

1.1 First, we read all the provided data (x_train, x_test, subject_train, subject_test, y_train, y_test, features, activity_labels).

1.2 The second step is to properly name activities from y_train and y_test. So instead of having 1,2,3... we get Laying, Sitting, Standing... we achieve this by iterating through the y files and renaming their variables using the labels.txt. We have to use the function 'as.character' to get correct results.
Since I find it clearer, I do it on two initial files (y's). But we could actually rename this later with a single loop. 

1.2 The second step is to properly name activities from y_train and y_test. So instead of having 1,2,3... we get Laying, Sitting, Standing... we achieve this by iterating through the y files and renaming their variables using the labels.txt. We have to use the function 'as.character' to get correct results. Since I find it clearer, I do it on two initial files (y's). But we could actually rename this later with a single loop. 

1.3 The next step consists in properly naming columns using the names included in features.txt and adding two suppementary names for the Subject.ID and for the Activities. After properly naming datasets we merge them with Subject and Activity (y) columns. For merging datasets I used the simplest cbind and rbind. 

We get the "mergedData" variable with the full tidy data set

2.The second part is connected with our second task: creating a new file with tidy data including means of different columns.

Having a fully constructed dataset, we can iterate over it and find columns we want to extract. In our case we are interested in extracting columns with 'mean()' and 'std()' in their names. I am doing it with a While loop checking if any of these words appears in the columns' names. The function grepl() is crucial. I add columns to a vector I will use later to extract them from the original dataset. I end up with a variable newset that subsets the dataset created in the paragraph 1 with a vector with columns' numbers. 

3.The final part is about creating a new shorter dataset with avarages of different columns. In this final part we get the mean of the columns per subject per activity. I use the function aggregate() which does everything for us:) The only thing to remember is that we have to omit the first two columns with Subject.ID and Activity since we do not want to get their means. 

A few cosmetic changes and that is all. The new dataset is ready. 
