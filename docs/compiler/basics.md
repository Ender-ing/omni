# Basics

> [!NOTE]
> Refer to the [syntax documentation](../language/syntax.md#definitions) for definitions and examples!

## Random notes

### transpilation flow

This is the current planned transpilation flow:

1. **Lexical Analysis** (Code -> Tokens): Organises the code into rich tokens.
2. **Syntax Analysis** (Tokens -> Abstract Syntax Tree): Checks for expected sequences of tokens.
3. **Semantic Analysis** (AST -> Annotated AST): Does cross-type checks, filter-checks, linking (names, libraries), etc.
4. **Target Specialisation** (Annotated AST -> Specialised Intermediate Code): Does final filter-checks, injects INI
values, final library checks, etc.
5. **Code Optimisation** (SIC -> SIC): Does optimisation checks (for speed, size, etc.)
6. **Code Generation** (SIC -> Final Target Code): Generates final target code!

> [!NOTE]
> Up until stage 3, all targets will use the output of this process to generate final target code,
> meaning the transpiler will do steps 1 to 3 only once per file! But step 3 may result in more calls
> that may require the transpiler to load new files and perform steps 1-3 on them again!
>
> The transpiler must never needlessly reanalyse the source code more than once! If a step requires reanalysis,
> it should be implemented at a later stage in order to prevent performance issues on transpilation!

The transpiler will be able to run in two modes:

- **Analytical mode**: This is a mode in which the transpiler will only focus on providing information
about the source code, and reporting potential warnings and errors! It will only go through steps 1 to 3,
and it will keep track of the codebase!
- **Transpilation mode**: This is basically the default mode in which the transpiler will go through all
transpilation stages and produce the final desired target code!

> [!NOTE]
> The transpiler will be built to follow the *Language Server Protocol* (LSP)!

### Standard library and libraries

In order to enable smoother and faster code analysis and transpilation, all libraries that are included within the
transpiler by default will be preprocessed! This means that each omni code file will also include another accompanying
file (`*.omni.cache`) that includes the generated *Annotated AST* of the very same file!

> [!NOTE]
> The transpiler's CLI should also have the option to re-preprocess all library files!

In case of user-defined libraries and files, they will naturally always have hash-based `.omni.cache` files that
contain the *Annotated AST*.

> [!NOTE]
> In order to make sure that files that may change frequently are always updated, cache files in
> the `.omni.out/core` folder will a include a hash in their name: `*-[HASH].omni.cache`!
>
> The hash for these files should be generated using a system-function! (like `sha256sum` and `CertUtil -hashfile`)

Of course, whenever the transpiler is updated, the cache files that rely on the old version of the compiler will
be discarded! (this will result in a performance decrease, just as if you've loaded your files for the first time)

### `.omni.out` folder

This folder contains all files generated on transpilation:

- **.omni.out** *(folder)*

  - **\[target_name]** *(folder)*
    Contains all final files for a specific target!

  - **core** *(folder)*
    Contains all procedural files used to represent the logic of the code!
    *(This file is used to generate all final target files, not just one!)*

  - **user.ini** *(file)*
    The final consolidated user INI file - a consolidation of `.omni.ini` and its included files!

  - **info.ini** *(file)*
    The project's info INI file.
    *(This file is used to keep track of transpiler-related values - like the transpiler's version)*

### JS primitive type reference

This Omni code:

```omniarium
my-function (follow integer my-number) {
    my-number = 42;
}

integer test = 10;
my-function (link test);
test; // Value: 42
```

Would translate to the following JavaScript code:

```js
// This class will be defined once if the need for a variable reference arises!
class __OMNI_TYPE_REF {
    constructor(value) {
        this.value = value;
    }
}

function my_function(___VAR_REF_my_number) {
    ___VAR_REF_my_number.value = 42;
}

// If the use of a link/follow or a cede/assume is detected, the initial
// definition of the variable will be that of an "__OMNI_TYPE_REF" object!
let test = new __OMNI_TYPE_REF(10);
my_function(test);
test.value; // Value: 42
```

> [!NOTE]
> Depending on your `.omni.manifest` configurations, the final code may make use of randomised and
> shortened names for the final class/type/var name!
