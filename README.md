# Simple Text Editor
A simple text editor class that stores an internal string when instantiated.
This string can be manipulated via formatted input.

## Usage
```bash
# Parses input and prints result of each `print` command on a new line.
$ cat input.txt | ruby main_script.rb
c
y
a

#or

$ ruby main_script.rb input.txt
c
y
a
```

## Design Approach

`main_script.rb` parses the input into command codes ('1', '2', '3', or '4') and their arguments. It then uses a case statement to map the command codes to their respective commands ('append', 'delete', 'print', and 'undo').

In order to make the script easier to reason about and easier to test, I encapsulate all four actions in a service object called `TextEditor`. `TextEditor` uses instance variables to store the text to be manipulated (initially an empty string called `@text`) and the history of executed commands (initially an empty array called `@history`). The four input commands are implemented as four methods in `TextEditor`: `#append`, `#delete`, `#print`, and `#undo`. `main_script.rb` creates an instance of `TextEditor` and calls these four methods on it as appropriate.

The implementations of `#append`, `#delete`, and `#print` are all fairly straightforward; the only thing I'll note is that the parsed arguments that get passed to `#delete` and `#print` need to be `int`s. `#undo` is a bit trickier. To implement `#undo`, I use an array to store the history of executed commands. I treat this array as a stack by only ever calling two methods on it: `#push` and `#pop`. When a method is called that manipulates `@text` (excluding `#undo` since I don't want to undo `#undo`s), I push the *inverse* of its manipulation onto `@history`. For example, if `append('world')` is called, I push `['2', 5]` onto `@history`, where `'2'` represents the 'delete' command, and `5` is the argument I would pass to it (since 'world' is five letters long). This allows me to simply implement `#undo` by popping the latest `@text`-manipulating action off of `@history`, checking its command code, and then calling the appropriate method with the given argument. The catch to this approach is that I don't want the action performed while undoing a previous action to be pushed onto the history stack, since this would result in an infinite loop of an action and its inverse action being performed.

I solve this problem with a keyword argument called `store`. When `store: false` is passed along with the method's usual argument, the performed action will not be stored in `@history`. The `store` argument defaults to `true` so if no value is passed for it, the performed action will be stored. I use a keyword argument here to enhance clarity. It's not obvious from the method names (`#append` and `#delete`) what that second argument is used for, so even though a keyword argument is less terse, it's worth using in this case.
