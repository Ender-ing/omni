/**
 * 
 * Take care of Omniarium extension commands!
 * 
**/

// Imports
import * as vscode from 'vscode';

// Message test
export const msg = vscode.commands.registerCommand('omniarium.msg', () => {
    vscode.window.showInformationMessage('Hello World from the Omniarium extension!');
});