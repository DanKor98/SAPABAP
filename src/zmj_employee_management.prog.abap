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
  p_status AS CHECKBOX USER-COMMAND sta DEFAULT 'X' MODIF ID ust,
  p_surnam AS CHECKBOX USER-COMMAND sur MODIF ID usu.
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

*  IF p_surnam IS NOT INITIAL.
*    SELECT SINGLE * FROM zmj_employee_t WHERE id = @p_eid INTO  @DATA(ls_employee).
*    ls_employee-surname = p_newsur.
*    UPDATE zmj_employee_t FROM ls_employee.
*
*    IF sy-subrc = 0.
*
*      ls_log-date_change = sy-datum.
*      ls_log-username = sy-uname.
*      ls_log-tablename = 'ZMJ_EMPLOYEE_T'.
*      ls_log-fieldname = 'SURNAME'.
*
*      INSERT zmj_log_t FROM ls_log.
*    ENDIF.
*  ENDIF.


  SELECT employee~id,
    employee~positionid,
    employee~name,
    employee~surname,
         zmj_workpos_t~position_name,
    zmj_workpos_t~description
    FROM zmj_employee_t AS employee
    INNER JOIN zmj_workpos_t
    ON employee~positionid = zmj_workpos_t~id INTO TABLE @DATA(lt_overview)  WHERE employee~id = @p_eid.


  IF sy-subrc <> 0.

*    MESSAGE i000(zmm_employee) WITH p_eid DISPLAY LIKE 'E'.

  ENDIF.


  BREAK-POINT.
