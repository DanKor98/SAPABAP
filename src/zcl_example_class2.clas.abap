class ZCL_EXAMPLE_CLASS2 definition
  public
  final
  create public .

public section.

  interfaces ZIF_EXAMPLE_INTERFACE2 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_EXAMPLE_CLASS2 IMPLEMENTATION.


  method ZIF_EXAMPLE_INTERFACE2~EXAMPLE_METHOD.
   WRITE 'This is class specific definition of interface method'.
  endmethod.
ENDCLASS.
