CLASS zcl_example_general DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS split
      IMPORTING
        !iv_to_split TYPE string
      CHANGING
        !cs_cars     TYPE zif_example_general=>ty_cars OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EXAMPLE_GENERAL IMPLEMENTATION.


  METHOD split.
    SPLIT iv_to_split AT ',' INTO cs_cars-id cs_cars-marka cs_cars-przebieg cs_cars-cena cs_cars-status.
  ENDMETHOD.
ENDCLASS.
