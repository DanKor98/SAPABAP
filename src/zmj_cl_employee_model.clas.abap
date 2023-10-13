class ZMJ_CL_EMPLOYEE_MODEL definition
  public
  final
  create public .

public section.

  methods GET_DATA
    importing
      !IP_DATE_FROM type SY-DATUM
      !IP_DATE_TO type SY-DATUM
    returning
      value(RT_EMPLOYEE) type ZTT_EMPLOYEE .
  methods INCREASE_EMPLOYEE_SALARY
    importing
      !IT_EMPLOYEE type ZTT_EMPLOYEE
    returning
      value(RT_EMPLOYEE) type ZTT_EMPLOYEE .
protected section.
private section.
ENDCLASS.



CLASS ZMJ_CL_EMPLOYEE_MODEL IMPLEMENTATION.


  METHOD get_data.
    CONSTANTS: lv_active TYPE c VALUE 'A'.
    SELECT * FROM zmj_employee_t WHERE employement_date BETWEEN @ip_date_from AND @ip_date_to AND status = @lv_active
INTO TABLE @rt_employee.
  ENDMETHOD.


  METHOD increase_employee_salary.

    rt_employee = it_employee.

    LOOP AT rt_employee ASSIGNING FIELD-SYMBOL(<fs_employee>).
      <fs_employee>-salary = <fs_employee>-salary + 50.
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
