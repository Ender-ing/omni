/**
 *
 * This is the ANTLR grammar file for the Omniarium Lexer!
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
fragment STANDARD_NAME_CHARS
    : [a-zA-Z0-9_-]
    ; /* All supported name characters */
fragment DIGIT
    : [0-9]
    ;
fragment EXPONENT
    : ('e' | 'E' ) (SYMBOL_PLUS | SYMBOL_MINUS)? DIGIT+
    ; /* Number exponent syntax */
fragment ESCAPE_SEQUENCE
    : SYMBOL_BACKSLASH [btnfrs"'\\/]
    ; /* All supported string/char escape sequences */

// Comments
COMMENT_BLOCK
    : '/**' .*? '**/' -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */

COMMENT_LINE
    : '//' ~[\r\n]* [\r\n] -> channel(HIDDEN)
    ; /* New lines are only used to mark the end of linear comments */

COMMENT_NODE
    : '<!--' .*? '-->' -> channel(HIDDEN)
    ; /* comments are never processed for code generation */

//// TOKENS

// Literals
LITERAL_EMPTY
    : 'empty' 
    ;

LITERAL_BOOLEAN_TRUE
    : 'true' 
    ;
LITERAL_BOOLEAN_FALSE
    : 'false' 
    ;
LITERAL_BOOLEAN
    : LITERAL_BOOLEAN_TRUE
    | LITERAL_BOOLEAN_FALSE
    ;

LITERAL_NAN
    : 'NaN' 
    ;
LITERAL_INFINITY                                                                // Bad selector
    : SYMBOL_MINUS? 'infinity'
    ;
LITERAL_DECIMAL
    : SYMBOL_MINUS? DIGIT+
    ;
LITERAL_FLOAT
    :   SYMBOL_MINUS? DIGIT+ SYMBOL_DOT DIGIT* EXPONENT?                        // -3.14, 0.1, 2.0e-5
    |   SYMBOL_MINUS? SYMBOL_DOT DIGIT+ EXPONENT?                               // -.14, .5
    |   SYMBOL_MINUS? DIGIT+ EXPONENT                                           // 1e10, -2E-5
    ;
LITERAL_NUMBER
    : LITERAL_NAN
    | LITERAL_INFINITY
    | LITERAL_DECIMAL
    | LITERAL_FLOAT
    ;

LITERAL_STRING                                                                  // Needs further tokenisation
    : SYMBOL_DOUBLE_QUOTE
            ( ESCAPE_SEQUENCE | ~( '\\' | '"' ) )*
        SYMBOL_DOUBLE_QUOTE
    ;
LITERAL_CHAR
    : SYMBOL_SINGLE_QUOTE
            ( ESCAPE_SEQUENCE | ~( '\\' | '\'' ) )*
        SYMBOL_SINGLE_QUOTE
    ;

LITERAL_REGEXP
    : 'rex/' ( ESCAPE_SEQUENCE | ~( '/' ) )* '/'
    ;
LITERAL_MARKDOWN_LAYER                                                          // Needs further tokenisation
    : SYMBOL_MARKDOWN_LAYER_OPEN
            ( ~'<' ~'/' ~'>' )*
        SYMBOL_MARKDOWN_LAYER_CLOSE
    ;
LITERAL_INJECT_QUOTE                                                            // Needs further tokenisation
    : SYMBOL_INJECT_QUOTE_OPEN
            ( '\\{{' | ~'}' ~'}' )*
        SYMBOL_INJECT_QUOTE_CLOSE
    ;

LITERAL
    : LITERAL_BOOLEAN
    | LITERAL_EMPTY
    | LITERAL_NUMBER
    | LITERAL_STRING
    | LITERAL_CHAR
    | LITERAL_REGEXP
    | LITERAL_MARKDOWN_LAYER
    | LITERAL_INJECT_QUOTE
    ;

// Identifiers
IDENTIFIER_PRIMITIVE_TYPE
    : 'byte'
    | 'short'
    | 'integer'
    | 'long'
    | 'float'
    | 'double'
    | 'char'
    | 'boolean'
    ;
IDENTIFIER_PROTOTYPE
    : [A-Z]STANDARD_NAME_CHARS*
    ;
IDENTIFIER_TYPE
    : IDENTIFIER_PRIMITIVE_TYPE
    | IDENTIFIER_PROTOTYPE
    ;
IDENTIFIER_VALUE
    : [a-z]STANDARD_NAME_CHARS*
    ;
IDENTIFIER_FUNCTION
    : [-]STANDARD_NAME_CHARS+
    ;
IDENTIFIER
    : IDENTIFIER_TYPE
    | IDENTIFIER_VALUE
    | IDENTIFIER_FUNCTION
    ;

// Keywords
KEYWORD_IMPORT
    : 'import'
    ;
KEYWORD_FROM
    : 'from'
    ;
KEYWORD_AS
    : 'as'
    ;
KEYWORD_EXPORT
    : 'export' 
    ;
KEYWORD_FILTER
    : 'filter' 
    ;
KEYWORD_IS
    : 'is' 
    ;
KEYWORD_RETURN
    : 'return' 
    ;
KEYWORD_NEW
    : 'new' 
    ;
KEYWORD_SELF
    : 'self' 
    ;
KEYWORD_PROTOTYPES
    : 'prototype' 
    ;
KEYWORD_EXPOSE
    : 'expose' 
    ;
KEYWORD_LOCAL
    : 'local' 
    ;
KEYWORD_DELETE
    : 'delete'
    ;
KEYWORD_CALL
    : 'call' 
    ;
KEYWORD_TRY
    : 'try' 
    ;
KEYWORD_CATCH
    : 'catch' 
    ;
KEYWORD_THROW
    : 'throw' 
    ;
KEYWORD_FOR
    : 'for' 
    ;
KEYWORD_IF
    : 'if' 
    ;
KEYWORD_ELSE
    : 'else' 
    ;
KEYWORD_SWITCH
    : 'switch' 
    ;
KEYWORD_CASE
    : 'case' 
    ;
KEYWORD_DEFAULT
    : 'default' 
    ;
KEYWORD_BREAK
    : 'break' 
    ;
KEYWORD_CONTINUE
    : 'continue' 
    ;
KEYWORD_DO
    : 'do' 
    ;
KEYWORD_WHILE
    : 'while' 
    ;
KEYWORD_FINAL
    : 'final' 
    ;
KEYWORD_INJECT
    : 'inject' 
    ;
KEYWORD_FOLLOW
    : 'follow' 
    ;
KEYWORD_LINK
    : 'link' 
    ;
KEYWORD_ASSUME
    : 'assume' 
    ;
KEYWORD_CEDE
    : 'cede' 
    ;
KEYWORD_CLONE
    : 'clone' 
    ;

// Symbols
SYMBOL_OPEN_BRACE
    : '{' 
    ;
SYMBOL_CLOSE_BRACE
    : '}' 
    ;
SYMBOL_OPEN_PARENTHESIS
    : '(' 
    ;
SYMBOL_CLOSE_PARENTHESIS
    : ')' 
    ;
SYMBOL_OPEN_BRACKET
    : '[' 
    ;
SYMBOL_CLOSE_BRACKET
    : ']' 
    ;
SYMBOL_OPEN_ANGLE
    : '<' 
    ;
SYMBOL_CLOSE_ANGLE
    : '>' 
    ;
SYMBOL_SEMICOLON
    : ';'
    ;
SYMBOL_COLON
    : ':' 
    ;
SYMBOL_COMMA
    : ',' 
    ;
SYMBOL_DOT
    : '.' 
    ;
SYMBOL_EQUAL
    : '=' 
    ;
SYMBOL_NEGATIVE_EQUAL
    : '!=' 
    ;
SYMBOL_GREATER_THAN_OR_EQUAL
    : '>=' 
    ;
SYMBOL_LESS_THAN_OR_EQUAL
    : '<=' 
    ;
SYMBOL_PLUS
    : '+' 
    ;
SYMBOL_MINUS
    : '-' 
    ;
SYMBOL_STAR
    : '*' 
    ;
SYMBOL_SLASH
    : '/' 
    ;
SYMBOL_PERCENT
    : '%' 
    ;
SYMBOL_AND
    : '&&' 
    ;
SYMBOL_OR
    : '||' 
    ;
SYMBOL_NOT
    : '!' 
    ;
SYMBOL_HASH
    : '#' 
    ;
SYMBOL_DOLLAR
    : '$' 
    ;
SYMBOL_QUESTION_MARK
    : '?' 
    ;
SYMBOL_AT
    : '@' 
    ;
SYMBOL_DOUBLE_QUOTE
    : '"' 
    ;
SYMBOL_SINGLE_QUOTE
    : '\'' 
    ;
SYMBOL_BACKSLASH
    : '\\' 
    ;
SYMBOL_UNDERSCORE
    : '_' 
    ;
SYMBOL_MARKDOWN_LAYER_OPEN
    : 'lyr<>'
    ;
SYMBOL_MARKDOWN_LAYER_CLOSE
    : '</>'
    ;
SYMBOL_INJECT_QUOTE_OPEN
    : '{{'
    ;
SYMBOL_INJECT_QUOTE_CLOSE
    : '}}'
    ;
