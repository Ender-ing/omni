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
fragment WHITESPACE_NEGATIVE_TEMPLATE_ESCAPE_CLOSING
    : [^ \t\r\n}]
    ;
CHARS_IGNORE_LIST
    : WHITESPACE
            -> channel(HIDDEN)
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
    : ('e' | 'E' ) ('+' | '-')? DIGIT+
    ; /* Number exponent syntax */

// Chars-related
fragment ESCAPE_SEQUENCE
    : '\\' [btnfrs'"`\\/{]
    ; /* Escape characters */

// Comments
COMMENT_BLOCK
    : ';;?' .*? '?;;'
            -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */
COMMENT_LINE
    : ';;' ~[\r\n]* [\r\n]
            -> channel(HIDDEN)
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
    :   '-'? DIGIT+ '.' DIGIT* EXPONENT? // -3.14, 0.1, 2.0e-5, -.14, .5, 3.
    |   '-'? DIGIT* '.' DIGIT+ EXPONENT? // -3.14, 0.1, 2.0e-5, -.14, .5, 3.
    |   '-'? DIGIT+ EXPONENT // 1e10, -2E-5
    ;
LIT_INTEGER
    : '-'? DIGIT+ // -12, 2, 0
    ;

// Char literals
LIT_CHAR
    : '\'' ( ESCAPE_SEQUENCE | ~( '\\' | '\'' ) )'\''
    ; /* Char literals use single quotes, and they only include one char! */
INVALID_LIT_CHAR
    : '\'' ( .*? ) '\''
            {throwOmniError(_TRANSPILER_MSG_E1000001)}
    | '\'' ~( '\'')*? NEWLINE
            {throwOmniError(_TRANSPILER_MSG_E1000002)}
    ; /* Capture invalid chars! (this is done to lessen the number of parser errors!) */
LIT_STRING
    :   '"'
            ( .*? )
        '"'
    ; /* Capture normal strings! */

// String template
LIT_TEMPLATE_STRING_START
    : '`'
            -> pushMode(MODE_TEMPLATE_STRING_CAPTURE)
    ; /* Start capturing template strings */

// String template reference capture
mode MODE_TEMPLATE_STRING_ESCAPE;
    LIT_TEMPLATE_STRING_ESCAPE_START_
        : '{'
        ; /* Start a reference */
    LIT_TEMPLATE_STRING_ESCAPE_CHARS_IGNORE_LIST
        : WHITESPACE
                -> channel(HIDDEN)
        ;
    LIT_TEMPLATE_STRING_CONSTANT_REFERENCE
        : CONSTANT_IDENTIFIER -> pushMode(MODE_TEMPLATE_STRING_ESCAPE_CLOSING)
        ; /* This is done to avoid  */
    LIT_TEMPLATE_STRING_VARIABLE_REFERENCE
        : VARIABLE_IDENTIFIER -> pushMode(MODE_TEMPLATE_STRING_ESCAPE_CLOSING)
        ; /* All variable identifiers must start with a small letter! */
    LIT_TEMPLATE_STRING_ESCAPE_END_
        : '}'
                -> popMode
        ; /* End the escape mode! (in case of an empty escape!) */
    INVALID_TEMPLATE_STRING_CONTENT_ESCAPE_OPENING
        : (WHITESPACE_NEGATIVE_TEMPLATE_ESCAPE_CLOSING)+
                {throwOmniError(_TRANSPILER_MSG_E1000003)}
        ; /* Capture extra/invalid reference escapes */

// String template inner capture
mode MODE_TEMPLATE_STRING_ESCAPE_CLOSING;
    LIT_TEMPLATE_STRING_ESCAPE_CLOSING_CHARS_IGNORE_LIST
        : WHITESPACE
                -> channel(HIDDEN)
        ;
    INVALID_TEMPLATE_STRING_CONTENT_ESCAPE_CLOSING
        : ~( '}' | '`' )+
                {throwOmniError(_TRANSPILER_MSG_E1000003)}
        ; /* Capture extra/invalid reference escapes */
    LIT_TEMPLATE_STRING_ESCAPE_END
        : '}'
                -> popMode, popMode
        ; /* End the escape mode! */
    INVALID_LIT_TEMPLATE_STRING_END_UNCLOSED_ESCAPE
        : '`'
                {throwOmniError(_TRANSPILER_MSG_E1000005)}
                -> popMode, popMode, popMode
        ; /* The end of a template string with an unclosed reference escape */

// String template inner capture
mode MODE_TEMPLATE_STRING_CAPTURE;
    LIT_TEMPLATE_STRING_CONTENT_ESCAPED
        : ESCAPE_SEQUENCE
        ; /* Capture static string content */
    INVALID_LIT_TEMPLATE_STRING_ESCAPE_EMPTY
        : '{' (WHITESPACE)* '}'
                {throwOmniError(_TRANSPILER_MSG_E1000006)}
        ; /* Capture empty reference escapes! */
    LIT_TEMPLATE_STRING_ESCAPE_START
        : '{' -> pushMode(MODE_TEMPLATE_STRING_ESCAPE)
        ; /* Start a reference capture */
    LIT_TEMPLATE_STRING_CONTENT
        : ~( '`' | '{' | '\\' )+
        ; /* Capture static string content */
    LIT_TEMPLATE_STRING_END
        : '`'
                -> popMode
        ; /* End the template mode */

// Symbols
SYM_PLUS
    : '+'
    ; /* Used to operate on all primitive types! */
/*SYM_PARENTHESIS_OPEN
    : '('
    ;
SYM_PARENTHESIS_CLOSE
    : ')'
    ;
SYM_DOT
    : '.'
    ;
SYM_MINUS
    : '-'
    ;
SYM_QUOTE_SINGLE
    : '\''
    ;
SYM_QUOTE_DOUBLE
    : '"'
    ;
SYM_BACKTICK
    : '`'
    ;*/

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
