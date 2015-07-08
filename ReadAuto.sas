

/* modified in master */
=======
/* modified on iss01 by SAS Studio */
/* modified on iss01 commit hash 6fc1526 */
/* modified on iss01 */
/* modified by SAS Studio */
>>>>>>> iss01

#### Task

Load Auto.data (an R data set in ISLR) into SAS.

This is a small specific task, yet one building block for data craft.

#### Challenge:

The data set mix spaces and tab delimiters which can't be loaded directly 
by any of SAS input styles (list, column, format, named) alone. 
The first row is the variable names which are delimited by tab.
Data observations begins at the second row in which values are delimited by spaces 
except for the last two by tab.

#### Solutions:

Solution 1:

Preprocess the data set by replacing tab with two spaces using Notepad++.
The preprocessed file is renamed as AutoPreprocessed.data. Then use list input.

Solution 2:

First use Excel to load Auto.data, then save as Auto.xlsx and Auto.csv. 
Import from Auto.xlsx or Auto.csv.


#### To-do

DLM='20'x doesn't work. Why?


#### Reference:

*  SAS 9.4 Language Reference: Concepts, Ch19 Reading Raw Data
   - p428
   To read and store a character input value longer than 8 bytes, define a variable's
length by using a LENGTH, INFORMAT, or ATTRIB statement before the INPUT
statement, or by using modified list input, which consists of an informat and the
colon modifier in the INPUT statement. See “Modified List Input” on page 428 for
more information.
   - p430 Replace all tabs in the data with single spaces using another editor outside of SAS.

*  SAS 9.4 Statements Reference
   INFILE, INPUT statements.


#### Code
   
data auto3;
   infile '/folders/myshortcuts/1aDC/Data/AutoPreprocessed.data' 
          dsd dlmstr='20'x firstobs=2;

   length name $ 40;
   input 
      mpg
      cylinders
      displacement
      horsepower
      weight
      acceleration
      year
      origin
      name $;
/*    name : $40.; */  /* Use modified list input if no LENGTH statement before INPUT */
run;


/* First use Excel to load Auto.data, then save as Auto.xlsx and Auto.csv */

/* Import from Auto.xlsx. No error warning. */
proc import out=work.auto
            datafile='/folders/myshortcuts/1aDC/Data/Auto.xlsx'
            dbms=xlsx replace;
   getnames=yes;
   sheet="Sheet1";
run; 

/* Import from Auto.csv. There are error warning though getting data into dataset. */
proc import out=work.auto
            datafile='/folders/myshortcuts/1aDC/Data/Auto.csv'
            dbms=csv replace;
            getnames=yes;
            datarow=2;
run;            

/* Or */

filename csvfile "/folders/myshortcuts/1aDC/Data/Auto.csv" termstr=CRLF;
proc import datafile=csvfile
            dbms=csv
            out=work.auto
            replace;
run;         



