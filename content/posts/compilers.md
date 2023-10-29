+++
title = "Compiler"
date = 2022-12-29
author = ["pspiagicw","Kshitiz1403"]
tags = ["compiler","linux", "devops"]
categories = ["linux"]
draft = true
+++

## Chicken and egg

When you look at this photo, you clearly know they are talking about the chicken and the egg problem.
It is pointless to explain the chicken and the egg problem, but what is not pointless is real-world problems that mirrors this.

Some problems in Computer Science that are chicken and egg problems are
- Cyclic Dependencies
- The linux `initramfs`
- The Dyson sphere problem

Another problem that is basically chicken and egg problem is the problem of Compiler development.

When asked how does a compiler written, most will be puzzled, those with rudimentary knowledge will talk in the general sense.
But most will have the question, `how do you write a compiler ?`. For a compiler you need a programming language ? But for the language to run, you need to compile it ?

Therefore the bare truth, is you need a programming language to write a programming language.

## Multiple Runtime Environments

Let's understand this argument in detail.

Assuming you have a Linux system, run 

```sh
cat /bin/python
```
This will print out the binary for Python interpreter. But is the output Python itself ? 
Is the compiler/interpreter the language itself ? 
Many early programmers and coders will make that assumption, the compiler/interpreter itself is the language.

But if you take a deeper look into the development of a compiler, you will understand that the a programming language
is simply the rules and keywords of the language. Just like real world, language is a set of rules with it's words which mean different things in reference to the real world.

English is not the speaker or the listener it is the medium of communication between them. It has it's own rules and words.
Just like real world has dialects and region-specific English, in computer science each programming language might have different compilers/interpeter.

Let's take Python for example. The default implemention of the Python langauge is in `C`. This is commonly callled `cpython`.
But this is not the only implementation. Alternative implementations exist, some of them are
- `Jython`: Implementation of Python in Java. Runs on JVM.
- `IronPython` : Implementation of Python in C#. Runs on top of .NET

What will you name the Python implementation written in Python ?
They have called it `PyPy`, and BTW it is faster than the default implementation of Python!

> `PyPy` is not faster than `cpython` in the traditional sense. It uses tricks like JIT to make it faster.
    These tricks are explained later in the post.

Another great example, especially for cocky web developers is `JavaScript`. You may consider `Deno` and `Bun` as alternative runtime environments for `JS`.
But don't forget `V8` and `SpiderMonkey`. In the early days of web browser development, everybody had their own browser instead of forking `Chromium`.

Internet Explorer had `Jscript`, it could run JavaScript! 

Then microsoft improved it for their old Edge browser, called `Chakra`. 

Mozilla always had a different implementation called `SpiderMonkey`. It is written in Rust, and it is blazingly fast!

Chromium has the most used implementation called `V8`. It is also used in `NodeJS`. 

> Safari uses something else called `JavaScriptCore`.

This is the reason, web developers have to make sure every browser is supported. Because everybody writes their own JavaScript interpreter.

Imagine writing Python to support `Jython`, `Rython`, `IronPython` and `cpython`.

## Interesting Languages

Now that we are a little deep into the compiler world. I would like to show some different and outright weird programming languages.

- `WhiteSpace`
- `Chef`
- `Rockstar`
- `Brainfuck`

## They are everywhere

Let's actually dive into how does a compiler/interpreter work ?

I apologize in advance to irritated programmers and coders, but I have to give an obligatory compiler and interpreter, defition and explanation.

> A compiler is any software which converts a language into another. The only condition being the output language must be lower level than the source language.

> This low-level language will be executed by a machine, virtual or real.

### What do we mean by lower level ?

A lower level means generally less abstractions. By this we mean more machine-dependent code. Most programmers will take assembly or machine code as lower level.
But they are not the only low-level languages, `bytecode` for most VM based languages like `Python`, or `Java`, is also low-level language, albeit not low enough.

### Interpreters

> An interpreter is something which immediately executes a given language.

This statement is not fully applicable to most modern interpeters, but it reflects the soul of every interpreter.

### Transpiler

When the condition of the compiler is broken, the `transpiler` is born.

> The condition: `Convert to a lower-language than the source language.`

### VM based languages.

Today' most popular languages `Java` , `Python` and `JavaScript`, all use VM based execution.In this the interpreter compiles the code into `bytecode`, and a fake machine (packaged with the interpreter itself, executes the code).
This gives it a chance to perform optimizations, caching and remove dead/unused code.

This bytecode is independent of machine, but contain language specific features.
You can actually see the bytecode for yourself.

Using the `dis` module in Python.


For everything to work, it needs 3 parts.

The `lexer`, `parser` and the `backend`.


### `Lexer`

This breaks the input, into tokens (the smallest character/string that can be understood as code).

Let's do a exercise.

`1 + 2 + "JavaScript logic!"`

How many tokens are currently exsting

### `Parser`


### `Backend`

This is where all the magic occurs.


## How to get started with building and learning compilers ?

## How did I get into compilers ?

