# Transpiler messages

All transpiler messages, no matter the type, are to be stored here in accordance with the
[guidelines of `MSG-PROCESSOR`](./../../tools/msg-processor/README.md)!

> [!NOTE]
> Only messages that are directly related to final user code are included here!

## Message types

- `E`: Error messages
- `W`: Warning messages

> [!IMPORTANT]
> Remember to update this documentation when you add new types to the [`types.ini` file](./types.ini)!

## Message Scopes

- `1`: Lexer messages
- `2`: Parser messages

> [!IMPORTANT]
> Remember to update this documentation when you add new scope folders!

## Message guidelines

- Should you decide that a message is no longer needed, simply change message content text to `?`!
  > [!CAUTION]
  > Never delete unused message codes!
- Should you need to add a new message:
  - If there is a message ID that is not in use, simply replace the message text content (`?`) with your new
    message text!
  - Otherwise, create a new message line with an incremental number ID, relative to the previous message number ID!
