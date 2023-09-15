*&---------------------------------------------------------------------*
*& Report ZMJ_EMPLOYEE_OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmj_employee_output.

CONSTANTS:
  gc_active TYPE y_status VALUE 'A'.

DATA: lt_employee TYPE STANDARD TABLE OF zmj_employee_t,
      go_alv      TYPE REF TO cl_salv_table.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS:
  p_datef TYPE sy-datum DEFAULT sy-datum,
  p_datet TYPE sy-datum DEFAULT sy-datum,
  p_surn  TYPE y_user_surname MODIF ID sur.
SELECTION-SCREEN END OF BLOCK b1.
PARAMETERS:
  p_act  AS CHECKBOX DEFAULT abap_true,
  p_hide AS CHECKBOX USER-COMMAND hid.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_hide = abap_true.

      IF screen-group1 = 'SUR'.
        screen-active = 0.
        MODIFY SCREEN.
      ELSE.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

  ENDLOOP.



START-OF-SELECTION.

  IF p_act IS NOT INITIAL.
    PERFORM select_data.
  ENDIF.

  LOOP AT lt_employee ASSIGNING FIELD-SYMBOL(<fs_data>).
    <fs_data>-surname = 'Test'.
  ENDLOOP.


  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table   = go_alv                          " Basis Class Simple ALV Tables
        CHANGING
          t_table        = lt_employee
      ).
    CATCH cx_salv_msg. " ALV: General Error Class with MessageE
  ENDTRY.

  go_alv->display( ).


  FORM select_data.
        SELECT * FROM zmj_employee_t WHERE employement_date BETWEEN @p_datef AND @p_datet AND status = @gc_active
      INTO TABLE @lt_employee.
    ENDFORM.
