MathReduce
----------
**Turn any text field into a calculator**

----

#####Overview

MathReduce is a system-wide Mac OS service that will calculate simple mathematical expressions a chunk of selected text from anywhere in the system.

Just highlight some text and press <kbd>⌘ Command</kbd>-<kbd>⇧ Shift</kbd>-<kbd>M</kbd> to see bits of math replaced with their values.


#####Example
TODO: Animated gif illustrating the process.

Say you've type in the following text in TextEdit, a Gmail message, or maybe Xcode:

* I wonder what the value of 2.5 * (10**5 / sin(1.5) + 2PI) is?

Select the text in question:

* I wonder what the value of <mark>2.5 * (10**5 / sin(1.5) + 2PI)</mark> is?

Press <kbd>⌘ Command</kbd>-<kbd>⇧ Shift</kbd>-<kbd>M</kbd> and the mystery math is replaced with:

* I wonder what the value of 250643.5340249492 is?
  

In additiona to the system-wide keyboard shortcut, MathReduce is also accesible through any application's services menu (assuming there's text selected).

And that's it. In essence, any editable text field in the system becomes a canvas for extracting values from mathematical expressions.

Note some of the neat things in the example above… contants like PI and e are available, as well as trignonometric functions. See the full list of [operators](https://github.com/davedelong/DDMathParser/wiki/Operators) and [functions](https://github.com/davedelong/DDMathParser/wiki/Built-in-Functions) supported by MathReduce's underlying parser.

#####Installation
TODO: A release build with a binary

For now… just build the project in Xcode. This will invoke a script that copies the resulting binary `~/Library/Services` and calls a few additional commands to refresh the system-wide services roster. (However, logging out and logging back in still might be necessary to get math reduce to show up in the services menu and work properly via the shortcut.

If you don't care for the default keyboard shortcut, it's easy to change to your liking via System Preferences --> Keyboard --> Keyboard Shortcuts --> Services.


#####Caveats

The <kbd>⌘ Command</kbd>-<kbd>⇧ Shift</kbd>-<kbd>M</kbd> shortcut is in conflict with a default key combination in Xcode. By default, Xcode uses this as a shortcut to the Debug Menu > Debug Workflow > View Memory command. This key mapping must be cleared in the Xcode preferences in order for MathReduce to work properly inside 

1. Open the preferences window to the "Key Bindings" tab.
2. Search for "view memory" in the key binding search bar.
3. Clear the "key" field for the Debug Workflow > View Memory entry.

Since MathReduce uses the Mac's native services framework, it's only compatible with thext fields that are implemented . Luckily this turns out to be most 


#####Thanks

MathReduce is a very thin wrapper around Dave DeLong's superlative [DDMathParser](https://github.com/davedelong/DDMathParser) library.

