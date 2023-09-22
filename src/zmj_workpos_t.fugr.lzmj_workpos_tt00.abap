*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMJ_WORKPOS_T...................................*
DATA:  BEGIN OF STATUS_ZMJ_WORKPOS_T                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMJ_WORKPOS_T                 .
CONTROLS: TCTRL_ZMJ_WORKPOS_T
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *ZMJ_WORKPOS_T                 .
TABLES: ZMJ_WORKPOS_T                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
