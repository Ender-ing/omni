/**
 * 
 * Start the extension!
 * 
**/

// Imports
import * as vscode from 'vscode';
import * as commands from './commands';

// Activate the extension!
export function activate(context: vscode.ExtensionContext) {
    
    // Register commands!
    context.subscriptions.push(commands.msg);
}
