"use strict";
/**
 * 
 * This file is exposed to the parser!
 * (If you need to quickly define custom parser functions and variables, do so here!)
 * 
**/

const throwOmniError = (msg) => { throw new Error("Lexer error: " + msg); };