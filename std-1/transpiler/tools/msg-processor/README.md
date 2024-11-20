# MSG-PROCESSOR

This is a tool that converts the content of the [`/source/messages`](./../../source/messages/) folder into final C++ header files that contain
the final transpiler messages!

> [!NOTE]  
> Should you need to create a new scope for a new part of the transpiler, there is no need to update this tool.
> `MSG-PROCESSOR` dynamically scans the `/source/messages` folder!
>
> You only need to document your new scope (1...Z) here!

## Message types

Transpiler message types are defined inside the [`/source/messages/types.ini`](./../../source/messages/types.ini) file!

```ini
X="Type Name!"
```

> [!NOTE]
> Should you attempt to use a message type that is not included within the types file, `MSG-PROCESSOR` will fail
> to process your messages!

## Expected data format (scope folders)

Each folder inside the `/source/messages` folder should only be named using one character, incrementally!
It is good practice to start with numbers! (If need be, you may turn to the English Alphabet incrementally to name
new scopes)

> [!IMPORTANT]  
> Each scope must contain one `.ini` file, and `.txt` files for its needed message types!
>
> (*Use the `/source/messages/types.ini` file to define new message types!*)

### Inside `.txt` files

```txt
XN000000 ?

```

> [!NOTE]
> In the final output C++ header file, this message would be stored in the constant `_TRANSPILER_MSG_XN000000`

- `X`: The type of the message
  (*Should match the name of the file containing the message*)
  > [!TIP]
  > Check all the currently defined message types in the `types.ini` file inside the `/source/messages` folder
- `N`: The scope of the message
  (*Should match the name of the parent folder contain the message*)
  > [!TIP]
  > Check all the currently [defined scopes in the `/source/messages` folder](./../../source/messages/README.md)
- `000000`: Unique six-digit long ID number that represents the message within the file that contains the message
  (*That means that the ID number should be unique only within the file itself!*)
- `\s`: You must seperate the message code and message text using one whitespace character!
- `?`: Right after the whitespace character, You must start writing the text that will appear to the user!

> [!WARNING]
> You should always end the `.txt` files with a blank newline!

### Inside `.ini` files

```ini
name="MY NAME!"

```

- `name`: The name of the scope of the parent folder containing the file!
  (*lexer, parser, etc.*)

> [!WARNING]
> YOu should always end the `.ini` files with a blank newline!
