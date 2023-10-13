*&---------------------------------------------------------------------*
*& Report ZMJ_EMPLOYEE_MANAGEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmj_employee_management.
TABLES zmj_workpos_t.

* raport majacy na celu edycje obszaru employee w co wliczamy tabele workposition w prawdziwym świecie najoptymalniej byłoby 2 procesy rozdzielić, ale też może być sytuacja, że trzeba zrobić dwa w jednym.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS:
  p_eid    TYPE y_user_id MODIF ID eid,
  p_wid    TYPE zmj_workpos_t-id MODIF ID wid,
  p_newsur TYPE y_user_name MODIF ID nsu,
  p_newsal TYPE y_user_salary MODIF ID nsa,
  p_stat   TYPE y_status MODIF ID nst.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
PARAMETERS:
  p_salary AS CHECKBOX USER-COMMAND pay MODIF ID upa,
  p_status AS CHECKBOX USER-COMMAND sta  MODIF ID ust, " this paramter is for calculating something.
  p_surnam AS CHECKBOX USER-COMMAND sur MODIF ID usu,
  p_disp   AS CHECKBOX USER-COMMAND dis MODIF ID dis.
SELECTION-SCREEN END OF BLOCK b2.

DATA: ls_log TYPE zmj_log_t.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF p_status EQ abap_true.
      p_surnam = abap_false.
      p_salary = abap_false.
      IF screen-group1 EQ 'NST' OR screen-group1 EQ 'UPA' OR screen-group1 EQ 'UST' OR screen-group1 = 'EID' OR screen-group1 EQ 'USU'.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF p_salary EQ abap_true.
      p_surnam = abap_false.
      p_status = abap_false.
      IF screen-group1 EQ 'NSA' OR screen-group1 EQ 'UPA' OR screen-group1 EQ 'UST' OR screen-group1 EQ 'NSA' OR screen-group1 = 'WID' OR screen-group1 EQ 'USU'.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF p_surnam EQ abap_true.
      p_status = abap_false.
      p_salary = abap_false.
      IF screen-group1 EQ 'NSU' OR screen-group1 EQ 'UPA' OR screen-group1 EQ 'UST' OR screen-group1 = 'EID' OR screen-group1 EQ 'USU'.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.


  CASE sy-ucomm.

    WHEN 'PAY'.

    WHEN OTHERS.
  ENDCASE.

  IF p_disp IS NOT INITIAL.
    SELECT employee~id,
      employee~positionid,
      employee~name,
      employee~surname,
      zmj_workpos_t~salary,
           zmj_workpos_t~position_name,
      zmj_workpos_t~description
      FROM zmj_employee_t AS employee
      INNER JOIN zmj_workpos_t
      ON employee~positionid = zmj_workpos_t~id INTO TABLE @DATA(lt_overview).

*    DATA: go_alv TYPE REF TO cl_salv_table.
*    TRY.
*        cl_salv_table=>factory( " wyświetlenie ALV. Pamiętaj o ctrl+space cl_salv_table=> ( ctrl + space )
*          IMPORTING
*            r_salv_table   = go_alv                          " GO_ALV zdefiniowane na górze w DATA:
*          CHANGING
*            t_table        = lt_overview                     " tabela którą chcemy wyświetlić
*        ).
*      CATCH cx_salv_msg. " ALV: General Error Class with MessageE
*    ENDTRY.
*
*    go_alv->display( ). " wywołanie metody do wyświetlenia treści.
    DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
          ls_fieldcat TYPE slis_fieldcat_alv.


    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZMJ_OUTPUT_S'
      CHANGING
        ct_fieldcat            = lt_fieldcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    LOOP AT lt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
      IF <fs_fieldcat>-fieldname = 'SALARY'.
        <fs_fieldcat>-edit = abap_true.
      ENDIF.
    ENDLOOP.
    DATA: ls_layout TYPE slis_layout_alv.

    ls_layout-colwidth_optimize = abap_true.
    ls_layout-expand_all = abap_true.
    ls_layout-cell_merge = abap_true.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program       = sy-repid
*       I_INTERFACE_CHECK        = ' '
*       I_BYPASSING_BUFFER       = ' '
*       I_BUFFER_ACTIVE          = ' '
        i_callback_pf_status_set = 'SET_STATUS'
        i_callback_user_command  = 'USR_COMMAND'
*       I_CALLBACK_TOP_OF_PAGE   = ' '
*       I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*       I_CALLBACK_HTML_END_OF_LIST       = ' '
*       I_STRUCTURE_NAME         =
*       I_BACKGROUND_ID          = ' '
*       I_GRID_TITLE             =
*       I_GRID_SETTINGS          =
        is_layout                = ls_layout
        it_fieldcat              = lt_fieldcat
*       IT_EXCLUDING             =
*       IT_SPECIAL_GROUPS        =
*       IT_SORT                  =
*       IT_FILTER                =
*       IS_SEL_HIDE              =
*       I_DEFAULT                = 'X'
*       IS_VARIANT               =
*       IT_EVENTS                =
*       IT_EVENT_EXIT            =
*       IS_PRINT                 =
*       IS_REPREP_ID             =
*       I_SCREEN_START_COLUMN    = 0
*       I_SCREEN_START_LINE      = 0
*       I_SCREEN_END_COLUMN      = 0
*       I_SCREEN_END_LINE        = 0
*       I_HTML_HEIGHT_TOP        = 0
*       I_HTML_HEIGHT_END        = 0
*       IT_ALV_GRAPHICS          =
*       IT_HYPERLINK             =
*       IT_ADD_FIELDCAT          =
*       IT_EXCEPT_QINFO          =
*       IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*       E_EXIT_CAUSED_BY_CALLER  =
*       ES_EXIT_CAUSED_BY_USER   =
      TABLES
        t_outtab                 = lt_overview
      EXCEPTIONS
        program_error            = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.

FORM set_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'GUI'.
ENDFORM.

FORM usr_command USING r_ucomm LIKE sy-ucomm
                        rs_selfield TYPE slis_selfield.     "#EC CALLED
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'SAVE'.
      DATA : ref_grid TYPE REF TO cl_gui_alv_grid. "new
      IF ref_grid IS INITIAL.
        CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
          IMPORTING
            e_grid = ref_grid.
      ENDIF.

      IF NOT ref_grid IS INITIAL.
        CALL METHOD ref_grid->check_changed_data.
      ENDIF.
      DATA: ls_employee_ch TYPE zmj_employee_t.

      LOOP AT lt_overview ASSIGNING FIELD-SYMBOL(<fs_over>).

        ls_employee_ch-salary = <fs_over>-salary.
      ENDLOOP.

  ENDCASE.

ENDFORM.
