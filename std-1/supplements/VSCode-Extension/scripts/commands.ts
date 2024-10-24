/**
 * 
 * Take care of Omniarium extension commands!
 * 
**/

// Imports
import * as vscode from "vscode";

// Constants
const DOCS_URL = 'https://docs.ender.ing/docs/omni-std1/intro/';

// Message test
export const msg = vscode.commands.registerCommand('omniarium.docs', () => {
    const url = vscode.Uri.parse(DOCS_URL);
    vscode.env.openExternal(url);
});