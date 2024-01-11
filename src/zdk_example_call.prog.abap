*&---------------------------------------------------------------------*
*& Report ZDK_EXAMPLE_CALL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDK_EXAMPLE_CALL.



DATA(lo_cl_method) = NEW ZCL_EXAMPLE_CLASS2( ).

WRITE 'This is redefined method of interface in ZCL_EXAMPLE_CLASS2 class'.
lo_cl_method->zif_example_interface2~example_method( ).

NEW-LINE.
WRITE: 'This is constant display from the interface: ', zif_example_interface2=>mv_example_variable.

WRITE : 'Test'.
