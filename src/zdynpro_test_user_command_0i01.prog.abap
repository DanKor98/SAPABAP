*----------------------------------------------------------------------*
***INCLUDE ZDYNPRO_TEST_USER_COMMAND_0I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SRCH'.
      SELECT SINGLE aname, erdat FROM usr02 INTO CORRESPONDING FIELDS OF @ls_output WHERE bname = @v1.
      WHEN 'BACK' OR 'EXIT' OR 'CANC'.
        LEAVE PROGRAM.
    ENDCASE.
ENDMODULE.
