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
    language=Cpp; // change to Cpp
}

//// Parser Rules

root
    : (expression)* EOF
    ; /* This is the start scope! */

// Expressions
expression
    : value_identifier // Tmp
    ; /* All supported expressions */

// Identifiers
value_identifier
    : VARIABLE_IDENTIFIER
    | CONSTANT_IDENTIFIER
    ; /* Constants and variables are used interchangeably a lot! */
