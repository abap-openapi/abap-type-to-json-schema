CLASS zcl_test_schema DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS run
      RETURNING
        VALUE(rv_schema) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_test_schema IMPLEMENTATION.

  METHOD run.

    TYPES: BEGIN OF ty_bar,
             foo TYPE i,
             moo TYPE string,
           END OF ty_bar.

    DATA lo_type TYPE REF TO cl_abap_typedescr.
    DATA lo_structure TYPE REF TO cl_abap_structdescr.
    DATA lt_components TYPE cl_abap_structdescr=>component_table.
    DATA ls_component LIKE LINE OF lt_components.
    DATA ls_bar TYPE ty_bar.

    lo_type = cl_abap_typedescr=>describe_by_data( ls_bar ).

    CASE lo_type->type_kind.
      WHEN cl_abap_typedescr=>typekind_struct2.
        lo_structure ?= lo_type.
        lt_components = lo_structure->get_components( ).
        LOOP AT lt_components INTO ls_component.
          rv_schema = rv_schema && ls_component-name.
        ENDLOOP.
      WHEN OTHERS.
        WRITE lo_type->type_kind.
        ASSERT 1 = 2.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.