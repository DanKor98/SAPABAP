
CLASS ltc_example_general DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_example_general.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: split FOR TESTING.
ENDCLASS.       "ltc_Example_General


CLASS ltc_example_general IMPLEMENTATION.

  METHOD class_setup.



  ENDMETHOD.


  METHOD class_teardown.



  ENDMETHOD.


  METHOD setup.


    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.



  ENDMETHOD.


  METHOD split.

    DATA iv_to_split TYPE string.
    DATA cs_cars TYPE zif_example_general=>ty_cars.
    DATA cs_cars_exp TYPE zif_example_general=>ty_cars.
    iv_to_split = '1,Jaguar,4128,172849.18,N'.

    f_cut->split(
      EXPORTING
        iv_to_split = iv_to_split
      CHANGING
        cs_cars     = cs_cars
    ).
    cs_cars_exp = VALUE #( id = '1' marka = 'Jaguar' przebieg = '4128' cena = '172849.18' status = 'N' ).

    cl_abap_unit_assert=>assert_equals(
      act   = cs_cars
      exp   = cs_cars_exp          "<--- please adapt expected value
      ).
  ENDMETHOD.




ENDCLASS.
