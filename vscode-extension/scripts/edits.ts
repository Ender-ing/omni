/**
 * 
 * Take care of live edits!
 * 
**/

// Imports
import * as vscode from 'vscode';

// Tracking variables!
let lastHighlightedText: string;

// Keep track of the last highlight
export const observeEditorSelectionChange = vscode.window.onDidChangeTextEditorSelection(e => {
    const editor = vscode.window.activeTextEditor;
    if (editor) {
        lastHighlightedText = editor.document.getText(e.selections[0]); // Store the primary selection's text
    }
});

// Keep track of document changes!
export const observeDocumentTextChange = vscode.workspace.onDidChangeTextDocument(event => {
    // Only track Omni files!
    if (event.document.languageId === "omniarium") {
        encloseOpenings(event);
    }
});

// Add some DOM delay
function delay(func: Function){
    setTimeout(func, 0);
}

// Handle brackets!
export function encloseOpenings(event: vscode.TextDocumentChangeEvent) {
    const editor = vscode.window.activeTextEditor;
    if (editor && event.contentChanges.length > 0) {
        const change = event.contentChanges[0]; // Assuming single change for simplicity

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
                } else {
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

function getClosingChar(openingChar: string): string {
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