GettingAndCleaningDataProject
=============================

Repo created for the Coursera Getting and Cleaning Data Project

The data for the project is contained in seven separate files. The files contain the measurements
collected in the study, the activity that was measured, the subject that generated the measurements,
and a list of what was measured. The measurements, the activities, and the subjects were divided
into a training set and a testing set which constitued six of the seven files. The seventh file
contained the names of the variables measured.

The script, run_analysis.R, first reads the training and testing sets into separate data frames,
and then combines the training and testing data into single data frames. The resulting data
frames have the variables - the data from the movements, the activities, or the subject - as
columns and the observations as rows. The number of rows in these data frames are all equal.
The resulting data frames are project.data containing the measurements, project.activity
containing the activities measured, and project.subjects indicating which subject produced
which measurement.

The file that contains the names of the variables that were measured - called features in  the
script - is then read into a data frame. Note that the names are read as strings.These variables
are then used to name the columns of the
data frame projects.data.

The activities in project.activity are named 'Activities'. The numerical encoding of the activities
in the project.activity is then replaced by strings describing the activity. The technique used
is described in this article from r-bloggers -
http://www.r-bloggers.com/vectorisation-is-your-best-friend-replacing-many-elements-in-a-character-vector/ .
Next, project.activity is added as the first column to project.data.

The project.subjects data is named 'Subjects', and this is added as the first column to project.data.

Those features which measure the mean and standard deviation are then identified and project.data
is subsetted with that data. This data frame is also named project.data.

At this point, all of the data is in the data frame project.data and the columns have been
named appropriately. What remains is to compute the means of the observations per subject and
activity. It is easier to do this using data table functionality, so project.data is cast to
a project.table. This technique is described in the stackoverflow note -
http://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table .
The resulting data table is named project.mean.

Finally by setting 'Subject' as a key on project.mean, the data table is sorted by 'Subject'.

This results in a tidy data table. Each variable forms a column, and each observation forms a row.


