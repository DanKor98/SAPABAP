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


DATA: go_employee TYPE REF TO zmj_cl_employee_controller.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS:
  p_datef TYPE sy-datum DEFAULT sy-datum,
  p_datet TYPE sy-datum DEFAULT sy-datum,
  p_surn  TYPE y_user_surname MODIF ID sur.
SELECTION-SCREEN END OF BLOCK b1.
PARAMETERS:
  p_act  AS CHECKBOX DEFAULT abap_true,
  p_hide AS CHECKBOX USER-COMMAND hid.

AT SELECTION-SCREEN OUTPUT. " logika do ukrycia pola z MODIF ID sur ( pamiętać o user-command przy definicji checkboxu.

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

*
START-OF-SELECTION.
  CREATE OBJECT go_employee
    EXPORTING
      iv_action    = p_act
      ip_date_from = p_datef                " ABAP System Field: Current Date of Application Server
      ip_date_to   = p_datet.         " ABAP System Field: Current Date of Application Server


  DATA(gt_employee) = go_employee->start_processing( ).



  TRY.
      cl_salv_table=>factory( " wyświetlenie ALV. Pamiętaj o ctrl+space cl_salv_table=> ( ctrl + space )
        IMPORTING
          r_salv_table   = go_alv                          " GO_ALV zdefiniowane na górze w DATA:
        CHANGING
          t_table        = gt_employee                     " tabela którą chcemy wyświetlić
      ).
    CATCH cx_salv_msg. " ALV: General Error Class with MessageE
  ENDTRY.

  go_alv->display( ). " wywołanie metody do wyświetlenia treści.
