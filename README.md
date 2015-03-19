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
	Creating secondary tidy data set in C:/Users/RRODRIGUEZ.PROYCOMP/Documents/tidymeanset.txt
	Process succesfully finished!
	> head(tdata)
  	Subject_num Activity_desc tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tGravityAccmeanX tGravityAccmeanY
	1           1       WALKING     0.2885845   -0.02029417    -0.1329051        0.9633961       -0.1408397
	2           1       WALKING     0.2784188   -0.01641057    -0.1235202        0.9665611       -0.1415513
	3           1       WALKING     0.2796531   -0.01946716    -0.1134617        0.9668781       -0.1420098
	4           1       WALKING     0.2791739   -0.02620065    -0.1232826        0.9676152       -0.1439765
	5           1       WALKING     0.2766288   -0.01656965    -0.1153619        0.9682244       -0.1487502
	6           1       WALKING     0.2771988   -0.01009785    -0.1051373        0.9679482       -0.1482100

This script returns the whole tidy data set, but according the project's conditions, I've added 
a couple lines that creates a second independent tidy data set with the average of each variable 
for each activity and each subject with write.table() function. The file will be written on the 
specified directory as parameter or in the working directory by default. An example of the output 
data using the "run_analysis" script will be as follows:

	Activity_desc	Subject_num	         tBodyAccmeanX		tBodyAccmeanY		tBodyAccmeanZ	
	LAYING	20	0.268210689679487	-0.0154394352991026	-0.103432062417949	0.590974958467949
	LAYING	24	0.276767046391076	-0.0176822460103885	-0.107914503687664	0.69498126808399
	LAYING	27	0.277798919328859	-0.0169386590334393	-0.112273368370134	0.585139591107383
	LAYING	28	0.277532554764398	-0.0191721442063089	-0.109710873104188	0.62376789513089
	LAYING	29	0.279111521944767	-0.018471953048314	-0.108675612269477	0.683067625610465
	LAYING	30	0.276305836721932	-0.0175856077340209	-0.10589355727859	0.696858200678851
	SITTING	12	0.275639357761194	-0.0184861388459702	-0.107917262447761	0.629964778955224
	SITTING	13	0.275895876198777	-0.0176504796070948	-0.109135285550765	0.709996516908257
	SITTING	17	0.27344147274375	-0.0180888559772812	-0.109111919458969	0.668613344125
	SITTING	18	0.27795824		-0.01729741093		-0.110021546		0.962581161666667
	SITTING	19	0.269723487105556	-0.0182031515710306	-0.118277180099383	0.475323016
	SITTING	21	0.277466525522059	-0.0176664578561765	-0.10877848058848	0.645775957808824
	SITTING	22	0.279241531908081	-0.0168623073762273	-0.108558951083333	0.675242930959596

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
