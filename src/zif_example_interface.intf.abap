INTERFACE zif_example_interface
  PUBLIC .
  CONSTANTS: gv_example type string value 'Test'.

METHODS get_data
  IMPORTING
    !ip_date_from TYPE sy-datum
    !ip_date_to TYPE sy-datum.


endinterface.
