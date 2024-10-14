/**
 *
 * This is the ANTLR grammar file for Omniarium!
 * All syntax and parser rules are defined here.
 *
 * (ANTLR: https://github.com/antlr/antlr4/blob/master/doc/lexicon.md#keywords)
 *
**/

parser grammar OmniariumParser;

// Manage options
options {
    tokenVocab=OmniariumLexer;
    language = Java; // Change this to C++ later...
}

//// Parser Rules

start
    : { __RIDE_PARSER_isImportFile() }? importScope
    | { __RIDE_PARSER_isLayerFile() }? layerScope
    | sourceScope
    ;

// Scopes

sourceScope
    : ( globalRootLevelStatements | sourceRootLevelStatements )*
    ; /* This is the scope of your main source file! */

importScope
    : ( globalRootLevelStatements | importRootLevelStatements )*
    ; /* This is the scope of any imported file! */

layerScope                                                                      // Current literal tokenisation needs revision
    : ( layerRootLevelStatements )*
    ; /* This is the scope of a layer file / layer text! */

independentScope
    :
    ; /* This is the scope within curely brackets ({...}) */

injectScope                                                                     // Current literal tokenisation needs revision
    :
    ; /* This is the scope of an inject statement! */

// Root level statements

globalRootLevelStatements
    : COMMENT_BLOCK
    | COMMENT_LINE
    | valueDefinition SYMBOL_SEMICOLON
    //: 'importStatement'
    //| 'filterStatement'
    //| 'prototypeStatement'
    //| 'functionDefinition'
    ;

sourceRootLevelStatements
    : SYMBOL_SEMICOLON
    //: 'defaultStatement'
    ;

importRootLevelStatements
    : SYMBOL_SEMICOLON
    //: 'exportStatement'
    ;

layerRootLevelStatements
    : COMMENT_NODE
    ;

// Values
valueDefinition
    : IDENTIFIER_TYPE IDENTIFIER_VALUE
        ( valueAssignment )?
        ( SYMBOL_COMMA IDENTIFIER_VALUE ( valueAssignment )? )*
    ;

valueAssignment
    : SYMBOL_EQUAL LITERAL
    ;

////////////////////////////////////
// Code Archive!
// From this point up, you'll only encounter incomplete/incorrect code
////////////////////////////////////
/*
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
*/