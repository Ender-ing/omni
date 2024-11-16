"use strict";
/**
 *
 * Take care of live edits!
 *
**/
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.observeDocumentTextChange = exports.observeEditorSelectionChange = void 0;
exports.encloseOpenings = encloseOpenings;
// Imports
const vscode = __importStar(require("vscode"));
// Tracking variables!
let lastHighlightedText;
// Keep track of the last highlight
exports.observeEditorSelectionChange = vscode.window.onDidChangeTextEditorSelection(e => {
    const editor = vscode.window.activeTextEditor;
    if (editor) {
        lastHighlightedText = editor.document.getText(e.selections[0]); // Store the primary selection's text
    }
});
// Keep track of document changes!
exports.observeDocumentTextChange = vscode.workspace.onDidChangeTextDocument(event => {
    // Only track Omni files!
    if (event.document.languageId === "omniarium") {
        encloseOpenings(event);
    }
});
// Add some DOM delay
function delay(func) {
    setTimeout(func, 0);
}
// Handle brackets!
function encloseOpenings(event) {
    const editor = vscode.window.activeTextEditor;
    if (editor && event.contentChanges.length > 0) {
        const change = event.contentChanges[0]; // Assuming single change for simplicity
        // ^^ Uhhh, you need to take care of that... ^^
        // Check if the change is an insertion of an opening bracket/quote
        const openingChars = ['{', '(', '<', '[']; // Customize as needed
        if (change.text.length === 1 && openingChars.includes(change.text)) {
            const selection = editor.selection;
            // const position = selection.active; // Get current cursor position
            const closingChar = getClosingChar(change.text); // Get corresponding closing char
            editor.edit(editBuilder => {
                // Ensure there's an active selection
                if (!selection.isEmpty) {
                    editBuilder.insert(selection.start.translate(0, 1), lastHighlightedText + closingChar);
                    // Adjust selection to be inside the brackets/quotes
                    delay(() => editor.selection =
                        new vscode.Selection(selection.start.translate(0, 1), selection.end.translate(0, 1)));
                }
                else {
                    // Add ending
                    const newPosition = selection.end.translate(0, 1);
                    editBuilder.insert(newPosition, closingChar);
                    // Adjust selection to be inside the brackets/quotes
                    delay(() => editor.selection = new vscode.Selection(newPosition, newPosition));
                }
            });
        }
    }
}
function getClosingChar(openingChar) {
    switch (openingChar) {
        case '{':
            return '}';
        case '(':
            return ')';
        case '<':
            return '>';
        case '[':
            return ']';
        case '"':
            return '"';
        case '\'':
            return '\'';
        default:
            return '';
    }
}
