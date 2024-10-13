grammar Omniarium;

////// (ANTLR)

//// Lexer Rules

// Ignore whitespace
WS                                      :
    [ \t\r\n]+ -> skip
    ;

// Comments
COMMENT_BLOCK                           :
    '/**' .*? '**/' -> channel(HIDDEN)
    ;
COMMENT_LINE                            :
    '//' ~[\r\n]* -> channel(HIDDEN)
    ;

// Keywords
KEYWORD_IMPORT                          : 'import' ;
KEYWORD_FROM                            : 'from' ;
KEYWORD_AS                              : 'as' ;
KEYWORD_EXPORT                          : 'export' ;
KEYWORD_FILTER                          : 'filter' ;
KEYWORD_IS                              : 'is' ;
KEYWORD_RETURN                          : 'return' ;
KEYWORD_NEW                             : 'new' ;
KEYWORD_SELF                            : 'self' ;
KEYWORD_PROTOTYPES                      : 'prototype' ;
KEYWORD_EXPOSE                          : 'expose' ;
KEYWORD_LOCAL                           : 'local' ;
KEYWORD_DELETE                          : 'delete';
KEYWORD_CALL                            : 'call' ;
KEYWORD_TRY         	                : 'try' ;
KEYWORD_CATCH                           : 'catch' ;
KEYWORD_THROW                           : 'throw' ;
KEYWORD_FOR                             : 'for' ;
KEYWORD_IF                              : 'if' ;
KEYWORD_ELSE                            : 'else' ;
KEYWORD_SWITCH                          : 'switch' ;
KEYWORD_CASE                            : 'case' ;
KEYWORD_DEFAULT                         : 'default' ;
KEYWORD_BREAK                           : 'break' ;
KEYWORD_CONTINUE                        : 'continue' ;
KEYWORD_DO                              : 'do' ;
KEYWORD_WHILE                           : 'while' ;
KEYWORD_FINAL                           : 'final' ;
KEYWORD_INJECT                          : 'inject' ;
KEYWORD_FOLLOW                          : 'follow' ;
KEYWORD_LINK                            : 'link' ;
KEYWORD_ASSUME                          : 'assume' ;
KEYWORD_CEDE                            : 'cede' ;
KEYWORD_CLONE                           : 'clone' ;

// Symbols
SYMBOL_OPEN_BRACE                       : '{' ;
SYMBOL_CLOSE_BRACE     	                : '}' ;
SYMBOL_OPEN_PARENTHESIS                 : '(' ;
SYMBOL_CLOSE_PARENTHESIS                : ')' ;
SYMBOL_OPEN_BRACKET                     : '[' ;
SYMBOL_CLOSE_BRACKET                    : ']' ;
SYMBOL_OPEN_ANGLE                       : '<' ;
SYMBOL_CLOSE_ANGLE                      : '>' ;
SYMBOL_SEMICOLON                        : ';' ;
SYMBOL_COLON                            : ':' ;
SYMBOL_COMMA                            : ',' ;
SYMBOL_DOT                              : '.' ;
SYMBOL_EQUAL                            : '=' ;
SYMBOL_NEGATIVE_EQUAL                   : '!=' ;
SYMBOL_GREATER_THAN_OR_EQUAL            : '>=' ;
SYMBOL_LESS_THAN_OR_EQUAL               : '<=' ;
SYMBOL_PLUS                             : '+' ;
SYMBOL_MINUS                            : '-' ;
SYMBOL_STAR                             : '*' ;
SYMBOL_SLASH                            : '/' ;
SYMBOL_PERCENT                          : '%' ;
SYMBOL_AND                              : '&&' ;
SYMBOL_OR                               : '||' ;
SYMBOL_NOT                              : '!' ;
SYMBOL_HASH                             : '#' ;
SYMBOL_DOLLAR                           : '$' ;
SYMBOL_QUESTION_MARK                    : '?' ;
SYMBOL_AT                               : '@' ;
SYMBOL_DOUBLE_QUOTE                     : '"' ;
SYMBOL_SINGLE_QUOTE                     : '\'' ;
SYMBOL_BACKSLASH                        : '\\' ;
SYMBOL_UNDERSCORE                       : '_' ;

// Literals
LITERAL_BOOLEAN_TRUE                    : 'true' ;
LITERAL_BOOLEAN_FALSE                   : 'false' ;
LITERAL_EMPTY                           : 'empty' ;
LITERAL_DECIMAL                         :
    [0-9]+
    ;
LITERAL_FLOAT                           :
    [0-9]+ '.' [0-9]+
    ;
LITERAL_STRING                          :
    SYMBOL_DOUBLE_QUOTE
        ( ~[SYMBOL_DOUBLE_QUOTE\\] | SYMBOL_BACKSLASH . )*
    SYMBOL_DOUBLE_QUOTE
    ;
LITERAL_CHAR                            :
    SYMBOL_SINGLE_QUOTE
        ( ~[SYMBOL_SINGLE_QUOTE\\] | SYMBOL_BACKSLASH . )*
    SYMBOL_SINGLE_QUOTE
    ;*/

// Identifiers
IDENTIFIER_PRIMITIVE_TYPE               :
    ('byte'|'short'|'integer'|'long'|'float'|'double'|'char'|'boolean')
    ;
IDENTIFIER_PROTOTYPE                    :
    [A-Z][a-zA-Z0-9_-]*
    ;
IDENTIFIER_TYPE                         :
    (IDENTIFIER_PRIMITIVE_TYPE | IDENTIFIER_PROTOTYPE)
    ;
IDENTIFIER_VALUE                        :
    [a-z][a-zA-Z0-9_-]*
    ;
IDENTIFIER_FUNCTION                     :
    [-][a-zA-Z0-9_-]+
    ;
IDENTIFIER                              :
    (IDENTIFIER_TYPE | IDENTIFIER_VALUE | IDENTIFIER_FUNCTION)
    ;

//// Parser Rules

// Normal scope

sourceScope
    : ( globalRootLevelStatements | sourceRootLevelStatements )*
    ;

// Import scope

importScope
    : ( globalRootLevelStatements | importRootLevelStatements )*
    ;

// Root level statements

globalRootLevelStatements
    : importStatement
    | filterStatement
    | prototypeStatement
    | functionDefinition
    | variableDeclaration SEMI
    ;

sourceRootLevelStatements
    : defaultStatement
    ;

importRootLevelStatements
    : exportStatement
    ;

////////////////////////////////////
// From this point up, you'll only encounter incomplete/incorrect code
////////////////////////////////////

// Import statement

importStatement
    : KEYWORD_IMPORT
        importList
    FROM importPath SYMBOL_SEMICOLON
    ;

importList
    : STAR
    | IDENTIFIER ( KEYWORD_AS IDENTIFIER )? ( SYMBOL_COMMA IDENTIFIER )*
    ;

importPath
    : IDENTIFIER_VALUE ( SYMBOL_DOT IDENTIFIER_VALUE )* 
    ;


exportStatement
    : EXPORT variableDeclaration SEMI
    ;

filterStatement
    : FILTER filterName LBRACE returnStatement RBRACE
    ;

filterName
    : AT IDENTIFIER
    | AT QUESTION_MARK IDENTIFIER
    ;

prototypeStatement
    : PROTOTYPE IDENTIFIER IS ( filterName type ) ( COMMA filterName type )* SEMI
    ;

functionDefinition
    : functionHeader LBRACE ( statement )* RBRACE
    ;

functionHeader
    : functionName LPAREN ( functionParameterList )? RPAREN
    ;

functionName
    : MINUS IDENTIFIER
    ;

functionParameterList
    : functionParameter ( COMMA functionParameter )*
    ;

functionParameter
    : ( FOLLOW | LINK | ASSUME | CEDE )? type IDENTIFIER
    ;

type
    : IDENTIFIER ( LANGLE typeList RANGLE )?
    ;

typeList
    : type ( COMMA type )*
    ;

variableDeclaration
    : type IDENTIFIER ( EQ expression )?
    ;

defaultStatement
    : DEFAULT_FUNC functionCall SEMI
    ;

statement
    : variableDeclaration SEMI
    | assignmentStatement SEMI
    | functionCall SEMI
    | deleteStatement SEMI
    | ifStatement
    | switchStatement
    | forStatement
    | doWhileStatement
    | whileStatement
    | tryCatchStatement
    | injectStatement SEMI
    | block
    ;

assignmentStatement
    : IDENTIFIER EQ expression
    | IDENTIFIER PLUS EQ expression
    ;

functionCall
    : functionName LPAREN ( expressionList )? RPAREN
    ;

deleteStatement
    : DELETE IDENTIFIER
    ;

ifStatement
    : IF LPAREN expression RPAREN statement ( ELSE IF LPAREN expression RPAREN statement )* ( ELSE statement )?
    ;

switchStatement
    : SWITCH LPAREN expression RPAREN LBRACE ( caseStatement )* ( defaultStatement )? RBRACE
    ;

caseStatement
    : CASE expression COLON ( statement )*
    ;

forStatement
    : FOR LPAREN forInit SEMI expression SEMI forUpdate RPAREN statement
    ;

forInit
    : variableDeclaration
    | assignmentStatement
    ;

forUpdate
    : assignmentStatement
    ;

doWhileStatement
    : DO statement WHILE LPAREN expression RPAREN SEMI
    ;

whileStatement
    : WHILE LPAREN expression RPAREN statement
    ;

tryCatchStatement
    : TRY block CATCH LPAREN ERROR IDENTIFIER RPAREN block
    ;

injectStatement
    : INJECT LBRACE .*? RBRACE AS qualifiedName
    ;

block
    : LBRACE ( statement )* RBRACE
    ;

expressionList
    : expression ( COMMA expression )*
    ;

expression
    : primaryExpression ( ( STAR | SLASH | PERCENT ) primaryExpression )*
    | expression ( ( PLUS | MINUS ) expression )*
    | expression ( ( EQEQ | NEQ | GT | LT | GTEQ | LTEQ ) expression )*
    | expression ( ( AND | OR ) expression )*
    | NOT expression
    | filterName expression
    ;

primaryExpression
    : literal
    | IDENTIFIER
    | functionCall
    | LPAREN expression RPAREN
    | qualifiedName
    | newExpression
    | cloneExpression
    ;

literal
    : STRING_LITERAL
    | CHAR_LITERAL
    | NUMBER_LITERAL
    | TRUE
    | FALSE
    | EMPTY
    ;

qualifiedName
    : IDENTIFIER ( DOT IDENTIFIER )*
    ;

newExpression
    : NEW type LPAREN ( expressionList )? RPAREN
    ;

cloneExpression
    : CLONE IDENTIFIER
    ;
