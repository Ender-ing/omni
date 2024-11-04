# Omniarium Standard Edition 1.0

This directory contains files related to the approved concepts of the Omniarium Standard Edition, version 1.0!

> [!IMPORTANT]
> Only add (semi-)finalised concepts into this directory!
>
> **No rough drafts are allowed here!**

All finalised aspects of the language are included here!

> [!IMPORTANT]
> Documentation (in <https://docs.ender.ing>) must be written for all changes that occur here!

## Folder Structure

```txt
(std-1)
--> (supplements)
--|--> (ANTLR4) [Contains Lexer and Parser files]
--|--| ...
--|--> (VSCode-Extension) [Contains The standard VSCode extension]
--|--| ...
--|--> (VSCode-Base) [Contains a the base files for all VSCode Omni project]
--|--| ...
--| ...
--> (samples) [Contains folders of either snippets, projects, or libraries]
--|--> (snippet--000000-*)
--|--|--> <file.omni> [By default, all snippets should contain this file!]
--|--| ...
--|--> (project--000000-*)
--|--|--> <file.omni> [...]
--|--| ...
--|--> (library--000000-*)
--|--|--> <file.omni> [...]
--|--| ...
--| [000000 represents a string of numbers, and these numbers must be unique!]
--| ...
...
```

> [!NOTE]
> Should a folder/file name be prefixed with an exclamation mark (`!`),
> that would mean the contents of said folder/file are under modification!

## Plan

- **Lexer and Parser**: Use ANTLR4 to define the grammar of your source language and generate a lexer and parser.
    1. ANTLR4 lexer file
    2. ANTLR4 parser file
- **AST Construction**: The parser constructs a AST representing the syntactic structure of the input code.
- **Semantic Analysis**: Analyze the AST to check for semantic errors, type checking, and other language-specific
    constraints, then generate an *Enriched Typed AST*.
- **Optimization**: Apply various optimization techniques to the *Enriched Typed AST*, such as constant folding,
    dead code elimination, and loop optimization.
- **Target-Specific Code Generation**: For each target language, implement a code generator that traverses the
    *Enriched Typed AST* and generates the corresponding code.
    1. A custom standard code-generation implementation scheme (needed to making this step maintainable and portable)
- **Target-Specific Code Optimization**: Apply target-specific optimizations, such as instruction scheduling and
    register allocation.
