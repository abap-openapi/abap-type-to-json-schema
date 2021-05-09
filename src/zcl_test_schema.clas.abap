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

    METHODS traverse
      IMPORTING
        !type         TYPE REF TO cl_abap_typedescr
      RETURNING
        VALUE(result) TYPE string .
    METHODS traverse_simple
      IMPORTING
        !type         TYPE REF TO cl_abap_typedescr
      RETURNING
        VALUE(result) TYPE string .
    METHODS traverse_structure
      IMPORTING
        !type         TYPE REF TO cl_abap_typedescr
      RETURNING
        VALUE(result) TYPE string .
    METHODS traverse_table
      IMPORTING
        !type         TYPE REF TO cl_abap_typedescr
      RETURNING
        VALUE(result) TYPE string .
ENDCLASS.



CLASS ZCL_TEST_SCHEMA IMPLEMENTATION.


  METHOD run.

    TYPES: BEGIN OF ty_bar,
             foo TYPE i,
             moo TYPE string,
           END OF ty_bar.

    DATA ls_bar TYPE ty_bar.

    DATA lo_type TYPE REF TO cl_abap_typedescr.

    lo_type = cl_abap_typedescr=>describe_by_data( ls_bar ).

    rv_schema = traverse( lo_type ).

  ENDMETHOD.


  METHOD traverse.

    CASE type->kind.
      WHEN cl_abap_typedescr=>kind_elem.
        result = traverse_simple( type ).
      WHEN cl_abap_typedescr=>kind_table.
        result = traverse_table( type ).
      WHEN cl_abap_typedescr=>kind_struct.
        result = traverse_structure( type ).
      WHEN OTHERS.
        WRITE type->type_kind.
        ASSERT 1 = 2.
    ENDCASE.

  ENDMETHOD.


  METHOD traverse_simple.

    CASE type->type_kind.
      WHEN cl_abap_typedescr=>typekind_int.
        result = 'number'.
      WHEN cl_abap_typedescr=>typekind_string.
        result = 'string'.
      WHEN cl_abap_typedescr=>typekind_char.
        result = 'string'.
      WHEN cl_abap_typedescr=>typekind_date.
        result = 'string'.
      WHEN cl_abap_typedescr=>typekind_time.
        result = 'string'.
      WHEN OTHERS.
        ASSERT 1 = 'todo_or_unsupported'.
    ENDCASE.

  ENDMETHOD.


  METHOD traverse_structure.

    DATA lo_structure TYPE REF TO cl_abap_structdescr.
    DATA lt_components TYPE cl_abap_structdescr=>component_table.
    DATA ls_component LIKE LINE OF lt_components.

    lo_structure ?= type.
    lt_components = lo_structure->get_components( ).
    LOOP AT lt_components INTO ls_component.
      result = result && ls_component-name && traverse( ls_component-type ).
    ENDLOOP.

  ENDMETHOD.


  METHOD traverse_table.

    DATA table TYPE REF TO cl_abap_tabledescr.

    table ?= type.

    result = 'table' && traverse( table->get_table_line_type( ) ).

  ENDMETHOD.
ENDCLASS.
