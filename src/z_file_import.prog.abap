*&---------------------------------------------------------------------*
*& Report Z_FILE_IMPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_file_import.

TYPE-POOLS truxs.

PARAMETERS: p_file TYPE   rlgrap-filename.

DATA: fname      TYPE string,
      fpath      TYPE string,
      fpath_full TYPE string.

TYPES: BEGIN OF t_tab,
         line TYPE char255,
       END OF t_tab.

TYPES: BEGIN OF goal_tab,
         name    TYPE char30,
         surname TYPE char30,
         age     TYPE i,
       END OF goal_tab.


DATA: t_upload   TYPE STANDARD TABLE OF t_tab,
      ls_upload  TYPE t_tab,
      lt_filetab TYPE filetable,
      lv_rc      TYPE i,
      lt_final   TYPE STANDARD TABLE OF goal_tab.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    CHANGING
      file_table              = lt_filetab                " Table Holding Selected Files
      rc                      = lv_rc                " Return Code, Number of Files or -1 If Error Occurred
    EXCEPTIONS
      file_open_dialog_failed = 1                " "Open File" dialog failed
      cntl_error              = 2                " Control error
      error_no_gui            = 3                " No GUI available
      not_supported_by_gui    = 4                " GUI does not support this
      OTHERS                  = 5.
  IF sy-subrc <> 0.
  ENDIF.

  p_file = lt_filetab[ 1 ]-filename.



START-OF-SELECTION.

  DATA: lv_filename TYPE string.

  lv_filename = p_file.

  DATA(lv_interface_value) = zif_example_interface=>gv_example.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = lv_filename
      filetype                = 'ASC'
      has_field_separator     = 'X'
    TABLES
      data_tab                = t_upload
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT t_upload INTO DATA(ls_data).
    CLEAR ls_data.

    SPLIT ls_data-line AT ',' INTO: DATA(lv_name) DATA(lv_surname) DATA(lv_age).

  ENDLOOP.


  DATA(lo_model) = NEW ZMJ_CL_EMPLOYEE_MODEL( ).
