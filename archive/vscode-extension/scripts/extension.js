"use strict";
/**
 *
 * Start the extension!
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
exports.activate = activate;
// Imports
const vscode = __importStar(require("vscode"));
const commands = __importStar(require("./commands"));
const OmniariumDocumentFormattingEditProvider_1 = require("./OmniariumDocumentFormattingEditProvider");
const edits_1 = require("./edits");
// Activate the extension!
function activate(context) {
    // Register commands!
    context.subscriptions.push(commands.msg);
    // Register code formatter!
    const formatter = new OmniariumDocumentFormattingEditProvider_1.OmniariumDocumentFormattingEditProvider();
    context.subscriptions.push(
    // Register the ".omni" file extension
    vscode.languages.registerDocumentFormattingEditProvider('omni', formatter));
    // Register editor functions
    context.subscriptions.push(
    // Keep track of highlighted text
    edits_1.observeEditorSelectionChange, 
    // Manage live-edits
    edits_1.observeDocumentTextChange);
}
