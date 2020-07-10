

#CodeBook

  
##Introduction.


###Steps.
1) The zip file is unzip

2) The data is taken from the folder "UCI HAR Dataset".
Inside that folder, we read the files:'activity_labels' and 'features'.
We also go deeper inside that folder, and read the data: 'X_test' and 'y_test'. Which is inside the test folder
We also go into the train folder, and read the data: 'X_train' and 'y_train'

3) After reading the above mentioned files, we process to rename the columns of the X_train file with the information from the features file