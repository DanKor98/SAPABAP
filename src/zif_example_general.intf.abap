INTERFACE zif_example_general
  PUBLIC .
  TYPES: BEGIN OF ty_cars,
           id       TYPE string,
           marka    TYPE string,
           przebieg TYPE string,
           cena     TYPE string,
           status   TYPE string,
         END OF ty_cars.
ENDINTERFACE.
