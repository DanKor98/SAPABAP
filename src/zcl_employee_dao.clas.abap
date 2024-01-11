class ZCL_EMPLOYEE_DAO definition
  public
  final
  create public .

public section.

  methods GET_BY_ID
    importing
      !IV_EMPLOYEE_ID type Z_EMPLOYEE_ID
    returning
      value(RS_OUTPUT) type ZMJ_EMPLOYEE_T
  RAISING zcx_employee_dao.
protected section.
private section.
ENDCLASS.



CLASS ZCL_EMPLOYEE_DAO IMPLEMENTATION.


  METHOD get_by_id.
    SELECT SINGLE * FROM zmj_employee_t WHERE id = @iv_employee_id INTO @rs_output.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_employee_dao(
        textid      = zcx_employee_dao=>empoloyee_not_found
        employee_id = iv_employee_id
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
