# Omniarium

Omniarium is an open-source multi-targeted metaprogramming language whose sole purpose is to enable writing one flexible source-code instance meant to produce ready-for-use high-level code for multiple targets (be it platforms, frameworks, or any of such)!

> [!IMPORTANT]
> This language is still in its basic initial planning phase! Any and all suggestions could help shape and direct this language to be a better aid for your needs, do not hesitate to provide any sort of criticism!

The concept this language replys on is that most programming languages share some core functionalities. The `standard` library will only include the bare minimum functionality that can enable the source code to be compiled to all the supported target lnaguages. Other than the standard library, there will be a collection of community-created libraries for specific use cases!

## Transpiler

Omniarium will need a transpiler, a *source-to-source translator/compiler*, to convert Omniarium code into a targeted programming language.

> [!NOTE]
> The transpiler is yet to be built. As of now, the transpiler is planned to be built using C++. No actual programming will be done until the programing language is thoroughly planned out!

## To-do list

> [!NOTE]
> All of the setups listed below need to be processed on an in-order basis!

- [ ] Language draft
- [ ] Transpiler basic CLI
- [ ] Transpiler
  - [ ] Lexical analysis (Tokenization)
  - [ ] Syntax analysis (Parsing)
  - [ ] Semantic analysis
  - [ ] Intermediate representation (Optional ???)
  - [ ] Code generation
- [ ] VSCode
  - [ ] Make a syntax language file
  - [ ] Add code auto-formatting
  - [ ] Make a basic syntax checker
  - [ ] Allow transpiler communication and debug with VSCode
