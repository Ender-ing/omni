/**
 * 
 * Take care of formatting Omniarium code!
 * 
**/

// Imports
import * as vscode from 'vscode';

// Formatter class
export class OmniariumDocumentFormattingEditProvider implements vscode.DocumentFormattingEditProvider {

    provideDocumentFormattingEdits(document: vscode.TextDocument, options: vscode.FormattingOptions,
                                            token: vscode.CancellationToken): vscode.ProviderResult<vscode.TextEdit[]> {

        // Analyze the code and generate formatting edits
        const edits: vscode.TextEdit[] = this.generateFormattingEdits(document, options);

        // Return the edits
        return edits;
    }



    private generateFormattingEdits(document: vscode.TextDocument,
                                    options: vscode.FormattingOptions): vscode.TextEdit[] {
        const edits: vscode.TextEdit[] = [];

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