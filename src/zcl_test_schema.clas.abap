CLASS zcl_test_schema DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF bar,
             foo TYPE i,
             moo TYPE string,
           END OF bar.

    METHODS run
      RETURNING
        VALUE(rv_schema) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_SCHEMA IMPLEMENTATION.


  METHOD run.

    DATA lo_type TYPE REF TO cl_abap_typedescr.
    DATA lo_structure TYPE REF TO cl_abap_structdescr.
    DATA ls_component TYPE LINE OF cl_abap_structdescr=>component_table.

    lo_type = cl_abap_typedescr=>describe_by_name( 'ZCL_TEST_SCHEMA=>BAR' ).

    CASE lo_type->type_kind.
      WHEN cl_abap_typedescr=>typekind_struct2.
        lo_structure ?= lo_type.
        LOOP AT lo_structure->get_components( ) INTO ls_component.
          rv_schema = rv_schema && ls_component-name.
        ENDLOOP.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
