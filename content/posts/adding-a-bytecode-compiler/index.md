+++
title = "Bytecoding!"
authors = ["pspiagicw"]
date = 2024-07-26
summary = "Experience of adding a bytecode-compiler to my LISP interpreter"
draft = true
+++

After working on `hotshot` on since the last few months, I finally completed writing a bytecode-compiler for it.

In case you aren't familiar, `hotshot` is a LISP language. You can find out more about it [here](https://falconite.xyz/hotshot).
I had already developed a interpreter with extended features. It was time I wrote a bytecode-compiler for it.

## history

`hotshot` is not the first implementation of this language.
This language was born after completion of the book `Writing a Interpreter in Go`. 

The initial implementation was in `Python`. Written in 2020-21.

This implementation was called [boombash](https://github.com/pspiagicw/boombash).
The implementation was a very crude implementation.
- The parsing was practically non-existent.
- The AST was nothing but nested Python lists.
- Written in Python, without any type hints and bug-prone.

I rewrote this project sometime in 2022, with a more robust AST and improved project management.
It was published as [bsharp](https://github.com/pspiagicw/bsharp).
- It is robust and better written.
- It resembles what a modern interpreter might look.
- Even includes thoroughly written documentation and comments.

Finally in the end of 2023, I started writing `hotshot`.
- Written in Go, typed and fast.
- Supports almost all features including imports, tables etc.

## Reference

The biggest reference in writing this project has to be `Writing a Compiler in Go`.
Other books like `Crafting Interpreters` are also useful, but focuses on other elements.

`Crafting Interpreters` is one of the top books for Compilers/Interpreters.
I consider it one of the most well-written books in Computer Science.
But
- Uses C and Java, I don't like/use both.
- It's bytecode compiler is fundamentally different.

'Writing a Compiler in Go' is the obvious reference for me as I not only started with it's predecessor, but use and love the `Go` language.
The `bytecode` shares lot of elements with it, although many differences/deviations are highlighted later.

## bytecode

If you don't know how compilation works, the goal is to convert any programming language into another language with less abstract implementation.

What I mean by that is, the less clear a code is harder it is to execute. 
So the aim is to reduce it to a handful of instructions that don't assume anything.

Let's see an example.

Take this `Python` code snippet.

```python
print(2 + 3 * 5)
```

Most people would guess correctly that it will print `17`.
But in terms of computation we are assuming a lot of concepts.
- We assume that the code will be parsed correctly
- We assume that proper precedence will be used, meaning it will multiply before adding.
- We don't care what kind of encoding is being used for the numbers, will it be `signed` ? or `unsigned` ?
- What's print ? How does it print it ?
- Where will the calculations we stored ? In my RAM ? Or my processors ?
- Will the memory be cleaned after execution ?

When we try to remove each of these assumptions one by one, we make a more verbose/detailed form of the code.
The more detailed we go, more complex it is to understand and write.

> What's the most detailed we can go ?

The most detailed you can go is write binary, but not just any binary. 
It should be according to your Operating System and processor.

But it's easier to not go there.
A form which is somewhat in the middle (or `intermediate`) is called 'IR' (`intermediate Representation`)

IR comes in many forms
- Like an 'AST' (`Abstract Syntax Tree`)
- A form of assembly (Like in `LLVM`)
- A `bytecode` (Like in `Java`)

A `AST` is something that most people would be familiar with, it represents code as a tree.
With instructions as nodes and data as leaves.

For example, for the same expression, here's the AST.

```txt
print
└─ +
   ├─ Integer(2)
   └─ *
      ├─ Integer(3)
      └─ Integer(5)
```

It is intuitive to understand, but kinda expensive to traverse and execute. 
Most production langauges don't go this route as it makes the langauge slow.
But toy langauges and prototype implementations may use it.
This implementation can't catch bugs and can't optimize the code.

So most compilers come to a agreement. 

They compile it to a lower language, meaning a language with much more complex syntax but less assumptions.
It's hard for humans to write and maintain it, but for a compiler it's easy work.

This is either some form of 'Assembly'. 
This assembly is compiled again into binary, but that part is already handled by the people made the processor.

Many form of these assembly exist, some are direct by the company that made the 'processor'.
Or people who don't like the syntax and make another one which is better syntax wise.
You might have heard the `AT&T` syntax or `Intel` syntax, or even better alternate assembly implementations like `fasm`.

`LLVM` is kind of a big businessman that allows you to compile to multiple systems each with a different OS or processor, 
but in return you need to compile your code into `LLVM IR`, it's a kind of assembly made by the `LLVM` library.

`LLVM` is used by a lot of languages, including `C` (clang), `Haskell` and the infamous `Rust`.
`LLVM` is a beast that does lot of things including 'Compiler Passes', 'Optimizations', 'Just in Time Compilation', etc.

You can also go a third route.

Make your custom assembly, which curtails to your language, but instead of compiling that into binary, execute it like a processor would.

That's what languages like `Java`,`Ruby`, `Python`, `Lua` and many others do. That's what `hotshot` does.
This custom assembly is commonly called `bytecode`.
The `bytecode` is executed by a `Virtual Machine`, which you write.
But this gives you a lot of advantages.
- You can make your langauge simple, but still make it less abstract.
- You can make your `bytecode` specialized to your language and it's features.
- You can have alternate implementations that target the same bytecode.
- You can perform optimizations, get insights and detect bugs.

Let me explain the above points.

Most `bytecode` produced by most langauges are quite easy to understand (Although not easy to write).
Here's Python's bytecode, for the same expression `2 + 3 * 5`

> You can get this by using the `dis` module. Find out more [here]().

```
              0 LOAD_CONST               1 (2)
              2 LOAD_CONST               2 (3)
              4 LOAD_CONST               3 (5)
              6 BINARY_MULTIPLY
              7 BINARY_ADD
```

Although you can't understand it you can still read it, it has 3 parts.
- The line number
    ```
                  ...
              --> 0 LOAD_CONST               1 (2)
                  2 LOAD_CONST               2 (3)
                  ...
   ```

- The opcode
    ```
                  ...
                  0 LOAD_CONST <--           1 (2)
                  2 LOAD_CONST               2 (3)
                  ...
    ```
- The argument
    ```
                  ...
                  0 LOAD_CONST           --> 1 (2)
                  2 LOAD_CONST               2 (3)
                  ...
    ```

Some operations might not have argument like `BINARY_ADD`.

Even though this is very human readable, it is faster than a simple interpreter.

BTW it's called `bytecode` is cause the entire thing is encoded as a sequence of bytes.
The entire `bytecode` is just integers which is encoded as bytes, which is very fast to decode by the `Virtual Machines`.

For example, this is what the above bytecode actually looks like 
```
'd\x01}\x00d\x02}\x01d\x03}\x02|\x00|\x01|\x02\x14\x00\x17\x00}\x03d\x00S\x00'
```

Let's finally look at some `hotshot` bytecode. This is again for the same `2 + 3 * 5` expression.

```
╔════════════╗ ┌──────────────────┐
║            ║ │                  │
║ 0. (int 2) ║ │ 00000 PUSH 0     │
║ 1. (int 3) ║ │ 00001 PUSH 1     │
║ 2. (int 5) ║ │ 00002 PUSH 2     │
║            ║ │ 00003 MUL 2      │
║            ║ │ 00004 ADD 2      │
╚════════════╝ │                  │
               └──────────────────┘
```
The box on the left stores the constants and the right one has the bytecode.

You can see almost instructions in my bytecode has an argument. The `hotshot` bytecode has an argument for most instructions.

The instruction itself is represented by the following struct.

```go
type Instruction struct {
    OpCode   int
    Argument int16
}
```

Unlike most `bytecode` hotshot's bytecode has a constant sized argument for every instruction, of size int16.
But like most `bytecode` it is written for a `Stack based VM`.

Without getting into the nitty-gritty details, let's see how optimizations work when compiling bytecode.

```
00000 PUSH 0 (2)
00001 PUSH 1 (3)
00002 PUSH 2 (5)
00003 MUL 2 
00004 ADD 2 
```

In the above bytecode the `PUSH` instruction loads 2 constants (`3` and `5`) and `MUL` instruction multiplies them.
But we can observe that the result of the multiplication doesn't change, inspite of how many times you execute it in your VM.

You can catch this pattern and reduce any arithmetic operation into a pre-computed constant. This results in the below bytecode.

```
00000 PUSH 3 (17)
```

We reduced 4 instructions into 1.

These patterns can be easily identified and used to optimize the bytecode into a more compact form. 
These pattern-matching and optimizing procedure is called a `Compiler Pass`. 
The specific pass I described above is called `Constant Folding`.

Any such passes can be implemented depending on the design of the bytecode. 

For example, here is the bytecode for a `if` statement.

```
╔═══════════════════════╗ ┌──────────────────┐
║                       ║ │                  │
║ 0. (int 2)            ║ │ 00000 PUSH 0     │
║ 1. (int 1)            ║ │ 00001 PUSH 1     │
║ 2. (str 'It's true')  ║ │ 00002 LT 2       │
║ 3. (str 'It's false') ║ │ 00003 JCMP 1     │
║                       ║ │ 00004 PUSH 2     │
║                       ║ │ 00005 JMP 2      │
╚═══════════════════════╝ │ 00006 JT 1       │
                          │ 00007 PUSH 3     │
                          │ 00008 JT 2       │
                          │                  │
                          └──────────────────┘
```

Here there is a `JMP` and `JCMP` instruction.
These instruction cause the `VM` to skip instructions and move back or forward in the bytecode. 
These are essential to implementation of conditional constructs like `if-else`, `cond` and even looping ones like `for` and `while`.

If you look at the bytecode, you can find a `JT` instruction, these serve as `Jump Targets` to the `JMP` and `JCMP` targets.
Meaning if you encounter a `JMP 2` instruction, you jump to the `Jump Target` with the id `2`. 

> `JCMP` only jumps when the value is false. Or else it continues with the next instruction

It is quite obvious this is slower than a snail to execute code.

Everytime you need to jump, you need to perform a linear search (in both directions!) to find the corresponding jump target.

This is done as you can't know beforehand how many instructions to jump.
You can only find that after you have compiled later instructions.
Most languages use `backpatching` to fix this.

`Backpatching` is when you go back and change a instruction after it has been added to the bytecode, all in the same pass.
It is a little hacky and requires a tad bit more effort to implement.

The easier method is to use a compiler pass, which `hotshot` does.
A separate pass goes through the entire bytecode and matches all jumps to their jump targets.
It changes all `jmp` and `jcmp` instructions to have 'number of instructions to skip' as their argument.

This argument is negative to previous instrution and position for the next ones.

Here is the same bytecode with the necessary amends.
We don't remove the `JT` instruction as it can change the number of instructions which is critical to the jump instructions.

```
00000 PUSH 0
00001 PUSH 1
00002 LT 2
00003 JCMP 2
00004 PUSH 2
00005 JMP 2
00006 JT
00007 PUSH 3
00008 JT
```

Other such compiler optimizations can be performed. These include (non-exhaustive)
- Dead code elimination
- Argument mismatch (In function calls)
- Tail call optimizations

> If you compile your language to `LLVM IR`, `LLVM` does all of this for you.

Like I said before, your language can have specialized instructions for your language. 
- Languages like `Java` has bytecode instructions that cater to the more object oriented kind.
`Erlang` has a lot of instructions which are designed for concurrency and parallelism

A side-effect of having a robust bytecode is that other languages can target your bytecode. 

A great example is `Groovy`, `Scala`, `Clojure` all target the JVM. 
Similarly the `BEAM` (designed for the `Erlang` VM) bytecode is very mature and robust. 
Thus languages like `GLEAM` (Released this year), `Elixir`, `Elm` all target `BEAM`.

> Fun Fact: There exists a implementation of Python that targets Java. It's called `Jython`. 
In the same spirit `Rython`(Ruby) also exists.

Lua is one of the most easy language to pick up, it's bytecode is also really robust and mature.
A alternate implementation called `Fennel` exists which targets `Lua 5.0` bytecode.

