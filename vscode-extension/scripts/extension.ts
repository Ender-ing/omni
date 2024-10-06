/**
 * 
 * Start the extension!
 * 
**/

// Imports
import * as vscode from 'vscode';
import * as commands from './commands';
import { OmniariumDocumentFormattingEditProvider } from './OmniariumDocumentFormattingEditProvider';
import { observeDocumentTextChange, observeEditorSelectionChange } from './edits';

// Activate the extension!
export function activate(context: vscode.ExtensionContext) {
    
    // Register commands!
    context.subscriptions.push(commands.msg);

    // Register code formatter!
    const formatter = new OmniariumDocumentFormattingEditProvider();
    context.subscriptions.push(
        // Register the ".omni" file extension
        vscode.languages.registerDocumentFormattingEditProvider('omni', formatter)
    );

    // Register editor functions
    context.subscriptions.push(
        // Keep track of highlighted text
        observeEditorSelectionChange,
        // Manage live-edits
        observeDocumentTextChange
    );
}
