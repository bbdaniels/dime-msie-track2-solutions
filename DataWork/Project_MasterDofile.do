   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               your_project_name                                      *
   *               MASTER DO_FILE                                         *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      Write intro to project here

       ** OUTLINE:      PART 0: Standardize settings and install packages
                        PART 1: Set globals for dynamic file paths
                        PART 2: Set globals for constants and varlist
                               used across the project. Intall custom
                               commands needed.
                        PART 3: Call the task specific master do-files
                               that call all do-files needed for that
                               tas. Do not include Part 0-2 in a task
                               specific master do-file


       ** IDS VAR:      list_ID_var_here         //Uniquely identifies households (update for your project)

       ** NOTES:

       ** WRITEN BY:    names_of_contributors

       ** Last date modified:  9 Jun 2018
       */

*iefolder*0*StandardSettings****************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 0:  INSTALL PACKAGES AND STANDARDIZE SETTINGS
   *
   *           -Install packages needed to run all dofiles called
   *            by this master dofile.
   *           -Use ieboilstart to harmonize settings across users
   *
   * ******************************************************************** *

*iefolder*0*End_StandardSettings************************************************
*iefolder will not work properly if the line above is edited

   *Install all packages that this project requires:
   local user_commands ietoolkit       //Fill this list will all commands this project requires
   foreach command of local user_commands {
       cap which `command'
       if _rc == 111 {
           cap ssc install `command'
       }
   }

   *Standardize settings accross users
   ieboilstart, version(12.1)          //Set the version number to the oldest version used by anyone in the project team
   `r(version)'                        //This line is needed to actually set the version from the command above

*iefolder*1*FolderGlobals*******************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 1:  PREPARING FOLDER PATH GLOBALS
   *
   *           -Set the global box to point to the project folder
   *            on each collaborators computer.
   *           -Set other locals that point to other folders of interest.
   *
   * ******************************************************************** *

   * Users
   * -----------

   *User Number:
   * You                     1    //Replace "You" with your name
   * Next User               2    //Assign a user number to each additional collaborator of this code

   *Set this value to the user currently using this file
   global user  1

   * Root folder globals
   * ---------------------

   if $user == 1 {
       global projectfolder "/Users/bbdaniels/GitHub/dime-msie-track2-solutions/"
   }

   if $user == 2 {
       global projectfolder ""  //Enter the file path to the projectfolder of next user here
   }

*These lines are used to test that name ois not already used (do not edit manually)
*round*round2*round3*Lab2*Lab3*Lab4*Lab5*Lab6*Lab7*Lab8*************************
*untObs*************************************************************************
*subFld*************************************************************************
*iefolder will not work properly if the lines above are edited


   * Project folder globals
   * ---------------------

   global dataWorkFolder         "$projectfolder/DataWork"

*iefolder*1*FolderGlobals*subfolder*********************************************
*iefolder will not work properly if the line above is edited


*iefolder*1*FolderGlobals*master************************************************
*iefolder will not work properly if the line above is edited

   global mastData               "$dataWorkFolder/MasterData"

*iefolder*1*FolderGlobals*encrypted*********************************************
*iefolder will not work properly if the line above is edited

   global encryptFolder          "$dataWorkFolder/EncryptedData"


*iefolder*1*RoundGlobals*rounds*Lab2*Lab2***************************************
*iefolder will not work properly if the line above is edited

   *Lab2 folder globals
   global Lab2                   "$dataWorkFolder/Lab2"
   global Lab2_encrypt           "$encryptFolder/Round Lab2 Encrypted"
   global Lab2_dt                "$Lab2/DataSets"
   global Lab2_do                "$Lab2/Dofiles"
   global Lab2_out               "$Lab2/Output"


*iefolder*1*RoundGlobals*rounds*Lab3*Lab3***************************************
*iefolder will not work properly if the line above is edited

   *Lab3 folder globals
   global Lab3                   "$dataWorkFolder/Lab3"
   global Lab3_encrypt           "$encryptFolder/Round Lab3 Encrypted"
   global Lab3_dt                "$Lab3/DataSets"
   global Lab3_do                "$Lab3/Dofiles"
   global Lab3_out               "$Lab3/Output"


*iefolder*1*RoundGlobals*rounds*Lab4*Lab4***************************************
*iefolder will not work properly if the line above is edited

   *Lab4 folder globals
   global Lab4                   "$dataWorkFolder/Lab4"
   global Lab4_encrypt           "$encryptFolder/Round Lab4 Encrypted"
   global Lab4_dt                "$Lab4/DataSets"
   global Lab4_do                "$Lab4/Dofiles"
   global Lab4_out               "$Lab4/Output"


*iefolder*1*RoundGlobals*rounds*Lab5*Lab5***************************************
*iefolder will not work properly if the line above is edited

   *Lab5 folder globals
   global Lab5                   "$dataWorkFolder/Lab5"
   global Lab5_encrypt           "$encryptFolder/Round Lab5 Encrypted"
   global Lab5_dt                "$Lab5/DataSets"
   global Lab5_do                "$Lab5/Dofiles"
   global Lab5_out               "$Lab5/Output"


*iefolder*1*RoundGlobals*rounds*Lab6*Lab6***************************************
*iefolder will not work properly if the line above is edited

   *Lab6 folder globals
   global Lab6                   "$dataWorkFolder/Lab6"
   global Lab6_encrypt           "$encryptFolder/Round Lab6 Encrypted"
   global Lab6_dt                "$Lab6/DataSets"
   global Lab6_do                "$Lab6/Dofiles"
   global Lab6_out               "$Lab6/Output"


*iefolder*1*RoundGlobals*rounds*Lab7*Lab7***************************************
*iefolder will not work properly if the line above is edited

   *Lab7 folder globals
   global Lab7                   "$dataWorkFolder/Lab7"
   global Lab7_encrypt           "$encryptFolder/Round Lab7 Encrypted"
   global Lab7_dt                "$Lab7/DataSets"
   global Lab7_do                "$Lab7/Dofiles"
   global Lab7_out               "$Lab7/Output"


*iefolder*1*RoundGlobals*rounds*Lab8*Lab8***************************************
*iefolder will not work properly if the line above is edited

   *Lab8 folder globals
   global Lab8                   "$dataWorkFolder/Lab8"
   global Lab8_encrypt           "$encryptFolder/Round Lab8 Encrypted"
   global Lab8_dt                "$Lab8/DataSets"
   global Lab8_do                "$Lab8/Dofiles"
   global Lab8_out               "$Lab8/Output"

*iefolder*1*FolderGlobals*endRounds*********************************************
*iefolder will not work properly if the line above is edited


*iefolder*1*End_FolderGlobals***************************************************
*iefolder will not work properly if the line above is edited


*iefolder*2*StandardGlobals*****************************************************
*iefolder will not work properly if the line above is edited

   * Set all non-folder path globals that are constant accross
   * the project. Examples are conversion rates used in unit
   * standardization, differnt set of control variables,
   * ado file paths etc.

   do "$dataWorkFolder/global_setup.do"


*iefolder*2*End_StandardGlobals*************************************************
*iefolder will not work properly if the line above is edited


*iefolder*3*RunDofiles**********************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 3: - RUN DOFILES CALLED BY THIS MASTER DO FILE
   *
   *           -When survey rounds are added, this section will
   *            link to the master dofile for that round.
   *           -The default is that these dofiles are set to not
   *            run. It is rare that all round specfic master dofiles
   *            are called at the same time, the round specific master
   *            dofiles are almost always called individually. The
   *            exception is when reviewing or replicating a full project.
   *
   * ******************************************************************** *


*iefolder*3*RunDofiles*Lab2*Lab2************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab2 master dofile
       do "$Lab2/Lab2_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab3*Lab3************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab3 master dofile
       do "$Lab3/Lab3_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab4*Lab4************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab4 master dofile
       do "$Lab4/Lab4_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab5*Lab5************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab5 master dofile
       do "$Lab5/Lab5_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab6*Lab6************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab6 master dofile
       do "$Lab6/Lab6_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab7*Lab7************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab7 master dofile
       do "$Lab7/Lab7_MasterDofile.do"
   }


*iefolder*3*RunDofiles*Lab8*Lab8************************************************
*iefolder will not work properly if the line above is edited

   if (0) { //Change the 0 to 1 to run the Lab8 master dofile
       do "$Lab8/Lab8_MasterDofile.do"
   }

*iefolder*3*End_RunDofiles******************************************************
*iefolder will not work properly if the line above is edited
