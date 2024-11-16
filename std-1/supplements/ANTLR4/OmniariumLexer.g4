/**
 *
 * This is the ANTLR grammar file for the Omniarium Lexer!
 *
 * (Only contains finalised implementations!)
 *
**/

lexer grammar OmniariumLexer;


// Whitespace
fragment NEWLINE
    : [\r\n]
    ;
fragment WHITESPACE
    : [ \t\r\n]
    ;

// Naming schemes
fragment STANDARD_IDENTIFIER_CHARS
    : [a-zA-Z0-9_]
    ; /* All supported identifier name characters */

// Comments
COMMENT_BLOCK
    : ';;;' .*? ';;;' -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */
COMMENT_LINE
    : ';;' ~[\r\n]* [\r\n] -> channel(HIDDEN)
    ; /* New lines are only used to mark the end of linear comments */
COMMENT
    : COMMENT_BLOCK
    | COMMENT_LINE
    ; /* All comment-type statements are grouped here */

// Identifiers
FUNCTION_IDENTIFIER
    : '$' (STANDARD_IDENTIFIER_CHARS)+
    ; /* All function identifiers must start with a dollar sign! */
CONSTANT_IDENTIFIER
    : '_' (STANDARD_IDENTIFIER_CHARS)+
    ; /* All constant identifiers must start with an underscore! */
VARIABLE_IDENTIFIER
    : [a-z] (STANDARD_IDENTIFIER_CHARS)*
    ; /* All variable identifiers must start with a small letter! */
VALUE_IDENTIFIER
    : VARIABLE_IDENTIFIER
    | CONSTANT_IDENTIFIER
    ; /* Constants and variables are used interchangeably a lot! */
TYPE_IDENTIFIER
    : [A-Z] (STANDARD_IDENTIFIER_CHARS)*
    ; /* All type identifiers must start with a capital letter! */
IDENTIFIER
    : VALUE_IDENTIFIER
    | TYPE_IDENTIFIER
    | FUNCTION_IDENTIFIER
    ; /* All identifier references */
