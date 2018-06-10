   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               LAB3 CONSTRUCT MASTER DO_FILE                          *
   *               This master dofile calls all dofiles related           *
   *               to construct in the Lab3 round.                        *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

   ** IDS VAR:          hh_id  mem_id       // Uniquely identifies household members (update for your project)
   ** NOTES:
   ** WRITEN BY:        Benjamin Daniels
   ** Last date modified:  9 Jun 2018


   * ***************************************************** *
   *                                                       *
   * ***************************************************** *
   *
   *   Create the master houshold roster.
   *
   *   The purpose of this dofiles is:
   *     Create the master household dataset. (UID:hh_id)
   *
   * ***************************************************** *

       do "$Lab3_doCon/lab3-construct-masterhh.do"

   * ***************************************************** *
   *
   *   Create the final household roster dataset.
   *
   *   The purpose of this dofiles is:
   *     Merge the household dataset onto the household roster.
   *
   * ***************************************************** *

       do "$Lab3_doCon/lab3-construct-roster.do"

   * ***************************************************** *
   *
   *   construct dofile 3
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      -what additional data sets does this file require
   *      -what variables are created
   *      -what corrections are made
   *
   * ***************************************************** *

       *do "$Lab3_doCon/dofile3.do" //Give your dofile a more informative name, this is just a place holder name

   * ************************************
   *   Keep adding sections for all additional dofiles needed
