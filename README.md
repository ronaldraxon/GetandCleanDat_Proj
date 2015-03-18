# Readme.md (run_analysis.R)															


The "run_analysis.R" script can be used for extracting raw data 
from different files in the wearable computing project, collected 
from the accelerometers of the Samsung Galaxy S smartphone.
this function has only one parameter an it is the path where the
UCI HAR Dataset directory is located.
For further information about how this program works and meta data, please 
check the codebook.txt entry located 
at https://github.com/ronaldraxon/GetandCleanDat_Proj.

Please follow the instructions below to run the program: 

1) Please get the file from the github repo 
   at https://github.com/ronaldraxon/GetandCleanDat_Proj

2) In order to execute the program, you have to load it 
   with the "source" function in a r console.

	source("yourfilelocationhere.../run_analysis.R")

3) And then just run it!

Example:

	> tdata <- run_analysis()
	Executing! please wait...
	Creating secondary tidy data set on C:/.../Documents/tidymeanset.txt
	Process succesfully finished!
	>head(tdata)
  	Subject_num Activity_desc tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tGravityAccmeanX
	1           1       WALKING     0.2885845   -0.02029417    -0.1329051        0.9633961
	2           1       WALKING     0.2784188   -0.01641057    -0.1235202        0.9665611
	3           1       WALKING     0.2796531   -0.01946716    -0.1134617        0.9668781
	4           1       WALKING     0.2791739   -0.02620065    -0.1232826        0.9676152
	5           1       WALKING     0.2766288   -0.01656965    -0.1153619        0.9682244
	6           1       WALKING     0.2771988   -0.01009785    -0.1051373        0.9679482

This script returns the whole tidy data set, but according the project's conditions, I've added 
a couple lines that creates a second independent tidy data set with the average of each variable 
for each activity and each subject with write.table() function. The file will be written on the 
specified directory as parameter or in the working directory by default.

Notes:

It's probable that once you attempt to run the program you get an error like this:

 	Error in withCallingHandlers(expr, message = function(c) invokeRestart("muffleMessage")) : 
  	could not find function "join"
 
The "join" function is included in the packages dplyr and plyr. Nevertheless even if you include the library
dplyr you probably still get the previous error. In addition if you attempt to include both libraries you 
can  get this message: 

	You have loaded plyr after dplyr - this is likely to cause problems.
	If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
	library(plyr); library(dplyr)

For that reason, I´ve included the respective lines to call (and discard plyr as necessary) these libraries, 
but you have to make sure these packages are available in your machine.



