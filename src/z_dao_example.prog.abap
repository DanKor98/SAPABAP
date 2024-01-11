*&---------------------------------------------------------------------*
*& Report Z_DAO_EXAMPLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_dao_example.

DATA(lo_emp_dao) = NEW zcl_employee_dao( ).
TRY.
    lo_emp_dao->get_by_id( iv_employee_id = 5 ).
  CATCH zcx_employee_dao INTO DATA(cx_dao). " Exception class for Employee DAO
    WRITE cx_dao->get_text( ).
ENDTRY.
