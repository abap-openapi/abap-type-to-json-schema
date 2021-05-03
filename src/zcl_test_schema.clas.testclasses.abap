*"* use this source file for your ABAP unit test classes

CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO zcl_test_schema.

    METHODS:
      setup,
      run FOR TESTING.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT mo_cut.
  ENDMETHOD.

  METHOD run.

    DATA lv_schema TYPE string.

    lv_schema = mo_cut->run( ).

  ENDMETHOD.

ENDCLASS.
