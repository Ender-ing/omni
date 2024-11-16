"use strict";
/**
 *
 * Take care of formatting Omniarium code!
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
exports.OmniariumDocumentFormattingEditProvider = void 0;
// Imports
const vscode = __importStar(require("vscode"));
// Formatter class
class OmniariumDocumentFormattingEditProvider {
    provideDocumentFormattingEdits(document, options, token) {
        // Analyze the code and generate formatting edits
        const edits = this.generateFormattingEdits(document, options);
        // Return the edits
        return edits;
    }
    generateFormattingEdits(document, options) {
        const edits = [];
        // Get basic values & user preferences
        const tab = options.insertSpaces ? " ".repeat(options.tabSize) : "\t";
        // Iterate over all lines using a while loop
        let lineNumber = 0;
        let line = document.lineAt(lineNumber);
        while (line) {
            if (!line.isEmptyOrWhitespace) {
                // Tabs
                const indentEdit = vscode.TextEdit.insert(line.range.start, tab);
                edits.push(indentEdit);
                // To-do:
                // - Remove non-padding extra whitespace
                // - Add lists of symbols that need this padding: "1"
                //   - Remove whitespace before and after dots
                // - Add lists of symbols that need this padding: " 1"
                //   - Add whitespace at the start of opening brackets & remove whitespace at the end of opening brackets
                // - Add lists of symbols that need this padding: "1 "
                //   - Remove whitespace at the start of closing brackets & add whitespace at the end of closing brackets
                //   - Remove whitespace before commas and add whitespace after commas
                // - Add lists of symbols that need this padding: " 1 "
            }
            lineNumber++;
            line = document.lineAt(lineNumber);
        }
        return edits;
    }
}
exports.OmniariumDocumentFormattingEditProvider = OmniariumDocumentFormattingEditProvider;
