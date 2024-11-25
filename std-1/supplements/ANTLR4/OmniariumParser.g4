/**
 *
 * This is the ANTLR grammar file for Omniarium!
 * All syntax and parser rules are defined here.
 *
 * (Only contains finalised implementations!)
 *
 * (ANTLR4: https://github.com/antlr/antlr4/blob/master/doc/lexicon.md#keywords)
 *
**/

parser grammar OmniariumParser;

// Manage options
options {
    tokenVocab=OmniariumLexer;
    language=Cpp;
}

//// Parser Rules

root
    : (expression expression_end)* EOF
    ; /* This is the start scope! */

// Expressions
expression
    : literal // Literal hard-coded values
    | value_identifier // variables and constants
    | maths_expression // maths expressions
    | declare_values_expression // variables/constants definition
    | assign_variable_value_expression // variables value assignment
    | SYM_PARENTHESIS_OPEN expression SYM_PARENTHESIS_CLOSE
    ; /* All supported expressions */
expression_end
    : SYM_SEMICOLON
    // | CHARS_NEWLINE // if this is the end of the current line, you don't need to add a semicolon!
    ; /* Expression end markers */

// Value identifiers
variable_identifier
    : VARIABLE_IDENTIFIER
    ; /* Variables! */
constant_identifier
    : CONSTANT_IDENTIFIER
    ; /* Constants! */
value_identifier
    : variable_identifier
    | constant_identifier
    ; /* Group constants and variables, as they are used interchangeably a lot! */

// Function identifiers
function_identifier
    : FUNCTION_IDENTIFIER
    ; /* Functions! */

// Type identifiers
primitive_type_integer_8
    : TYPE_BYTE
    ;
primitive_type_integer_16
    : TYPE_SHORT
    ;
primitive_type_integer_32
    : TYPE_INTEGER
    ;
primitive_type_integer_64
    : TYPE_LONG
    ;
primitive_type_integer_U8
    : TYPE_UNSIGNED TYPE_BYTE
    ;
primitive_type_integer_U16
    : TYPE_UNSIGNED TYPE_SHORT
    ;
primitive_type_integer_U32
    : TYPE_UNSIGNED
    ;
primitive_type_integer_U64
    : TYPE_UNSIGNED TYPE_LONG
    ;
primitive_type_integer
    : primitive_type_integer_8
    | primitive_type_integer_16
    | primitive_type_integer_32 // Default
    | primitive_type_integer_64
    | primitive_type_integer_U8
    | primitive_type_integer_U16
    | primitive_type_integer_U32
    | primitive_type_integer_U64
    ; /* Group all integer primitives */
primitive_type_float_4
    : TYPE_FLOAT
    ;
primitive_type_float_8
    : TYPE_DOUBLE
    ;
primitive_type_float
    : primitive_type_float_4
    | primitive_type_float_8
    ; /* Group all float primitives */
primitive_type_char
    : TYPE_CHAR
    ; /* Characters */
primitive_type_boolean
    : TYPE_BOOLEAN
    ; /* Booleans */
primitive_type_identifier
    : primitive_type_integer
    | primitive_type_float
    | primitive_type_char
    | primitive_type_boolean
    ; /* Primitive types are the most basic types! */
builtin_type_string
    : TYPE_STRING
    ; /* Strings */
builtin_type_identifier
    : primitive_type_identifier
    | builtin_type_string
    ; /* There are built-in types that are not defined inside any files! */
defined_type_identifier
    : TYPE_IDENTIFIER
    ; /* Typed defined by the user! */
type_identifier
    : defined_type_identifier
    | builtin_type_identifier
    ; /* Group user-defined types and built-in types */

// Null Literal
lit_null
    : LIT_NULL
    ;

// Boolean Literals
lit_boolean_true
    : LIT_BOOLEAN_TRUE
    ; /* True boolean value */
lit_boolean_false
    : LIT_BOOLEAN_FALSE
    ; /* False boolean value */
lit_boolean
    : lit_boolean_true
    | lit_boolean_false
    ; /* group literal boolean values */

// Numeral literals
lit_integer
    : LIT_INTEGER
    ; /* Normal integers */
lit_float
    : LIT_NAN
    | LIT_INFINITY
    | LIT_NEGATIVE_INFINITY
    | LIT_FLOAT
    ; /* Fractions (NaN and infinity are considered fractions) */
lit_numeral
    : lit_integer
    | lit_float
    ; /* Group all numerals */

// Text literals
lit_char
    : LIT_CHAR
    ; /* Single character literals */
lit_string
    : LIT_STRING
    ; /* String literals */
lit_template_string
    :   LIT_TEMPLATE_STRING_START
            (
                LIT_TEMPLATE_STRING_CONTENT |
                LIT_TEMPLATE_STRING_CONTENT_ESCAPED |
                (
                    LIT_TEMPLATE_STRING_ESCAPE_START
                    (LIT_TEMPLATE_STRING_CONSTANT_REFERENCE | LIT_TEMPLATE_STRING_VARIABLE_REFERENCE)
                    LIT_TEMPLATE_STRING_ESCAPE_END
                )
            )*
        LIT_TEMPLATE_STRING_END
    ; /* Template string literals */
lit_text
    : lit_char
    | lit_string
    | lit_template_string
    ; /* Group all text literals */

// Literals
literal
    : lit_null // #NULL
    | lit_boolean // Booleans
    | lit_numeral // Numbers
    | lit_text // text-based
    ; /* Group all literals */

// Values declaration
declare_variable
    : variable_identifier (assign_value_expression)?
    ; /* Variable declaration */
declare_constant
    : constant_identifier (assign_value_expression)
    ; /* Constant declaration */
invalid_declare_constant
    : constant_identifier (assign_value_expression)*
            {throwOmniError(_TRANSPILER_MSG_E2000002_)}
    ; /* Invalid Constant declaration */
declare_value
    : declare_variable
    | declare_constant
    | invalid_declare_constant
    ; /* Value declaration */
declare_values_expression
    :  type_identifier // Data type
        declare_value // First declaration (a must)
        (SYM_COMMA declare_value)* // Extra declarations
    ; /* Group value declarations */

// Value assignment
assign_value_expression
    : SYM_EQUAL expression
    | invalid_assign_value_expression
    ; /* Direct value assignment */
invalid_assign_value_expression
    : SYM_EQUAL ~(SYM_SEMICOLON | SYM_COMMA)* // capture invalid assignment part!
            {throwOmniError(_TRANSPILER_MSG_E2000003_)}
    ; /* Invalid empty direct value assignment */
assign_variable_value_expression
    : variable_identifier assign_value_expression
    | invalid_assign_constant_value_expression
    ; /* Value assignment after initiation */
invalid_assign_constant_value_expression
    : constant_identifier assign_value_expression
            {throwOmniError(_TRANSPILER_MSG_E2000001_)}
    ; /* Invalid value assignment after constant initiation */

// Type casting
type_cast_expression
    : type_identifier
        SYM_PARENTHESIS_OPEN expression SYM_PARENTHESIS_CLOSE // the member that is being casted must be contained!
    ; /* Casting expressions */

// Maths
maths_operable
    : lit_numeral
    | lit_boolean
    | value_identifier // Semantic (type must match the literal members)
    | type_cast_expression // Semantic (type must match the literal members)
    | SYM_PARENTHESIS_OPEN maths_operable SYM_PARENTHESIS_CLOSE
    ; /* Only numeral values and booleans are allowed in maths expressions */
maths_addition_expression
    : maths_operable SYM_PLUS maths_operable
    ; /* Addition */
maths_subtraction_expression
    : maths_operable SYM_MINUS maths_operable
    ; /* Subtraction */
maths_multiplication_expression
    : maths_operable SYM_ASTERISK maths_operable
    ; /* Multiplication */
maths_division_expression
    : maths_operable SYM_FORWARD_SLASH maths_operable
    ; /* Division */
maths_floor_division_expression
    : maths_operable SYM_DOUBLE_FORWARD_SLASH maths_operable
    ; /* Floor division */
maths_modulo_division_expression
    : maths_operable SYM_MODULO maths_operable
    ; /* Modulo division */
maths_power_expression
    : maths_operable SYM_CARET maths_operable
    ; /* Power operation */
maths_root_expression
    : maths_operable SYM_DOUBLE_CARET maths_operable
    ; /* Root operation */
maths_expression
    : maths_addition_expression
    | maths_subtraction_expression
    | maths_multiplication_expression
    | maths_division_expression
    | maths_floor_division_expression
    | maths_modulo_division_expression
    | maths_power_expression
    | maths_root_expression
    ; /* Group all maths expressions */
