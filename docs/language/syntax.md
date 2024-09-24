# Syntax

Syntax refers to the rules and structure that govern how code is written. It's the grammar of the
language, dictating the order of elements, keywords, symbols, and punctuation. In order for you to
write Omni code, you must follow the syntax to a tee!

## Definitions

- [**Keywords**](#keywords): Words reserved by the language that have specific meanings or perform
specific actions.
- [**Literals**](#literals): Constant values directly specified in the code.
- [**Identifiers**](#identifiers): Names given to variables, functions, classes, and other elements.
- [**Operators**](#operators): Symbols used to perform operations on values.
- [**Punctuators**](#punctuators): Special symbols used to delimit or separate elements.
- [**Data Types**](#data-types): These define the type of data a variable can hold.
- [**Comments**](#comments): Non-executable sections of code used to explain or document the code.
- [**Whitespace**](#whitespace): Characters like spaces, tabs, and newlines used for formatting.

## Keywords

Omni makes use of a range of keywords witin certain contexts. A keyword may be used for one context,
or more, depending on the contextual indication of the keyword!

### `keyword?`

...

**Example:**

```omni
// Example code!
```

## Literals

...

## Identifiers

...

## Operators

...

## Punctuators

...

## Data Types

...

## Comments

...

## Whitespace

...

## Unicode Character limitations

All unicode characters are permitted within your code, except for some [*Private Use Area (PUA)
characters*](https://en.wikipedia.org/wiki/Private_Use_Areas) (`\uE000` to `\uF8FF`), and characters
used by the target language!

> [!NOTE]
> You will be warned about the use of target-related characters within your code on transpilation!

### `char?`

...

> [!CAUTION]
> If your code is detected to have any of the PUA characters that are in-use by the transpiler
> itself, your build will be failed automatically and you will get error messages about said
> characters!
