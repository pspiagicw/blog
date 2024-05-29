+++
title = "Tree-Sitting"
authors = ["pspiagicw"]
date = 2024-03-25
tags = ["linux", "emacs", "neovim", "editors"]
categories = ["editors"]
draft = false
+++

This is a post on how I wrote a tree-sitter parser for a new language. and how I integrated it into my editor.

The new language being my toy language, [hotshot](https://github.com/pspiagicw/hotshot).
This language is a LISP-like scripting language.

Here is a snippet of the language:
```scheme
(fn fibonacci (n)
  (cond ((< n 1) 0)
        ((= n 1) 1)
        (true (+ (fibonacci (- n 1))
                 (fibonacci (- n 2))))))

(assert (fibonacci 7) 13 "fibonacci failed")
(assert (fibonacci 10) 55 "fibonacci failed")
```

Notice how the syntax highlighting is pretty shit.

By the end of this post, you will be able to fix just that (Atleast in your editor)

---

Before:
![Before](/images/tree-sitting/before.png)

After:
![After](/images/tree-sitting/after.png)

---

## `Tree-Sitter`

I like using `neovim`.

Editors like `neovim` including `emacs`, `kakoune` and `helix` use the `tree-sitter` library for syntax highlighting.

Developed for the `atom` editor, it's a incremental parsing library that can perform syntax highlighting, indentation and other wizardry.

It is faster and more accurate than the traditional regex-based highlighting/identation.

My previous post on the [composition of editors](https://falconite.xyz/posts/microservices-and-editors/) has more info on it's working.

See the [tree-sitter official docs](https://tree-sitter.github.io/tree-sitter) for complete information.

---

## `Dependencies`

You will need 
- Node (The `docs` mention `v6.0` or higher, but my advice is to use the latest version)

- `tree-sitter-cli`, my advice is to download the latest version from the [release page](https://github.com/tree-sitter/tree-sitter/releases).

You can also install `tree-sitter-cli` from `npm`, and you will have to configure your PATH to include the `node_modules/.bin` directory.

---

## `Getting Started`

- Create a directory called `tree-sitter-hotshot`.
- Inside this directory, create a `grammar.js` file.

You can get started with te following code:
```javascript
// grammar.js 
module.exports = grammar({
    // name of your language
    name: 'hotshot',

    rules: {
        source_file: $ => 'hello'
    }
});
```
---

## `Grammar`

Tree-Sitter grammar works on `rules`. A `rule` in essence is

- A regex to match with text in the source file

- A combination of other rules (More on that later)

- A string to match with text.

Tree-Sitter needs only a single rule `source_file` to declared. 
It will start parsing the source code according to this rule.

*It helps if you are familiar with `BNF` forms or used `ANTLR`/`bison`/`yacc`*

The grammar currently has a single rule, that matches the text `hello`.

Generate the parser by running the following command:

```zsh
tree-sitter generate
```
It should create a shitload of files in the current directory.

You never have to directly interact with these files, tree-sitter manages these for us.

Although these are important files for the future. If you are using `git` add them into the repository.

The important files are
- `grammar.js`
- `package.json`

<!-- ### `package.json` -->
<!---->
<!-- `tree-sitter` should have generated a `package.json` file, in the current directory. -->
<!---->
<!-- Edit the `package.json` file to add the `file-type` field to the `tree-sitter` section. -->
<!---->
<!-- ```json -->
<!-- // other-code -->
<!--   "tree-sitter": [ -->
<!--     { -->
<!--       "scope": "source.hotshot", -->
<!--       "injection-regex": "^hotshot$", // don't forget to add the comma on this line -->
<!--       "file-types": ["ht"] // add this line -->
<!--     } -->
<!-- // other-code -->
<!-- ``` -->
<!---->

---

## `Writing the Grammar`

### `expression`

In my language, most statement returns some value.

It can have a single `string`, `boolean` or `integer` as a statement.

Example 

```scheme
; this is a coment BTW :) ;

"hello world" ; => return "hello world";

69 ; => return 69 ;

true ; => return true ;
```

Let's add support for `integer`, we can add support for other types incrementally.

```javascript
module.exports = grammar({

  name: 'hotshot',

  rules: {
      // Source file has multiple statement
      source_file: $ => repeat($.statement),

      // Statement can have a expression
      statement: $ => choice(
        $.expression,
      ),

      // Expression can have a integer
      expression: $ => choice(
        $.integer,
      ),

      // Regex
      integer: $ => /\d+/
  }
});
```

- Rules are declared  with the syntax `rule_name: $ => <rule-content>`.

- Rules are referenced with syntax `$.<rule-name>`.

The above grammar includes special functions like `repeat` and `choice`.

- `repeat` means the child rule can occur zero or more times.

- `choice` means only one of the child rules will be matched

In essence it means, 

- a `source_file` can have zero or more `statement`.

- a `statement` can be of type `expression`

- a `expression` can be of type `integer`

- a `integer` consists of consecutive one or more digits.

The `integer` rule uses `Regular Expressions`, to declare one or more consecutive digits to be a `integer`.

*If you want to implement rules in `tree-sitter`, you need to be comfortable with `regex`*

---

## `A friendly tip!`

There are multiple times in this post, you will be required to use `tree-sitter` to test and parse source code.

It goes without saying, you need to run `tree-sitter generate` each time, before doing any testing or parsing.

---

### `testing the parser`

We can write a few `hotshot` programs to test if the parsing is accurate.

Save this under `programs/integer.ht`. We will use the `programs` directory to store example files.

```lisp
420

69
```

---

*Tree-Sitter has a full fledged testing framework embedded into it. 
But it's not recommended for beginners. It is also quite not useful for such a small grammar.*

*You can refer it [here](https://tree-sitter.github.io/tree-sitter/creating-parsers#command-test) later*

---

We will be using a simple command to test the parser.

```sh
# Parses all `hotshot` programs and prints only the stats
tree-sitter parse --quiet --stat programs/*.ht
```

To test a single file run

```sh
# Replace `programs/integer.ht` with your file
tree-sitter parse programs/integer.ht
```
It should output 

```scheme
(source_file [0, 0] - [3, 0]
  (statement [0, 0] - [0, 3]
    (expression [0, 0] - [0, 3]
      (integer [0, 0] - [0, 3])))
  (statement [2, 0] - [2, 2]
    (expression [2, 0] - [2, 2]
      (integer [2, 0] - [2, 2]))))
```

You can clearly see the AST built for our language here.

---

### `comments`

We can add support for comments by adding the following rule to the grammar:

```javascript
module.exports = grammar({
    name: 'hotshot',

    extras: $ => [$.comment, /\s/], // Add this line

    rules: {
        source_file: $ => repeat($.statement),

        // ...

        // Add this line
        comment: $ => /;[^;]*;/
   }
});
```

- The `extras` rule is used to specify the tokens that are not part of the syntax tree, but are still important for the parser.

- The `/\s/` means all the whitespace characters like space, tabs and newlines.

`hotshot` supports `inline` comments. Meaning `(+ 1 ;some comments here; 2)` is a valid statement.

That's the reason I have added `comments` to the `extras` field.

If your language integrates comments into the syntax tree, you can add it to the `statement` rule.

---

### `more expressions`

Now that we have added support for `integers` and `comments`, we can add support for `strings` and `booleans`.

```javascript
// ...
      expression: $ => choice(
        $.integer,
        $.boolean,
        $.string
      ),

      integer: $ => /\d+/,

      string: $ => /"[^"]*"/,

      boolean: $ => choice(
        'true',
        'false'
      )
//....
```

Here's a example code that has all types of expressions, along with comments.

```lisp
; this is a comment ;
; programs/data.ht ;

69

"this is a string"

true
false
```

If you run `tree-sitter parse programs/data.ht`. You should get a output like this.

```scheme
(source_file [0, 0] - [9, 0]
 (comments [0, 0] - [0, 21])
 (comments [1, 0] - [1, 20])
 (statement [3, 0] - [3, 2]
   (expression [3, 0] - [3, 2]
     (integer [3, 0] - [3, 2])))
 (statement [5, 0] - [5, 18]
   (expression [5, 0] - [5, 18]
     (string [5, 0] - [5, 18])))
 (statement [7, 0] - [7, 4]
   (expression [7, 0] - [7, 4]
     (boolean [7, 0] - [7, 4])))
 (statement [8, 0] - [8, 5]
   (expression [8, 0] - [8, 5]
     (boolean [8, 0] - [8, 5]))))
```

---

*If comments are not part of the AST, why are they parsed?*

They are parsed because they are still important to the source code.
Features like syntax highlighting and indentation still apply to comments.

---

### `hello-world`

Let's add support for the most overrated program of all time, the `hello-world` program.

```lisp
; programs/hello-world.ht ;
(echo "Hello, World!")

;`echo` is a built-in function in `hotshot`. ;
```

If you run the test before writing the actual rules.

```sh
tree-sitter parse programs/hello-world.ht
```

It gives an error, because we haven't added support for `function calls`.

```scheme
(source_file [0, 0] - [1, 0]
  (ERROR [0, 0] - [0, 21]
    (ERROR [0, 0] - [0, 21])))
programs/hello-world.ht    0.02 ms         909 bytes/ms (ERROR [0, 0] - [0, 21])
```

Function calls in `hotshot` are represented by the following syntax:

```lisp
(function-name arg1 arg2 arg3)
```
Add the following code. It has quite a few rules, but don't fret.

```javascript
// ...
    statement: $ => choice(
      $.expression,
      // Paren statement
      $.sparen
    ),

    // Paren Statement => '(', paren ,')'
    sparen: $ => seq('(', $.paren ,')'),

    paren: $ => choice(
      $.fcall,
    ),

    fcall: $ => seq(field('name', $.fname), repeat(field('argument', $.returnable))),

    returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')')
    ),

    expression: $ => choice(
      $.integer,
      $.boolean,
      $.string,
      $.identifier
    ),

    fname: $ => choice(
      $.identifier
    ),

    identifier: $ => /[a-zA-Z]+/,

    // ...
```
- The above code introduces the tree-sitter function `seq`.

  This dictates a sequence of rules, in a specific order.

- It also has the `field` function. 

  This function tags the child rule with a name, that we can see in the AST.

- The code adds rules for `identifiers` (variables).

- Identifiers are defined as a sequence of one or more alphabets.

---

`returnables` are different from `statements`.

`hotshot` has few statements that aren't supposed to evaluate into values, like function declaration etc.

They will be syntax highlighted differently thus separating them from other expressions is required.

I have made separate rule for those that evaluate to values.

---

```scheme
(source_file [0, 0] - [3, 0]
  (comment [0, 0] - [0, 27])
  (comment [1, 0] - [1, 25])
  (statement [2, 0] - [2, 21]
    (sparen [2, 0] - [2, 21]
      (paren [2, 1] - [2, 20]
        (fcall [2, 1] - [2, 20]
          name: (fname [2, 1] - [2, 5]
            (identifier [2, 1] - [2, 5]))
          argument: (returnable [2, 6] - [2, 20]
            (expression [2, 6] - [2, 20]
              (string [2, 6] - [2, 20]))))))))
```

--- 

If you can see, we have a lot of `psuedo` nodes, like `sparen`, `paren`, `fname`.

In tree-sitter syntax, you can add a `_` in front of a rule to make it a `hidden` rule.

Here's the entire grammar with the hidden rules.

```javascript
module.exports = grammar({

  name: 'hotshot',

  extras: $ => [$.comment, /\s/],

  rules: {
    source_file: $ => repeat($.statement),

    statement: $ => choice(
      $.expression,
      $._sparen
    ),

    _sparen: $ => seq('(', $._paren ,')'),

    _paren: $ => choice(
      $.fcall
    ),

    fcall: $ => seq(field('name', $._fname), repeat(field('argument', $._returnable))),

    _returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')')
    ),

    expression: $ => choice(
      $.integer,
      $.boolean,
      $.string,
      $.identifier
    ),

    _fname: $ => choice(
      $.identifier
    ),

    integer: $ => /\d+/,

    boolean: $ => choice('true', 'false'),

    identifier: $ => /[a-zA-Z]+/,

    string: $ => /"[^"]*"/,

    comment: $ => /;[^;]*;/

  }
});
```

The `hello-world` program should parse much cleanly now.

```scheme
(source_file [0, 0] - [3, 0]
  (comment [0, 0] - [0, 27])
  (comment [1, 0] - [1, 25])
  (statement [2, 0] - [2, 21]
    (fcall [2, 1] - [2, 20]
      name: (identifier [2, 1] - [2, 5])
      argument: (expression [2, 6] - [2, 20]
        (string [2, 6] - [2, 20])))))
```

---

### `let`

Let's examine the `let` statement

```lisp
(let a 1)
```

This statement can be parsed as `(function-call arg1 arg2)`, which is kinda wrong syntax wise.

It's a separate statement altogether, not a function-call. I want it selected and syntax-highlighted as a separate statement.

But if I put `fcall` as a expression, there would no way of differenciating the `let` statement from any other `function call`

It's the reason I added the `returnable` , `sparen` and `paren` rules.

There is way to prevent adding them.

*It's to use precedence in defining rules. 
It tells tree-sitter to give precedence to one kind of statements over another.*

But `precedence` is a big topic and a overkill for such a simple language.

For the `let` statements, add the following code.
```javascript
// ..
    _paren: $ => choice(
      $.fcall, // Don't forget this comma
      $.let // Add this line
    ),

    // rule for 'let' statements.
    let: $ => seq('let', field('name', $.identifier), field('value', $.expression)),
    
    //...
//.. 
```

Write the test program to parse.

```lisp
; programs/variables.ht ;

(let a 1)

(echo a)
```

It should produce the following AST.

```scheme
(source_file [0, 0] - [5, 0]
  (comment [0, 0] - [0, 25])
  (statement [2, 0] - [2, 9]
    (let [2, 1] - [2, 8]
      name: (identifier [2, 5] - [2, 6])
      value: (expression [2, 7] - [2, 8]
        (integer [2, 7] - [2, 8]))))
  (statement [4, 0] - [4, 8]
    (fcall [4, 1] - [4, 7]
      name: (identifier [4, 1] - [4, 5])
      argument: (expression [4, 6] - [4, 7]
        (identifier [4, 6] - [4, 7])))))
```

---

### `control-flow`

Now that we have added support for `let` statements, we can add support for `control-flow` statements.

This includes `if`, `cond` and `while` statements.

We can skim over these quite quickly as they are easy to implement and test.

---

### `if`

`if` statements in `hotshot` have a simple syntax.
Both the `body` and `else` have a single statement.

```scheme
(if condition body-statement else-statement)

; The else part is optional ;
(if condition body-statement)
```

- Test Program

```lisp
; programs/if.ht ;

(if true
  (echo "true")
  (echo "false"))

(if (somefunction) "true")
```

- Code

```javascript
//...
     _paren: $ => choice(
       $.fcall,
       $.let,
       $.if
     ),

     if: $ => seq(
       'if',
       field('condition', $._returnable),
       field('body',$.statement),
       optional(field('else', $.statement)
     )),

    //...

    // If statements can return value, thus add them into returnable
    _returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')'),
      seq('(', $.if , ')')
    ),

    //...

```

- The above code has a new function `optional`.

  This function makes it's argument optional.
  Cause a `if` statement might not have a `else` part.

- Output

```scheme
(source_file [0, 0] - [8, 0]
  (comment [0, 0] - [0, 23])
  (statement [2, 0] - [4, 17]
    (if [2, 1] - [4, 16]
      condition: (expression [2, 4] - [2, 8]
        (boolean [2, 4] - [2, 8]))
      body: (statement [3, 2] - [3, 15]
        (fcall [3, 3] - [3, 14]
          name: (identifier [3, 3] - [3, 7])
          argument: (expression [3, 8] - [3, 14]
            (string [3, 8] - [3, 14]))))
      else: (statement [4, 2] - [4, 16]
        (fcall [4, 3] - [4, 15]
          name: (identifier [4, 3] - [4, 7])
          argument: (expression [4, 8] - [4, 15]
            (string [4, 8] - [4, 15]))))))
  (statement [6, 0] - [6, 26]
    (if [6, 1] - [6, 25]
      condition: (fcall [6, 5] - [6, 17]
        name: (identifier [6, 5] - [6, 17]))
      body: (statement [6, 19] - [6, 25]
        (expression [6, 19] - [6, 25]
          (string [6, 19] - [6, 25]))))))
```

---

### `while`

`while` statements in `hotshot` have the following syntax.

```scheme
(while condition body)
```

- The `body` is a single statement to execute. A `while` statement can return something.


```lisp
; programs/while.ht ;

(while true
    (echo "Infinity!"))

(while isTrue
 (do
  (let isTrue (checkSomething))
  "It's true"))
```

- Code

```javascript
//...
    _paren: $ => choice(
      $.fcall,
      $.let,
      $.if,
      $.while
    ),

    while: $ => seq(
      'while',
      field('condition', $._returnable),
      field('body', $.statement)
    ),

    //...

    // Believe it or not, while statement are returnable
    _returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')'),
      seq('(', $.if , ')'),
      seq('(', $.while , ')')
    ),
```

- Output


```scheme
(source_file [0, 0] - [9, 0]
  (comment [0, 0] - [0, 21])
  (statement [2, 0] - [3, 23]
    (while [2, 1] - [3, 22]
      condition: (expression [2, 7] - [2, 11]
        (boolean [2, 7] - [2, 11]))
      body: (statement [3, 4] - [3, 22]
        (fcall [3, 5] - [3, 21]
          name: (identifier [3, 5] - [3, 9])
          argument: (expression [3, 10] - [3, 21]
            (string [3, 10] - [3, 21]))))))
  (statement [5, 0] - [8, 15]
    (while [5, 1] - [8, 14]
      condition: (expression [5, 7] - [5, 13]
        (identifier [5, 7] - [5, 13]))
      body: (statement [6, 1] - [8, 14]
        (fcall [6, 2] - [8, 13]
          name: (identifier [6, 2] - [6, 4])
          argument: (fcall [7, 3] - [7, 30]
            name: (identifier [7, 3] - [7, 6])
            argument: (expression [7, 7] - [7, 13]
              (identifier [7, 7] - [7, 13]))
            argument: (fcall [7, 15] - [7, 29]
              name: (identifier [7, 15] - [7, 29])))
          argument: (expression [8, 2] - [8, 13]
            (string [8, 2] - [8, 13])))))))
```

---

### `cond`

`cond` is a tricky statement.

It's syntax is this

```scheme
(cond
    (condition1 body1)
    (condition2 body2))
```

- The `condition` is a `returnable` expression. The body is a single `statement`

```lisp
; programs/cond.ht ;

(cond
    ((condition1) "condition1 is true")
    ((condition2) "condition2 is true")
    (true "nothing is true"))
```

- Code

```javascript
//...
    _paren: $ => choice(
      $.fcall,
      $.let,
      $.if,
      $.while,
      $.cond
    ),

    cond: $ => seq('cond', repeat(field('argument', $.carg))),

    carg: $ => seq('(',field('condition', $._returnable), field('body', $.statement), ')'),

    //...

    _returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')'),
      seq('(', $.if , ')'),
      seq('(', $.while , ')'),
      seq('(', $.cond , ')')
    ),

//....
```

- Output

```scheme
(source_file [0, 0] - [7, 0]
  (comment [0, 0] - [0, 20])
  (statement [3, 0] - [6, 29]
    (cond [3, 1] - [6, 28]
      argument: (carg [4, 4] - [4, 39]
        condition: (fcall [4, 6] - [4, 16]
          name: (identifier [4, 6] - [4, 15])
          argument: (expression [4, 15] - [4, 16]
            (integer [4, 15] - [4, 16])))
        (statement [4, 18] - [4, 38]
          (expression [4, 18] - [4, 38]
            (string [4, 18] - [4, 38]))))
      argument: (carg [5, 4] - [5, 39]
        condition: (fcall [5, 6] - [5, 16]
          name: (identifier [5, 6] - [5, 15])
          argument: (expression [5, 15] - [5, 16]
            (integer [5, 15] - [5, 16])))
        (statement [5, 18] - [5, 38]
          (expression [5, 18] - [5, 38]
            (string [5, 18] - [5, 38]))))
      argument: (carg [6, 4] - [6, 28]
        condition: (expression [6, 5] - [6, 9]
          (boolean [6, 5] - [6, 9]))
        (statement [6, 10] - [6, 27]
          (expression [6, 10] - [6, 27]
            (string [6, 10] - [6, 27])))))))
```

---

### `functions`

Now that we have added support for `control-flow` statements, we can add support for function declaration.

This also includes `lambda` functions.

Functions have the following syntax

```scheme
(fn function-name (param1 param2) body)
```

- `function-name` is a `identifier`
- `paramN` is a `identifier`
- `body` is a single statement

Example

```lisp
; programs/functions.ht ;

(fn hello() (echo "Say hello"))

(fn add (x y) (add x y))
```

- Code

```javascript
//...
    _paren: $ => choice(
      $.fcall,
      $.let,
      $.if,
      $.while,
      $.cond,
      $.fdec
    ),

    fdec: $ => seq(
      'fn',
      field('name', $.identifier),
      '(',
      repeat(field('parameter', $.identifier)),
      ')',
      field('body', $.statement),
    ),

//...
```

- Output

```scheme
(source_file [0, 0] - [5, 0]
  (comment [0, 0] - [0, 25])
  (statement [2, 0] - [2, 31]
    (fdec [2, 1] - [2, 30]
      name: (identifier [2, 4] - [2, 9])
      body: (statement [2, 12] - [2, 30]
        (fcall [2, 13] - [2, 29]
          name: (identifier [2, 13] - [2, 17])
          argument: (expression [2, 18] - [2, 29]
            (string [2, 18] - [2, 29]))))))
  (statement [4, 0] - [4, 23]
    (fdec [4, 1] - [4, 22]
      name: (identifier [4, 4] - [4, 7])
      parameter: (identifier [4, 8] - [4, 9])
      parameter: (identifier [4, 10] - [4, 11])
      body: (statement [4, 13] - [4, 22]
        (fcall [4, 14] - [4, 21]
          name: (identifier [4, 14] - [4, 17])
          argument: (expression [4, 18] - [4, 19]
            (identifier [4, 18] - [4, 19]))
          argument: (expression [4, 20] - [4, 21]
            (identifier [4, 20] - [4, 21])))))))
```

---

### `lambda`

`lambda` is a name-less function.

It's main function is to pass it around as a argument, to be used by other functions like `map`, `filter` etc.

You can bind it to a variable, meaning it is a `returnable`.

```lisp
; programs/lambda.ht ;

(lambda () "something")

(lambda (x y) (add x y))

(let a (lambda () "something"))
```

- The code is similar to `fdec`, but excludes the name of the function.
- Also it's a `returnable`, unlike `fdec`.

```javascript
//...
    _paren: $ => choice(
      $.fcall,
      $.let,
      $.if,
      $.while,
      $.cond,
      $.fdec,
      $.lambda
    ),

    lambda: $ => seq(
      'lambda',
      '(',
      repeat(field('argument', $.identifier)),
      ')',
      field('body', $.statement),
    ),


    _returnable: $ => choice(
      $.expression,
      seq('(', $.fcall , ')'),
      seq('(', $.if , ')'),
      seq('(', $.while , ')'),
      seq('(', $.cond , ')'),
      seq('(', $.lambda , ')')
    ),

//...
```

- Output

```scheme
(source_file [0, 0] - [6, 0]
  (comment [0, 0] - [0, 22])
  (statement [3, 0] - [3, 23]
    (lambda [3, 1] - [3, 22]
      body: (statement [3, 11] - [3, 22]
        (expression [3, 11] - [3, 22]
          (string [3, 11] - [3, 22])))))
  (statement [5, 0] - [5, 24]
    (lambda [5, 1] - [5, 23]
      argument: (identifier [5, 9] - [5, 10])
      argument: (identifier [5, 11] - [5, 12])
      body: (statement [5, 14] - [5, 23]
        (fcall [5, 15] - [5, 22]
          name: (identifier [5, 15] - [5, 18])
          argument: (expression [5, 19] - [5, 20]
            (identifier [5, 19] - [5, 20]))
          argument: (expression [5, 21] - [5, 22]
            (identifier [5, 21] - [5, 22])))))))
```

--- 

## `testing`

Ensure all the programs we wrote earlier are still parsing correctly.

```sh
tree-sitter parse --quiet --stat programs/*.ht
```

It should give the following output.

```txt
Total parses: 9; successful parses: 9; failed parses: 0; success percentage: 100.00%; average speed: 6000 bytes/ms
```

---

## `end`

We have successfully implemented the parsing of a LISP-like language. 

Parsing is useless if don't do anything with the AST.

We can implement 
- Syntax Highlighting
- Indentation
- Select parts of code using tree-sitter queries.

But there are some advantages to writing a tree-sitter parser like this.

- You can prototype your own language quickly using `tree-sitter` before writing a handwritten lexer/parser.

- Having syntax highlighting to your custom language is useful while developing a `interpreter` or a `compiler` for it.

BTW [Hotshot's Tree-Sitter](https://github.com/pspiagicw/tree-sitter-hotshot) can be referenced for the entire code.

---

## `next-post`

We will learn how to implement `syntax-highlighting` along with tree-sitter `queries`

We will also see how `nvim-treesitter` works with the `tree-sitter` library.

--- 

## `references`

If want to make anything other than a `toy` langauge refer to these babes below.

- [official tree-sitter docs](https://tree-sitter.github.io/tree-sitter)

  Covers literally everything
- [Ben's Musing](https://siraben.dev/2022/03/01/tree-sitter.html)

  Covers precedence, associativity, actual tree-sitter tests etc.
- [Jonas Hietala](https://www.jonashietala.se/blog/2024/03/19/lets_create_a_tree-sitter_grammar/)

  Covers making custom scanners, embedding tree-sitter etc.

