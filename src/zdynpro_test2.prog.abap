*&---------------------------------------------------------------------*
*& Module Pool      ZDYNPRO_TEST2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zdynpro_test2.
DATA: p_bname TYPE bname.
DATA: ls_output TYPE usr02.
*&---------------------------------------------------------------------*
*& Module STATUS_0400 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0400 OUTPUT.
  SET PF-STATUS 'ZSTATUS'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0400 INPUT.
  CASE sy-ucomm.
    WHEN 'CANCEL' OR 'BACK' OR 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'DISP'.
      SELECT SINGLE * FROM usr02 INTO CORRESPONDING FIELDS OF ls_output WHERE bname = p_bname.
      CALL SCREEN 500.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0500 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0500 OUTPUT.
  SET PF-STATUS 'ZSTATUS2'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0500 INPUT.
  DATA: lv_test TYPE c.

  CASE sy-ucomm.

    WHEN 'TEST'.
      lv_test = abap_true.
  ENDCASE.
ENDMODULE.
