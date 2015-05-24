

<br>The Project is to get data from the following file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, 
<br>clean them and make a tidy data.frame with the average of each measurement, for each subject and each activity. 
<br>
<br>The activities are the following:
<br>  activity.id activity.description
<br>           1              WALKING
<br>           2     WALKING_UPSTAIRS
<br>           3   WALKING_DOWNSTAIRS
<br>           4              SITTING
<br>           5             STANDING
<br>           6               LAYING
<br>
<br>The subjects are numbered from 1 to 30.
<br><br>
<br>The script downloads and unzips the files, and then executes a series of procedures for binding the training and testing data, and selecting only the necessary measurements for the tidy data file. The script file, run_analysis.R, contains detailed information about what is done in each step of the program. 

<br>The output of the script is a txt file, with the calculated average of every std and mean variables, for each subject id and activity. 
<br>These are the variables in the tidy.data.txt file:
<br>
            <table>
<tr><td>tBodyAcc.mean...X</tr></td>
<tr><td>tBodyAcc.mean...Y</tr></td>
<tr><td>tBodyAcc.mean...Z</tr></td>
<tr><td>tGravityAcc.mean...X</tr></td>
<tr><td>tGravityAcc.mean...Y</tr></td>
<tr><td>tGravityAcc.mean...Z</tr></td>
<tr><td>tBodyAccJerk.mean...X</tr></td>
<tr><td>tBodyAccJerk.mean...Y</tr></td>
<tr><td>tBodyAccJerk.mean...Z</tr></td>
<tr><td>tBodyGyro.mean...X</tr></td>
<tr><td>tBodyGyro.mean...Y</tr></td>
<tr><td>tBodyGyro.mean...Z</tr></td>
<tr><td>tBodyGyroJerk.mean...X</tr></td>
<tr><td>tBodyGyroJerk.mean...Y</tr></td>
<tr><td>tBodyGyroJerk.mean...Z</tr></td>
<tr><td>tBodyAccMag.mean..</tr></td>
<tr><td>tGravityAccMag.mean..</tr></td>
<tr><td>tBodyAccJerkMag.mean..</tr></td>
<tr><td>tBodyGyroMag.mean..</tr></td>
<tr><td>tBodyGyroJerkMag.mean..</tr></td>
<tr><td>fBodyAcc.mean...X</tr></td>
<tr><td>fBodyAcc.mean...Y</tr></td>
<tr><td>fBodyAcc.mean...Z</tr></td>
<tr><td>fBodyAcc.meanFreq...X</tr></td>
<tr><td>fBodyAcc.meanFreq...Y</tr></td>
<tr><td>fBodyAcc.meanFreq...Z</tr></td>
<tr><td>fBodyAccJerk.mean...X</tr></td>
<tr><td>fBodyAccJerk.mean...Y</tr></td>
<tr><td>fBodyAccJerk.mean...Z</tr></td>
<tr><td>fBodyAccJerk.meanFreq...X</tr></td>
<tr><td>fBodyAccJerk.meanFreq...Y</tr></td>
<tr><td>fBodyAccJerk.meanFreq...Z</tr></td>
<tr><td>fBodyGyro.mean...X</tr></td>
<tr><td>fBodyGyro.mean...Y</tr></td>
<tr><td>fBodyGyro.mean...Z</tr></td>
<tr><td>fBodyGyro.meanFreq...X</tr></td>
<tr><td>fBodyGyro.meanFreq...Y</tr></td>
<tr><td>fBodyGyro.meanFreq...Z</tr></td>
<tr><td>fBodyAccMag.mean..</tr></td>
<tr><td>fBodyAccMag.meanFreq..</tr></td>
<tr><td>fBodyBodyAccJerkMag.mean..</tr></td>
<tr><td>fBodyBodyAccJerkMag.meanFreq..</tr></td>
<tr><td>fBodyBodyGyroMag.mean..</tr></td>
<tr><td>fBodyBodyGyroMag.meanFreq..</tr></td>
<tr><td>fBodyBodyGyroJerkMag.mean..</tr></td>
<tr><td>fBodyBodyGyroJerkMag.meanFreq..</tr></td>
<tr><td>angle.tBodyAccMean.gravity.</tr></td>
<tr><td>angle.tBodyAccJerkMean..gravityMean.</tr></td>
<tr><td>angle.tBodyGyroMean.gravityMean.</tr></td>
<tr><td>angle.tBodyGyroJerkMean.gravityMean.</tr></td>
<tr><td>angle.X.gravityMean.</tr></td>
<tr><td>angle.Y.gravityMean.</tr></td>
<tr><td>angle.Z.gravityMean.</tr></td>
<tr><td>tBodyAcc.Standard...X</tr></td>
<tr><td>tBodyAcc.Standard...Y</tr></td>
<tr><td>tBodyAcc.Standard...Z</tr></td>
<tr><td>tGravityAcc.Standard...X</tr></td>
<tr><td>tGravityAcc.Standard...Y</tr></td>
<tr><td>tGravityAcc.Standard...Z</tr></td>
<tr><td>tBodyAccJerk.Standard...X</tr></td>
<tr><td>tBodyAccJerk.Standard...Y</tr></td>
<tr><td>tBodyAccJerk.Standard...Z</tr></td>
<tr><td>tBodyGyro.Standard...X</tr></td>
<tr><td>tBodyGyro.Standard...Y</tr></td>
<tr><td>tBodyGyro.Standard...Z</tr></td>
<tr><td>tBodyGyroJerk.Standard...X</tr></td>
<tr><td>tBodyGyroJerk.Standard...Y</tr></td>
<tr><td>tBodyGyroJerk.Standard...Z</tr></td>
<tr><td>tBodyAccMag.Standard..</tr></td>
<tr><td>tGravityAccMag.Standard..</tr></td>
<tr><td>tBodyAccJerkMag.Standard..</tr></td>
<tr><td>tBodyGyroMag.Standard..</tr></td>
<tr><td>tBodyGyroJerkMag.Standard..</tr></td>
<tr><td>fBodyAcc.Standard...X</tr></td>
<tr><td>fBodyAcc.Standard...Y</tr></td>
<tr><td>fBodyAcc.Standard...Z</tr></td>
<tr><td>fBodyAccJerk.Standard...X</tr></td>
<tr><td>fBodyAccJerk.Standard...Y</tr></td>
<tr><td>fBodyAccJerk.Standard...Z</tr></td>
<tr><td>fBodyGyro.Standard...X</tr></td>
<tr><td>fBodyGyro.Standard...Y</tr></td>
<tr><td>fBodyGyro.Standard...Z</tr></td>
<tr><td>fBodyAccMag.Standard..</tr></td>
<tr><td>fBodyBodyAccJerkMag.Standar</tr></td>d..
<tr><td>fBodyBodyGyroMag.Standard..</tr></td>
<tr><td>fBodyBodyGyroJerkMag.Standard..</tr></td>
<tr><td>activity.id</tr></td>
<tr><td>subject.id</tr></td>
<tr><td>activity.description</tr></td>
</table>

Hope it works!

Bernardo Gomes

