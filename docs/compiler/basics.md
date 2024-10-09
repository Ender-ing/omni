# Basics

> [!NOTE]
> Refer to the [syntax documentation](../language/syntax.md#definitions) for definitions and examples!

## Random notes

### `.omni.out` folder

This folder contains all files generated on transpilation:

- **.omni.out** _(folder)_

  - **\[target_name]** _(folder)_
    Contains all final files for a specific target!

  - **core** _(folder)_
    Contains all procedural files used to represent the logic of the code!

  - **.ini** _(file)_
    The final consolidated .ini file - a consolidation of `.omni.ini` and its included files!

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
