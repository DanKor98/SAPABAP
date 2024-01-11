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
         id       TYPE char30,
         marka    TYPE char30,
         przebieg TYPE i,
         cena     TYPE char30,
         status   TYPE char1,
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



  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
*     BIN_FILESIZE            =
      filename                = 'C:\Users\SZEF\Desktop/test.csv'
      filetype                = 'ASC'
*     APPEND                  = ' '
      write_field_separator   = 'X'
*     HEADER                  = '00'
*     TRUNC_TRAILING_BLANKS   = ' '
*     WRITE_LF                = 'X'
*     COL_SELECT              = ' '
*     COL_SELECT_MASK         = ' '
*     DAT_MODE                = ' '
*     CONFIRM_OVERWRITE       = ' '
*     NO_AUTH_CHECK           = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     WRITE_BOM               = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT            = ' '
*     WK1_N_SIZE              = ' '
*     WK1_T_FORMAT            = ' '
*     WK1_T_SIZE              = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS    = ABAP_TRUE
*     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*     FILELENGTH              =
    TABLES
      data_tab                = t_upload
*     FIELDNAMES              =
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  " for example
  DATA: lt_cars TYPE STANDARD TABLE OF zif_example_general=>ty_cars.
  DATA: ls_car TYPE zif_example_general=>ty_cars.

  DELETE t_upload INDEX 1.
  DATA(lo_general) = NEW zcl_example_general( ).

  LOOP AT t_upload INTO DATA(ls_entry).
    lo_general->split( EXPORTING iv_to_split = CONV #( ls_entry )
                       CHANGING  cs_cars = ls_car ).
    APPEND ls_car TO lt_cars.
  ENDLOOP.

  BREAK-POINT.
