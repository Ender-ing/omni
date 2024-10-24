/**
 *
 * This is the ANTLR grammar file for the Omniarium Lexer!
 *
 * (Only contains finalised implementations!)
 *
**/

lexer grammar OmniariumLexer;


// Basic values
fragment NEWLINE
    : [\r\n]
    ;
fragment WHITESPACE
    : [ \t\r\n]
    ;
