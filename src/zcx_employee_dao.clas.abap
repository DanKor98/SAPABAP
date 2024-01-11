CLASS zcx_employee_dao DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    DATA employee_id TYPE z_employee_id .

    CONSTANTS:
      BEGIN OF zcx_employee_dao,
        msgid TYPE symsgid VALUE 'ZMC_EMPLOYEE',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'EMPLOYEE_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF zcx_employee_dao.
    CONSTANTS:
      BEGIN OF empoloyee_not_found,
        msgid TYPE symsgid VALUE 'ZMC_EMPLOYEE',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'EMPLOYEE_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF empoloyee_not_found .
    METHODS constructor
      IMPORTING
        !textid      LIKE if_t100_message=>t100key OPTIONAL
        !previous    LIKE previous OPTIONAL
        !employee_id TYPE z_employee_id OPTIONAL .
protected section.
private section.
ENDCLASS.



CLASS ZCX_EMPLOYEE_DAO IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->EMPLOYEE_ID = EMPLOYEE_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_EMPLOYEE_DAO .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
