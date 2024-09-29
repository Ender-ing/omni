/**
 * 
 * Start the extension!
 * 
**/

// Imports
import * as vscode from 'vscode';
import * as commands from './commands';
import { OmniariumDocumentFormattingEditProvider } from './OmniariumDocumentFormattingEditProvider';

// Activate the extension!
export function activate(context: vscode.ExtensionContext) {
    
    // Register commands!
    context.subscriptions.push(commands.msg);

    // Code Formatting!
    const formatter = new OmniariumDocumentFormattingEditProvider();
    context.subscriptions.push(
        vscode.languages.registerDocumentFormattingEditProvider('omni', formatter)
    );
}