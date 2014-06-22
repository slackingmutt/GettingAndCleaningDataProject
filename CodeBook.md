GettingAndCleaningDataProject
=============================

This code book describes the data transformations used to construct a tidy data file for the
Coursera Getting and Cleaning Data project.

The following files were provided for this project.
- features_info.txt: contains a discussion of the variables whose values were collected.
- features.txt: the names of the variables whose values were collected.
_ subject_test.txt: the subjects whose data were selected to be in the test set.
- X_test.txt: the values of the variables in the test set.
- y_test.txt: the activities corresponding to the variables in the test set.
- subject_train.txt: the subjects whose variables were selected to be in the training set.
- X_train.txt: the values of the variables in the training set.
- y_train.txt: the activities corresponding to the variables in the test set.

Investigation indicated that the data was clean, i.e. with no  NAs not any  outliers.

The training, activity, and subject  data were read into the data frames train.data, train.activity,
and train.submects. Likewise, the corresponding test data were read into the data frames
test.data, test.activity, and test.subjects.

The features were read into a data frame using the 'stringsAsFactors=FALSE' parameter in order
to avoid factors.

The following tests indicated the absence of NAs.
> sum(is.na(train.data))
[1] 0
> sum(is.na(test.data))
[1] 0
> sum(is.na(train.activity))
[1] 0
> sum(is.na(test.activity))
[1] 0
> sum(is.na(train.subjects))
[1] 0
> sum(is.na(test.subjects))
[1] 0
> sum(is.na(features))
[1] 0

The training data was loaded into the data frame project.data. The following loop was run on the data
to look for outliers. All values were between -1 and 1 as expected.

datamax <- 0
datamin <- 0
datamaxvec <- c()
dataminvec <- c()
for(ndx in 1:ncol(project.data)){
        val <- max(project.data[,ndx])
        datamaxvec <- c(datamaxvec,val)
        dataminvec <- c(dataminvec,val)
        if( datamax < val) {
                datamax <- val
         } else if (val < datamin) {
                 datamin <- val
         }
}

The subjects data was loaded into the project.subjects data frame. The range of values were tested by

> range(project.subjects)
[1]  1 30

which produced the expected results.

The provided data was loaded in a straight forward way into a projects.data data frame where the
columns were labelled appropriately using a combination of rbind and cbind. Columns containing
the requested means and standard deviations were selected through pattern matching and subset selection.

The activities were transfromed from the numerical coding
into strings using vectorization as described in this r-bloggers article
http://www.r-bloggers.com/vectorisation-is-your-best-friend-replacing-many-elements-in-a-character-vector/ .

The data frame containing the required means was computed using data table techniques as described
in the following stackoverflow article
http://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table .