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
CHARS_IGNORE_LIST
    : WHITESPACE -> channel(HIDDEN)
    ;

// Naming schemes
fragment STANDARD_IDENTIFIER_CHARS
    : [a-zA-Z0-9_]
    ; /* All supported identifier name characters */

// Numbers-related
fragment DIGIT
    : [0-9]
    ; /* Digits! */
fragment EXPONENT
    : ('e' | 'E' ) (SYM_PLUS | SYM_MINUS)? DIGIT+
    ; /* Number exponent syntax */

// Comments
COMMENT_BLOCK
    : ';;?' .*? '?;;' -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */
COMMENT_LINE
    : ';;' ~[\r\n]* [\r\n] -> channel(HIDDEN)
    ; /* New lines are only used to mark the end of linear comments */

// Numerial Literals
LIT_NAN
    : '#NaN'
    ;
LIT_INFINITY
    : '#infinity'
    | '#negative_infinity'
    ;
LIT_FLOAT
    :   SYM_MINUS? DIGIT+ (SYM_DOT) DIGIT* EXPONENT? // -3.14, 0.1, 2.0e-5, -.14, .5, 3.
    |   SYM_MINUS? DIGIT* (SYM_DOT) DIGIT+ EXPONENT? // -3.14, 0.1, 2.0e-5, -.14, .5, 3.
    |   SYM_MINUS? DIGIT+ EXPONENT // 1e10, -2E-5
    ;
LIT_INTEGER
    : SYM_MINUS? DIGIT+ // -12, 2, 0
    ;

// Symbols
SYM_DOT
    : '.'
    ;
SYM_MINUS
    : '-'
    ;
SYM_PLUS
    : '+'
    ;

// Identifiers
FUNCTION_IDENTIFIER
    : '$' (STANDARD_IDENTIFIER_CHARS)+
    ; /* All function identifiers must start with a dollar sign! */
CONSTANT_IDENTIFIER
    : '#' (STANDARD_IDENTIFIER_CHARS)+
    ; /* All constant identifiers must start with a hashtag! */
VARIABLE_IDENTIFIER
    : [a-z] (STANDARD_IDENTIFIER_CHARS)*
    ; /* All variable identifiers must start with a small letter! */
TYPE_IDENTIFIER
    : [A-Z] (STANDARD_IDENTIFIER_CHARS)*
    ; /* All type identifiers must start with a capital letter! */
