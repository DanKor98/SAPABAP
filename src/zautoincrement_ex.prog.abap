*&---------------------------------------------------------------------*
*& Report ZAUTOINCREMENT_EX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zautoincrement_ex.


" list
DATA: ls_employee TYPE  zmj_employee_t,
      lt_employee TYPE STANDARD TABLE OF zmj_employee_t.

DATA: ls_layout   TYPE slis_layout_alv,
      lt_fieldcat TYPE slis_t_fieldcat_alv.

"" endlist

ls_employee = VALUE #( name = 'Daniel'  ).

*SELECT MAX( id ) FROM ZMJ_EMPLOYEE_T into @data(lv_num).
*
*DATA: lv_new_id type Z_EMPLOYEE_ID.
*  lv_new_id = lv_num + 1.
*  WRITE lv_num.
*
*
*  WRITE :lv_new_id.



"" list display.

*CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*  EXPORTING
**   I_PROGRAM_NAME         =
**   I_INTERNAL_TABNAME     =
*    i_structure_name       = 'ZMJ_EMPLOYEE_T'
**   I_CLIENT_NEVER_DISPLAY = 'X'
**   I_INCLNAME             =
**   I_BYPASSING_BUFFER     =
**   I_BUFFER_ACTIVE        =
*  CHANGING
*    ct_fieldcat            = lt_fieldcat
*  EXCEPTIONS
*    inconsistent_interface = 1
*    program_error          = 2
*    OTHERS                 = 3.
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*
*SELECT * FROM zmj_employee_t INTO TABLE lt_employee.
*
*
*
*
*
*CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
*  EXPORTING
**   I_INTERFACE_CHECK              = ' '
**   I_BYPASSING_BUFFER             =
**   I_BUFFER_ACTIVE                = ' '
**   I_CALLBACK_PROGRAM             = sy-repid
**   I_CALLBACK_PF_STATUS_SET       = ' '
**   I_CALLBACK_USER_COMMAND        = ' '
**   I_STRUCTURE_NAME               =
*    is_layout     = ls_layout
*    it_fieldcat   = lt_fieldcat
**   IT_EXCLUDING  =
**   IT_SPECIAL_GROUPS              =
**   IT_SORT       =
**   IT_FILTER     =
**   IS_SEL_HIDE   =
*    i_default     = 'X'
*    i_save        = ' '
**   IS_VARIANT    =
**   IT_EVENTS     =
**   IT_EVENT_EXIT =
**   IS_PRINT      =
**   IS_REPREP_ID  =
**   I_SCREEN_START_COLUMN          = 0
**   I_SCREEN_START_LINE            = 0
**   I_SCREEN_END_COLUMN            = 0
**   I_SCREEN_END_LINE              = 0
**   IR_SALV_LIST_ADAPTER           =
**   IT_EXCEPT_QINFO                =
**   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
**   IMPORTING
**   E_EXIT_CAUSED_BY_CALLER        =
**   ES_EXIT_CAUSED_BY_USER         =
*  TABLES
*    t_outtab      = lt_employee
*  EXCEPTIONS
*    program_error = 1
*    OTHERS        = 2.
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*"" lista.

break-point.
