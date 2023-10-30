class ZMJ_CL_EMPLOYEE_CONTROLLER definition
  public
  final
  create public .

public section.

  interfaces ZIF_EXAMPLE_INTERFACE .

  methods CONSTRUCTOR
    importing
      !IV_ACTION type C optional
      !IP_DATE_FROM type SY-DATUM optional
      !IP_DATE_TO type SY-DATUM optional .
  methods START_PROCESSING
    returning
      value(RT_EMPLOYEE) type ZTT_EMPLOYEE .
protected section.
private section.

  data MV_ACTION type C .
  data MV_DATEF type SY-DATUM .
  data MV_DATET type SY-DATUM .
  data MO_EMPLOYEE_MODEL type ref to ZMJ_CL_EMPLOYEE_MODEL .
ENDCLASS.



CLASS ZMJ_CL_EMPLOYEE_CONTROLLER IMPLEMENTATION.


  METHOD constructor.
    mv_action = iv_action.
    mv_datef = ip_date_from.
    mv_datet = ip_date_to.
    mo_employee_model = NEW zmj_cl_employee_model( ).
  ENDMETHOD.


  METHOD start_processing.
    DATA: lt_employee TYPE ztt_employee.
    IF mv_action = abap_true.
      rt_employee = mo_employee_model->get_data(
          EXPORTING
            ip_date_from =                  mv_datef
            ip_date_to   =                  mv_datet
        ).

     rt_employee = mo_employee_model->increase_employee_salary( rt_employee ).
*       mamy tabele z wpisami ktore nas interesuja teraz mozemy nimi manipulowac wykorzysutjac inne metody z klasy MODEL obecna metoda - start processing nie musi byc jedyna w kontrolerze
*      ## mozemy robic pare controlli dla roznych caseow ta metoda np moglaby sie nazywac start_salary_process i tutaj po wywolaniu get_data nastepna metoda byloby dajmy na to increase_salary gdzie przekazujemy nasza tabele
*      ## lt_employee i wykonujemy to co nas interesuje i nastepnie zwracamy na zewnatrz tabele wynikowa
    ENDIF.
  ENDMETHOD.


  method ZIF_EXAMPLE_INTERFACE~GET_DATA.
    WRITE 'Controller'.
  endmethod.
ENDCLASS.
