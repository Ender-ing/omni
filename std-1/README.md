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
--|--> (VSCode-Project) [Contains an example root project]
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
