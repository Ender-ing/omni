#Example

```omniarium
/**
 *
 * This is a language syntax draft for Omniarium
 *
**/

// [NOTE] Omniarium is not an independent programming language! It is strictly used to 
// generate high-level code specific to the user's project!

// [NOTE] You may define your own project libraries and import them using the "import" statement!
// To add a path for your library, you may use your project file (.omni.manifest) to include them.

// [NOTE] The "standard" library's only use is to help users generate code for common development
// targets - like plain web, or plain C++.
// You may even make use of the language just to write more memory-conscious code for a specific
// target!

// Definitions:
// root-exclusive: can be used only at the top-level of the code tree!
// code-statement: any code that ends with a semicolon, a code block (scope), or a
// context separation (e.g. && or || conditions)

// Import platform filters
import @web, @java as @android from standard.target;
// Note that the "as" keyword will change the name of the imported component in the generated code!

// All custom libraries can be accessed by starting the package path with the word "library" 
import x, y, z from custom-lib;

// And custom libraries can have inner paths of their own
import Type-X, Type-Y, Type-Z from custom-lib.types;

// [NOTE] "import" statements are root-exclusive!

// All data that is meant to be imported using the "import" statement needs to be exported using
// the "export" statement within the library file!
export Integer a = 0;

// [NOTE] "export" statements are root-exclusive!

// [NOTE] Variables defined in the root-level of the code tree are global variables!
// Global variables are only accessible to the code within the same file, unless they are exported!

// [NOTE] Variables are only accessible to scopes/levels within the same, or a deeper, scope/level

// [NOTE] Variables are automatically freed from memory at the end of the scope/level they were
// defined in!

/**
 *
 * Filters are used to restrict a value's existence within the code tree!
 * Should a filter return a Boolean false state, whatever value or code block that comes
 * after said filter will be replaced with an 'empty' value. ('empty' acts the same as 'null')
 *
**/
filter @my-filter {
    // This filter includes this code if the target is either web or Java!
    @web @android
    return true;
    // else...
    return false;
}

// [NOTE] The symbol "#" is used to access transpiler compile-time values!
// Defined compile-time values are always strings!

// This is another way to implement this filter
filter @my-filter {
    // (not recommended in normal circumstances, only used by the standard library)
    return (#target.is-web == "true" || #target.is-java == "true");
}

// [NOTE] The symbol "$" is used to access user-defined variables (stored in .omni.ini)

// You may use a filter in your project like this!
filter @my-filter {
    // You'd naturally have these values saved in your project's ".omni.ini" file!
    return ($using-subdomain-a == "true" || $using-subdomain-b == "true");
}

// [NOTE] "filter" statements are root-exclusive!

// [NOTE] "filter" statements are only processed at compile-time! Any variables
// used inside the filter's initial definition code block need to be defined at compile-time!

@my-filter
"hiiii";

// [NOTE] You can use filters only at the start of a code-statement

// [NOTE] Your library should be based on one of the available language targets! (like @java or such)
// Should your specific library require the implementation of a new language target (say a new
// programming language), do not mix it with your niche project-specific needs! Make a independent
// custom language target from scratch, then base your library on that language target!

// If you are making a custom target, you may check its name/code!
filter @custom-target {
    // You may pass the custom target name to the transpiler when you build your project!
    // (this code would be used by language-implementation libraries!)
    return (#target.name == "transpiler-target-name");
}

/**
 *
 * The standard library shall include standard types, which can
 * handle all the supported target sources.
 *
 * Notice that an empty Omni code file does not include any types by default!
 * 
 * List of planned types:
 * Numbers: Byte, Short, Integer, Long, Float, Double,
 * Text: String, Char,
 * Bool: Boolean,
 * Error Handling: Error,
 *
**/

// Standard types
import String, Integer from standard.types;

Integer a = 0;
String b = "The value of integer 'a' is '{a}'!";
// The value of the string b should be "The value of integer 'a' is '0'!"
// This is the recommended syntax in order to merge and make variable-dependent strings!
// Note that the curly brackets are respected as variable indicators only on the initial definition!
// You may use the escape character "\{" to prevent the curly brackets from being interpreted as variables!

// You may use the plus operator in order to append values to a stiring!
String c = "hello there!";
c += " I'm here to help you!";

// In your final output, both the following string manipulation methods should be understood to be the same!
"The value of integer 'a' is '{a}'!" ; // This is allowed!
"The value of integer 'a' is '" + a + "'!"; // This is allowed too, but not recommended!
// Allowing the "+" operator to act as a string manipulator is really just made for use within loops and use cases
// that may require modification of an already-existing string!

// Arrays
import Array, Byte, Char from standard.types;

Array<Byte> bytes = new Array<Byte>(10); // a 'Byte' array with 10 items
Array<Byte,> double-bytes = new Array<Byte,>(10, 20); // a 'Byte' matrix with 10 rows and 20 columns

// The 'self' keyword refers to the type of the variable that is being defined!
Array<Byte,> double-bytes-2 = new self(10, 20); // Note that you can use the 'self' keyword to shorten the written code!

/**
 *
 * Filters can be used to write functions that do the same
 * thing on all different compilation targets!
 *
**/
@web
import get-dom-element-by-id, DOM-Element from standard.target.web;
@android
import get-java-element-by-id, Java-View from standard.target.java;

// [NOTE] "Good" Omni Libraries (not source 'implementation') should aim to reduce the need for the user to specify
// a target filter as much as possible! Only the standard library and implementation libraries are meant to make use of
// the source filters and such!
// ideally, a ready-for-use library that is intended to help with a spicific collection of source targets should not
// require the user to make use of any source target filters in their projects!

/**
 *
 * Omni code values are typed, and this can be a problem when dealing with
 * more than one target platform. For that, you may define a type
 * according to the current target platform using filters!
 *
**/

// [NOTE TO SELF] YOU NEED TO RETHINK TYPES AND CLASSES!
// - Must support inheritance to enable more complex logic!
// - Must distinguish between primitive types, and class types!

type My-Type {
    String val;
    Char val2;
    self () {
        // Write code for when this type is defined!
    }
    delete () {
        // Write code for when this type is deleted/freed!
    }
}

// [NOTE] "type" statements are root-exclusive!

// You may define type aliases like this:
// An alias, set by the "is" keyword, does not exist on runtime! It is only processed at as a placeholder
// for the true type!
// You may use aliases with type definitions, variables, constants, and functions!
// [NOTE] The "is" keyword is mainly intended for use within library files!
// It is not recommended to use this keyword in normal project files!
type Elm-Obj is @web DOM-Element, @java Java-View;
// In this case, the first valid type in the list will be used as the 'true type' for the alias
String original-string = "Hi!";
String string-alias is original-string;
String original-function (Integer num) {
    return "My number is '{num}'!"
}
String function-alias (Integer my-number) is original-function; // Note that the alias function input variables' names
                                            // can differ, but their types and other related attributes should
                                            // remain the same!


// Functions!
Elm-Obj get-element (String id) {
    Elm-Obj elm;
    @web
    {
        elm = get-dom-element-by-id(id);
    }
    @android
    {
        // Java code
        // ...
        elm = get-java-element-by-id(id);
        /**
         *
         * You can inject native code into the result of your target platform!
         * (NEVER inject code without a target filter!)
         *
        **/
        inject {
            // you can inject native Java code!
        }
    }
    return elm;
}

// [NOTE] function definitions are root-exclusive!

Integer my-func () {
    // All this code above enables us to use one function
    // to write code for both targets @web and @android
    const Elm-Obj my-elm = get-element("my-id");
    Integer r;

    if (my-elm != empty) {
        r = 0;
    } else {
        r = 1;
    }

    // You can also free variables before the end of the function!
    delete my-elm;

    // Do some other stuff
    // ...

    return r;

    // [NOTE] Global variables are freed when this function is done executing!
}

// Run my-func() on start!
default my-func;

// [NOTE] "default" statement, outside of a switch case, is root-exclusive!
// [NOTE] "default" statement, outside of a switch case, is a one-time use statement!

// You may define a function that doesn't return values as follows
// (notice that the Any & Void types are NOT supported)
empty-func (Integer a) {
    // do something with 'a'...
}

/**
 *
 * By default, any simple standard variable (with a simple standard type) received
 * in a function is duplicated, meaning that the function uses a variable that does
 * not share the same address as the input value!
 * 
 * But custom types and big data types (objects) are not duplicated, unless you indicate so!
 *
**/

add-one (borrow Integer num) {
    // You can borrow the variable itself without causing duplication!
    num++;
    // Note that borrowed variables (a.k.a. non-duplicate variables) are only freed
    // at the end of their original scope!
    // If you try to free the borrowed variable here, this will result in an error!
    delete num; // This will prevent your program from being compiled!
}
Integer test-num;
// The value of 'test-num' should change, because you lent the original variable to the function!
add-one(lend test-num);
// [NOTE] depending on your targeted language, the using of borrowing and lending may result in
// increased memory usage! So use this carefully! (e.g. if you borrow an integer, the final
// JavaScript code variable may hold the value inside an array, depening in the original code)

type Custom-Type {
    // Each type must make use of the 'traits' keyword
    // to define the behaviour of a custom data type and functions!
    traits {
        large-memory-use false; // If this is set to 'true', the variable will never
                                    // be duplicated when passed outside of its creation
                                    // scope, but the user will be required to make use
                                    // of the 'borrow' and 'lend' keywords in order to
                                    // pass this variable to other functions!
                                    // The default value is 'true'!
                                    // This trait can be used on types!
        deprecated false; // If this is set to 'true', the use will be warned when
                        // they used this data type in their code!
                        // The default value is 'false'!
                        // This trait can be used on types and functions!
        library-exclusive false; // If this is set to 'true', the user will be warned that this feature
                                // was intended only for building libraries and such.
                                // The default value is 'false'!
                                // This trait can be used on types and functions!
    }

    // Values used by this type!
    Integer a;

    // Functions that start with the symbol "~" are type event functions!
    // These functions are used to manage the behaviour of the data type!

    // The "self" keyword can be used to manage the element's creation!
    self (Integer a) {
        this.a = a;
    }

    // Take care of deallocating memory!
    delete () {
        delete this.a;
    }

    // Do something when the value of the variable is called!
    call () {
        // If you wish to define a custom behaviour when the value of this type if retrieved,
        // do so here!
    }

    // Define custom behaviour on lending and borrowing
    lend () {
        // ...
    }
    borrow () {
        // ...
    }
}
custom-add-one (Custom-Type obj) {
    obj.a++;
}
Custom-Type test-custom = new Custom-Type(0);
// Normally, the value of an integer inside a custom type should change!
// But because a this data type's "large-memory-use" trait is set to false, the value will not change
// unless it is borrowed!
custom-add-one(test-custom);

// [NOTE] Careful! You can't actually call functions on the root-level of the code tree!
// You need to call functions from within the initial function!

/**
 *
 * Error handling is done using the "try" and "catch" statements!
 *
**/

try {
    // Any errors thrown inside this 'try block' will be caught and handled by
    // the 'catch' block!

    // ...
    throw new Error("My error message!");
} catch (Error e) {
    // handle error!
    // ...
}

// [NOTE] You can't use the "try" and "catch" satements in the root level
// of the code tree!

/**
 *
 * Loops and conditional statements!
 *
**/

for (Integer i = 0; i < 10; i++) {
    // If statement
    if (...) {
        //
        break;
    } else if (...) {
        //
        continue;
    } else {
        //
    }
    // Switch statement
    switch (i) {
        //
        case 1:
            // ..
            break;
        case 2:
            // ..
        default:
            // ..
    }
    // ...
}

do {
    // Run code, then check Boolean value!
    // ...
} while (true);

while (true) {
    // Check Boolean value, then run code!
    // ...
}

// [NOTE] You can't use "for" and "while" loops in the root level
// of the code tree!

// a full code-statement:
// (<Filter...>?) ... ({...}|CONTEXT_SEPARATION|;)

// [NOTE] Tabs, whitespace, and new lines are always ignored while parsing! As such,
// a 'code line' must always end with either a semi-colon (;) or a code block ({...})!
```