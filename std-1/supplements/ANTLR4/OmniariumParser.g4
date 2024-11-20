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
    : (expression)* EOF
    ; /* This is the start scope! */

// Expressions
expression
    : literal
    ; /* All supported expressions */

// Identifiers
value_identifier
    : VARIABLE_IDENTIFIER
    | CONSTANT_IDENTIFIER
    ; /* Constants and variables are used interchangeably a lot! */

// Numeral literals
lit_integer
    : LIT_INTEGER
    ; /* Normal integers */
lit_float
    : LIT_NAN
    | LIT_INFINITY
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
    : lit_numeral // Numbers
    | lit_text // text-based
    ; /* Group all literals */
