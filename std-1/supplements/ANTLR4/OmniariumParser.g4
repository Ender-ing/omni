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
    language = Cpp;
}

//// Parser Rules

start
    :
    ; /* This is the start scope! */
