*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMJ_EMPLOYEE_V..................................*
TABLES: ZMJ_EMPLOYEE_V, *ZMJ_EMPLOYEE_V. "view work areas
CONTROLS: TCTRL_ZMJ_EMPLOYEE_V
TYPE TABLEVIEW USING SCREEN '0100'.
DATA: BEGIN OF STATUS_ZMJ_EMPLOYEE_V. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZMJ_EMPLOYEE_V.
* Table for entries selected to show on screen
DATA: BEGIN OF ZMJ_EMPLOYEE_V_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZMJ_EMPLOYEE_V.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMJ_EMPLOYEE_V_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZMJ_EMPLOYEE_V_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZMJ_EMPLOYEE_V.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMJ_EMPLOYEE_V_TOTAL.

*.........table declarations:.................................*
TABLES: ZMJ_EMPLOYEE_T                 .
TABLES: ZMJ_WORKPOS_T                  .
