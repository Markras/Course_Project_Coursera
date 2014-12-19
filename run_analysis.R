# 1. Merging
# The first step is to read all the files we are interested in into RAM.

features <- read.table(".\\UCI HAR Dataset\\features.txt", header=F)

X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", header=F)
y_train <- read.table(".\UCI HAR Dataset\\train\\Y_train.txt", header=F)
subject1 <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header=F)

x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", header=F)
y_test <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", header=F)
subject2 <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header=F)

Labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", header=F)

#The second step is to properly name activities from y_train and y_test. So instead of having 1,2,3... we get Laying, Sitting, Standing...
#we achieve this by iterating through the y files and renaming their variables using the labels.txt 
iter <- 1
while(iter <= nrow(y_test)){
  y_test[iter,1] = as.character(Labels[y_test[iter,1],2])
  iter <- iter +1
}
iter <- 1
while(iter <= nrow(y_train)){
  y_train[iter,1] = as.character(Labels[y_train[iter,1],2])
  iter <- iter +1
}

#The next step consists in properly naming columns using the names included in features.txt and adding two suppementary names for the Subject.ID
#and for the Activities. After properly naming datasets we merge them with Subject and Activity (y) columns.
colnames(X_train) = features[,2] #renaming...
colnames(y_train) = c("Activity")
mergedData1 <- cbind(y1,X_train) #binding measurements and activities
colnames(subject1) <- "Subject.ID"
mergedData1 <- cbind(subject1, mergedData1) #binding measurements and subject ids


colnames(x_test) = features[,2]
colnames(y_test) = c("Activity")
mergedData2 <- cbind(y_test,x_test)
colnames(subject2) <- "Subject.ID"
mergedData2 <- cbind(subject2,mergedData2)

#Finally we merge the test and train datasets.
mergedData <- rbind(mergedData1, mergedData2)
# We obtain a properly named full dataset including train and test datasets. 


# 2. Extracting
#Having a fully constructed dataset, we can iterate over it and find columns we want to extract.
#In our case we are interested in extracting columns with 'mean()' and 'std()' in their names

goodcol <- c(1,2) #a variable indicating that first two columns: Subject.ID and Activity are OK. We later append it with columns we want to get
iter <- 1
while(iter < length(mergedData)) {
  if(grepl("mean()", colnames(mergedData)[iter])) {
    goodcol <- c(goodcol, iter)
  }
  else if(grepl("std()", colnames(mergedData)[iter])) {
    goodcol <- c(goodcol, iter)
  }
  iter <- iter +1 
}

newset <- mergedData[,goodcol] #the new set with data we are interested in. 

#3. Getting an average
#In this final part we get the mean of the columns per subject per activity. 
Final_set <- aggregate(newset[,3:length(newset)],list(newset$Activity,newset$Subject.ID),mean) #we agregate from the third column onwards. The first two would have given us meaningless results
Final_set <- Final_set[,c(2,1,3:ncol(Final_set))] #a reordering to put Subject.ID in the beginning
colnames(Final_set)[1:2] <- c("Subject.ID","Activity")
write.table(Final_set, "DataSetMeans.txt", sep="\t", row.name=FALSE) # saving the new file.
