*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMJ_EMPLOYEE_T..................................*
DATA:  BEGIN OF STATUS_ZMJ_EMPLOYEE_T                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMJ_EMPLOYEE_T                .
CONTROLS: TCTRL_ZMJ_EMPLOYEE_T
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZMJ_EMPLOYEE_T                .
TABLES: ZMJ_EMPLOYEE_T                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
