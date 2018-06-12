   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               your_round_name                                        *
   *               MASTER DO_FILE                                         *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      Write intro to survey round here

       ** OUTLINE:      PART 0: Standardize settings and install packages
                        PART 1: Preparing folder path globals
                        PART 2: Run the master do files for each high level task

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

   * Project folder globals
   * ---------------------

   global dataWorkFolder         "$projectfolder/DataWork"

*iefolder*1*FolderGlobals*master************************************************
*iefolder will not work properly if the line above is edited

   global mastData               "$dataWorkFolder/MasterData"

*iefolder*1*FolderGlobals*encrypted*********************************************
*iefolder will not work properly if the line above is edited

   global encryptFolder          "$dataWorkFolder/EncryptedData"

*iefolder*1*FolderGlobals*Lab7**************************************************
*iefolder will not work properly if the line above is edited


   *Encrypted round sub-folder globals
   global Lab7                   "$dataWorkFolder/Lab7"

   *Encrypted round sub-folder globals
   global Lab7_encrypt           "$encryptFolder/Round Lab7 Encrypted"
   global Lab7_dtRaw             "$Lab7_encrypt/Raw Identified Data"
   global Lab7_doImp             "$Lab7_encrypt/Dofiles Import"
   global Lab7_HFC               "$Lab7_encrypt/High Frequency Checks"

   *DataSets sub-folder globals
   global Lab7_dt                "$Lab7/DataSets"
   global Lab7_dtInt             "$Lab7_dt/Intermediate"
   global Lab7_dtFin             "$Lab7_dt/Final"

   *Dofile sub-folder globals
   global Lab7_do                "$Lab7/Dofiles"
   global Lab7_doCln             "$Lab7_do/Cleaning"
   global Lab7_doCon             "$Lab7_do/Construct"
   global Lab7_doAnl             "$Lab7_do/Analysis"

   *Output sub-folder globals
   global Lab7_out               "$Lab7/Output"
   global Lab7_outRaw            "$Lab7_out/Raw"
   global Lab7_outFin            "$Lab7_out/Final"

   *Questionnaire sub-folder globals
   global Lab7_prld              "$Lab7_quest/PreloadData"
   global Lab7_doc               "$Lab7_quest/Questionnaire Documentation"

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
   *           -A task master dofile has been created for each high
   *            level task (cleaning, construct, analyze). By
   *            running all of them all data work associated with the
   *            Lab7 should be replicated, including output of
   *            tablets, graphs, etc.
   *           -Feel free to add to this list if you have other high
   *            level tasks relevant to your project.
   *
   * ******************************************************************** *

   **Set the locals corresponding to the taks you want
   * run to 1. To not run a task, set the local to 0.
   local importDo       0
   local cleaningDo     0
   local constructDo    0
   local analysisDo     1

   if (`importDo' == 1) { //Change the local above to run or not to run this file
       do "$Lab7_doImp/Lab7_import_MasterDofile.do"
   }

   if (`cleaningDo' == 1) { //Change the local above to run or not to run this file
       do "$Lab7_do/Lab7_cleaning_MasterDofile.do"
   }

   if (`constructDo' == 1) { //Change the local above to run or not to run this file
       do "$Lab7_do/Lab7_construct_MasterDofile.do"
   }

   if (`analysisDo' == 1) { //Change the local above to run or not to run this file
       do "$Lab7_do/Lab7_analysis_MasterDofile.do"
   }

*iefolder*3*End_RunDofiles******************************************************
*iefolder will not work properly if the line above is edited
