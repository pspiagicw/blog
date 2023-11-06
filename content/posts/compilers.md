+++
title = "Compiler"
date = 2022-12-29
author = ["pspiagicw","Kshitiz1403"]
tags = ["compiler","linux", "devops"]
categories = ["linux"]
draft = true
+++

## Chicken and egg

I don't want to be the guy that explains the `Chicken and the Egg` problem, so let's assume you already know what I am talking about.
Let's discuss one such problem, `Compilers`.

<!-- Some problems in STEM that are chicken and egg problems are -->
<!-- - Cyclic Dependencies -->
<!-- - The linux `initramfs` -->
<!-- - The Dyson sphere problem -->
<!---->
<!-- Another problem that is basically chicken and egg problem is the problem of Compiler development. -->
<!-- Another one of the `Chicken and the egg` problem is `Compiler Development`. -->

When asked how is a compiler written, most will be puzzled, those with rudimentary knowledge will wing it.
But most will seriously ponder over the question, `how do you write a compiler ?`. 

Cause for a compiler you need a programming language ? But for the language to run, you need to compile it ?

> Compiler is the most well known `chicken and egg` problem within Computer Science. Some other include
>- Cyclic dependencies. 
>- The Linux boot process.

<!-- Therefore the bare truth, is you need a programming language to write a programming language. -->
So what's the solution ?
It's simple `write a compiler or in this case become a compiler.`

Let me explain.

## Multiple Runtime Environments

Assuming you have a Linux system, run 

```sh
cat /bin/python
```
This will print out the binary for Python interpreter. But what is the output ? 
Is the output `Python` or something else ?

Technically the output is Python as a interpreter not as a language


Many young programmers make the assumption that the compiler/interpreter they use is the language itself.
They can't separate the language from the interpreter/compiler.

But if you take a deeper look into the development of a compiler, you will understand that the programming language
is simply the rules and keywords of the language. Just like real world, language is a set of rules with it's words which mean different things in reference to the real world.

English is not the speaker or the listener it is the medium of communication between them. It has it's own rules and words.
Just like real world has dialects and region-specific English, in computer science each programming language might have different compilers/interpeter.

Let's take Python for example. The default implemention of the Python langauge is in `C`. This is commonly callled `cpython`.
But this is not the only implementation. Alternative implementations exist, some of them are
- `Jython`: Implementation of Python in Java. Runs on JVM.
- `IronPython` : Implementation of Python in C#. Runs on top of .NET

What will you name the Python implementation written in Python ?
It's called `PyPy`, and it is faster than the default implementation of Python!

> `PyPy` is not faster than `cpython` in the traditional sense. It uses tricks like JIT to make it faster.
    These tricks are explained later.

Another great example, especially for cocky web developers is `JavaScript`. You may consider `Deno` and `Bun` as alternative runtime environments for `JS`.
But don't forget `V8` and `SpiderMonkey`.
In the early days of web browser development, everybody had their own browser instead of forking `Chromium`.

Internet Explorer had `Jscript`, it could run JavaScript! (It's a achivement onto itself.)
Then microsoft improved it for their old Edge browser, called `Chakra`. 

Mozilla always had a different implementation called `SpiderMonkey`. It is written in Rust, and it is blazingly fast!

Chromium has the most well known implementation called `V8`. It is used in `NodeJS`.

> When this article was written most browsers are Chromium forks only excluding Firefox. 
Thus technically only 2 implementations survived,
`V8` and `SpiderMonkey`.

> Safari uses something else called `JavaScriptCore`.

This is the reason, web developers have to make sure every browser is supported. Because everybody writes their own JavaScript interpreter.

Imagine writing Python to support `Jython`, `Rython`, `IronPython` and `cpython`.

<!-- ## Interesting Languages -->
<!---->
<!-- Now that we are a little deep into the compiler world. I would like to show some different and outright weird programming languages. -->
<!---->
<!-- - `WhiteSpace` -->
<!-- - `Chef` -->
<!-- - `Rockstar` -->
<!-- - `Brainfuck` -->

## They are everywhere

Let's dive deeper.

!! I apologize in advance to seasoned programmers and coders, but I have to give an obligatory compiler and interpreter, defition and explanation.

> A compiler is any software which converts a language into another. 
The only condition being that the output must be lower level than the source language.


> This low-level language will be executed by a machine, virtual or real.

### What do we mean by lower level ?

A lower level means generally less abstractions. By this we mean more machine-dependent code. Most programmers will take assembly or machine code as lower level.
But they are not the only low-level languages, `bytecode` for most VM based languages like `Python`, or `Java`, is also low-level language, albeit not low enough.

### Interpreters

> An interpreter is something which immediately executes a given language.

This statement is not fully applicable to most modern interpeters, but it reflects the soul of every interpreter.

### VM based languages.

Today' most popular languages `Java` , `Python` and `JavaScript`, all use VM based execution.
In this a compiler compiles the code into `bytecode`, and a fake machine (packaged with the compiler itself, interprets the code).
This gives it a chance to perform optimizations, caching and remove dead/unused code.

This bytecode is independent of machine, but contain language specific features.
You can actually see the bytecode for yourself.

Using the `dis` module in Python.

### Anatomy of a Compiler

Every compiler/interpreter has 3 parts to it!
- `Lexer` -> This takes the raw input and converts the text into a sequence of predefined tokens.
- `Parser` -> This takes the sequence of tokens from the `Lexer` and tries to convert into a AST.
- `Backend` -> This takes the AST given by the `Parser` and performs the `Magic!`

```goat
+---------+         +----------+        +-----------+ 
|  Lexer  |-------> |  Parser  |------> |  Backend  |
+---------+         +----------+        +-----------+
```

#### `Magic!`

This `magic` can be a lot of things.

- For a `interpreter` (Like Bash), this is simply executing the AST as per the given syntax.
- For a `compiler` (Like C), it can spit out machine code.

A compiler obviously performs a lot of optimizations before splitting out this `machine code`. 
Removing dead code, removing redundant loops, initializing constants.

A `hybrid` compiler/interpreter does something unique. These include `Python`, `Java` and `JavaScript`.
It performs the optimizations and compiles the code into a `bytecode`. 
This `bytecode` although low-level than the source can't be executed by the processor. Here the `Virtual Machine` comes into picture.
It is technically a `interpreter`, it interprets the `bytecode` and executes the `psuedo` instructions given in the bytecode.

More complicated designs may exist! But this design is the most popular and works for most cases.

> The field of `Compiler Development` is the most widely studied and highly researched field within Computer Science.
This field had it's boom in the 1970-80s.


