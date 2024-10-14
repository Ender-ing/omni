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
    ;

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
LITERAL_EMPTY
    : 'empty' 
    ;
LITERAL_FLOAT  // This might not be working as expected!
    : [0-9]+ '.' [0-9]+
    ;
LITERAL_DECIMAL
    : [0-9]+
    ;
LITERAL_STRING // This might be broken!
    : SYMBOL_DOUBLE_QUOTE
            ( ~["\\] | SYMBOL_BACKSLASH . )*
        SYMBOL_DOUBLE_QUOTE
    ;
LITERAL_CHAR // This might be broken!
    : SYMBOL_SINGLE_QUOTE
            ( ~['\\] | SYMBOL_BACKSLASH . )*
        SYMBOL_SINGLE_QUOTE
    ;
LITERAL
    : LITERAL_BOOLEAN
    | LITERAL_EMPTY
    | LITERAL_DECIMAL
    | LITERAL_FLOAT
    | LITERAL_STRING
    | LITERAL_CHAR
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
