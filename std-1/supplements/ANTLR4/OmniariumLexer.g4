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

// Comments
COMMENT_BLOCK
    : '/*' .*? '*/' -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */

COMMENT_LINE
    : '//' ~[\r\n]* [\r\n] -> channel(HIDDEN)
    ; /* New lines are only used to mark the end of linear comments */

COMMENT
    : COMMENT_BLOCK
    | COMMENT_LINE
    ; /* All comment-type statements are grouped here */
