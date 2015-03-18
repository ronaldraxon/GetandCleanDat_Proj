##############################################################################################
## run_analysis.R 
## ----------------------- 
## Description:
## This is the script for extracting raw data from different files
## in the wearable computing project and collected
## from the accelerometers from the Samsung Galaxy S smartphone.
## this function has only one parameter an it is the path where the
## UCI HAR Dataset directory is located.
## This function has a couple lines commented in order to guide anyone who
## wants to use it, but if you need further information about how to run this code, 
## please check the Readme.md entry at https://github.com/ronaldraxon/GetandCleanDat_Proj
## Also you can find info about how this program works and meta data in the codebook.txt located
## in the same repo.
#############################################################################################
run_analysis <- function(rds_path = getwd()) {
  
  message("Executing! please wait...")
  suppressMessages(library(dplyr))
  suppressMessages(library(plyr))
  suppressMessages(library(base))
  
  ################################
  ##1.Verifies the files existence
  ################################
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/test/subject_test.txt"),collapse=''))){
    message("subject_test.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/test/X_test.txt"),collapse=''))){
    message("X_test.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/test/y_test.txt"),collapse=''))){
    message("y_test.txt is not available! Please check the directory path.")
    print("no")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/train/subject_train.txt"),collapse=''))){
    message("subject_train.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/train/X_train.txt"),collapse=''))){
    message("X_train.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/train/y_train.txt"),collapse=''))){
    message("y_train.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/activity_labels.txt"),collapse=''))){
    message("activity_labels.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  if(!file.exists(paste(c(rds_path,"/UCI HAR Dataset/features.txt"),collapse=''))){
    message("activity_labels.txt is not available! Please check the directory path.")
    return(FALSE)
  }
  
  ###############################################################################
  ##2.Check the number of rows for y_train(Activites), subject_train and x_train)
  ###############################################################################
  df_actdstr <- read.table(paste(c(rds_path,"/UCI HAR Dataset/train/y_train.txt"),collapse=''))
  df_subdstr <- read.table(paste(c(rds_path,"/UCI HAR Dataset/train/subject_train.txt"),collapse=''))  
  df_valdstr <- read.table(paste(c(rds_path,"/UCI HAR Dataset/train/x_train.txt"),collapse=''))
  if(nrow(df_actdstr) != nrow(df_subdstr) | nrow(df_valdstr) != nrow(df_subdstr)){
    message("The files in train directory don't have the same number of observations!")
    return(FALSE)
  }
  
  ############################################################################
  ##3.Check the number of rows for y_test(Activites), subject_test and x_test)
  ############################################################################
  df_actdste <- read.table(paste(c(rds_path,"/UCI HAR Dataset/test/y_test.txt"),collapse=''))
  df_subdste <- read.table(paste(c(rds_path,"/UCI HAR Dataset/test/subject_test.txt"),collapse=''))
  df_valdste <- read.table(paste(c(rds_path,"/UCI HAR Dataset/test/x_test.txt"),collapse=''))
  if(nrow(df_actdste) != nrow(df_subdste) | nrow(df_valdste) != nrow(df_subdste)){
    message("The files in test directory don't have the same number of observations!")
    return(FALSE)
  }
  
  ########################################################################
  ##4.Binds (Merges) the training and the test sets to create one data set
  ########################################################################
  df_acticom <-rbind(df_valdstr,df_valdste)
  
  ###################################
  ##5.Set the Variable (column) names
  ###################################
  df_varname <- read.table(paste(c(rds_path,"/UCI HAR Dataset/features.txt"),collapse=''))
  df_varname <- df_varname$V2
  df_varname <- gsub("[[:punct:]]", "", df_varname)
  colnames(df_acticom) <- df_varname 
  
  ############################################################
  ##6.Extracts only the measurements on the mean and standard 
  ##deviation for each measurement.
  ############################################################
  df_data <- df_acticom[,-(461:502)]
  df_data <- df_data[,-(513:519)]
  df_data <- tbl_df(df_data)
  df_data <- cbind(select(df_data,contains("mean",ignore.case = TRUE)),select(df_data,contains("std",ignore.case = TRUE)))
  
  ##########################################################
  ##6.Changes de activities code number by their description
  ##########################################################
  df_actlb <- read.table(paste(c(rds_path,"/UCI HAR Dataset/activity_labels.txt"),collapse=''))
  df_joacttr <- suppressMessages(join(df_actlb,df_actdstr))
  df_joactte <- suppressMessages(join(df_actlb,df_actdste))
  df_acticom <- rbind(df_joacttr,df_joactte)
  colnames(df_acticom) <- c("Activity_code","Activity_desc")
  
  ###########################################
  ##7.Merges the activites with the data set
  ###########################################
  df_data <- cbind(select(df_acticom,Activity_desc),df_data)
  
  #########################################################
  ##8.Extract the subjects and merge them with the data set
  #########################################################
  df_josucom <- rbind(df_subdstr,df_subdste)
  colnames(df_josucom) <- c("Subject_num")
  
  ###################################
  ##9.Set the Variable (column) names
  ##################################
  df_data <- cbind(select(df_josucom,Subject_num),df_data)
  
  #####################################################
  ###9.1 Detach package plyr to use summarize properly
  #####################################################
  detach("package:plyr", unload=TRUE)
  suppressMessages(library(dplyr))
  
  ############################################################
  ##10.Create the files with the tidy data with the average of 
  ##each variable for each activity and each subject
  ############################################################
  gr_subacmen <- df_data %>%
                 group_by(Activity_desc,Subject_num) %>%
                 summarise_each(funs(mean))  
  message(paste(c("Creating secondary tidy data set in ",rds_path,"/tidymeanset.txt"),collapse=''))
  write.table(gr_subacmen, file = paste(c(rds_path,"/tidymeanset.txt"),collapse=''),row.names = FALSE)       
  message("Process succesfully finished!")
  return(df_data)
}