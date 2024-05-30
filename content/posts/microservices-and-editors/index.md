+++
title = "Microservices and Editors"
author = ["pspiagicw"]
date = 2022-11-15
tags = ["linux", "emacs", "neovim", "editors"]
categories = ["editors"]
draft = false
summary = "Understand why your editor is so fast (most times)"
+++

When's the last time you looked into how your editor works ?
I don't mean when you downloaded a few extensions and glanced a few themes.

> This article is edited from the original writing.

<!----more-->

> This article tries to contrast the `Microservices` architecture with current editor ecosystem.
  This is not a strict comparison, it is only done to explore how editors work in this day and age.

## Vim anyone ?
Neovim is one such editor I have used in my entire programming journey.
It is not like your standard editor. It is not like any other editors.

But this post is not about neovim, this post is to explore how your editors work.
This post is applicable to most modern editors, including
- Emacs
- Neovim/Vim
- VSCode
- Atom (RIP, you will be missed)
- Helix

## Back to 2015
Consider you are Microsoft, you just released a Open Source editor `Visual Studio Code`.
You are trying to build it's plugin ecosystem from scratch.

Visual Studio Code will be referred as VSCode from now on.

VSCode is not a IDE, it is a editor.
It does not target any specific language/technology.
Thus it needs to fit for all technologies and languages present out there.

Microsoft needed to develop plugins and integrations for all those technologies by themselves.
Atleast for the first few years, until it's adoption goes high.

{{<figure src="https://code.visualstudio.com/assets/docs/editor/extension-marketplace/extensions-view-filter-menu.png" alt="VSCode Plugins" position="center" style="border-radius: 5px;border-width: 20px; border-style: solid; border-color: #ffb86c;">}}

<!-- ![VSCode](https://code.visualstudio.com/assets/docs/editor/extension-marketplace/extensions-view-filter-menu.png) -->
## Enter Microservices
Microsoft had a brilliant idea, why bother implementing intellisense for multiple languages.

#### Why not separate the intellisense from the editor ?

This allows the editor to focus on being a great editor and it only needs to communicate with a external service which handles intellisense.

### Microservices anyone ?
This idea of multiple services working together to complete a application can be though of as `Microservices Architecture`.
The idea that instead of building a web application/server that handles everything, we build small services that excel in handling one single service.

That service can be either authentication or database operations etc.
Every service communicates with each other and each service can be scaled separately.

If you want a more formal introduction, see [here](https://microservices.io).

### Microservices and Editors

Microsoft proposed the Language Server Protocol (LSP), every language will have a associated server.
This server will be responsible for providing language features like formatting, autoimport, autocompletion, documentation etc.
The editor will only need to know which language connects with which server. The server and the client can talk using JSON-RPC protocol.

This idea was proposed to the Open Source Community by Microsoft in 2016. The Open Source community relied on editors like neovim, Emacs, Atom etc.
The Open Source community accepted, thus LSP was born.

This meant all the editors had to build a LSP client which was embedded into the editor. 
Other than that they did not require any effort to support intellisense features.

That responsibility was transferred to the people developing the language or people maintaining the language.

{{<figure src="https://miro.medium.com/max/1838/1*NWvQepJvLQJLZLkLbNnEzA.png" position="center" style="border-style: solid; border-width: 30px; border-color: #ffb86c; border-radius: 5px;">}}
<!-- ![LSP](https://miro.medium.com/max/1838/1*NWvQepJvLQJLZLkLbNnEzA.png) -->

### Six Years Later
Today almost all text editors implement LSP and each language has their well known language server.
When you install a extension for a specific language on VSCode, it only installs a server for that language.
VSCode already knew how to show intellisense features, it just didn't know what to show.

The server starts communicating with VSCode for intellisense and boom!

There is a server for almost all languages. Most modern languages like Go, Rust and TypeScript come with a language server packaged with their compiler/interpreter.

Even COBOL has it's own Language Server.

Some of the popular editors support LSP are
- Emacs
- neovim
- Visual Studio Code
- Helix
- Atom
- Sublime Text

The official LSP documentation can be found [here](https://microsoft.github.io/language-server-protocol/).


## Syntax Highlighting
The second obstacle when designing editors is `Syntax Highlighting`. 
Beginners adore it and pros hate it. But one can't deny it makes code look hot!

But adding syntax highlighting is very heavy on the editor, this results in poor performance when user opens a large project
or file. It also gets in the way of multi-lingual files, such as JSX.

<!-- This problem can only be understood by understanding how syntax highlighting works -->
The reason for this can be understood by diving deep into the workings of Syntax highlighting
Syntax highlighting in most editors is done by regex matching. `regex` here means Regular Expressions.
It is a separate notation for matching sequence of characters.

The study of how to make a regular expression engine and parsing them leads to the complicated theory of automata.
It is quite a difficult task to make a efficient and accurate regex engine and many pre-built implementations exist.
Almost every programming language has a regex matcher in it's standard library.

But regex matching is still quite slow and does not actually highlight syntactically.
You might have encountered this while opening a huge file, it takes a second for the syntax highlighting to appear.

In layman terms, it doesn't understand the code itself, just the characters and words.

Multi-lingual environments, like JSX and Markdown,  present more challenges to regex based syntax highlighting.
These require multiple syntax highlighters in a single file. Which is slow and complex to implement.

{{<figure src="https://raw.githubusercontent.com/ericwbailey/a11y-prism-theme/master/images/a11y-dark.png" position="center" style="border-style: solid; border-width: 20px; border-color: #ffb86c; border-radius: 5px;">}}
<!-- ![Syntax Highlighting](https://raw.githubusercontent.com/ericwbailey/a11y-prism-theme/master/images/a11y-dark.png) -->

### Atom
The Atom developers were facing this exact problem. 
They came up with a solution, why not outsource this syntax highlighting to a service!

The result was tree-sitter, a incremental parsing library.
This is written in C and is blazingly fast, parsing a languages into a syntax tree in milliseconds!

One can simply match highlighting rules to this syntax tree, and voila!

This was again extracted and shared with the Open Source Community.

It might be the only relic left of Atom in modern software world, apart from fucking `Electron`.

*Fun Fact: GitHub uses tree-sitter to syntax highlight code on your repositories!*

### Tree Sitter
Tree Sitter allows for syntax highlighting being provided by a separate service.
In more recent versions it provides indentation support.
Modal editors like neo[vim] can provide text-object support efficiently using treesitter.

Most languages only need to program a parser according to the Tree Sitter specifications and it automatically
builds and compiles the grammar needed for the language.

It's technical details can be found [here](https://tree-sitter.github.io/tree-sitter/).

VSCode does not support Tree Sitter yet, and still follows RegEX. 
But there are proposals to integrate it using extensions and it might be right around the corner.

{{<figure src="https://i.ibb.co/BypQxTB/cmp.png" position="center" style="border-radius: 5px;border-width: 20px; border-style: solid; border-color: #ffb86c;">}}
<!-- ![Tree Sitter](https://i.ibb.co/BypQxTB/cmp.png) -->

## Debugging

Debugging is a different game altogether.Most people already used separate debuggers like `gdb` or `pdb`.
Integrating with editors was also possible due to the awesome design of these first-pary debuggers.

Microsoft saw this and presented a unified communcation layer on top of existing debuggers. This is called `Debug Adapter Protocol`.
With the right UI to present a debugger, debugging without leaving your editor became less of a hassle.

It is quite new and it's adoption is on the way. Currently almost all the modern editors support DAP.
Most languages either come with a DAP enabled debugger or a third-party program provides it.

It's technical details can be found [here](https://microsoft.github.io/debug-adapter-protocol/)

{{<figure src="https://code.visualstudio.com/assets/blogs/2018/08/07/without-DAP.png" position="center" style="border-radius: 5px;border-width: 20px; border-style: solid; border-color: #ffb86c;">}}
<!-- ![DAP](https://code.visualstudio.com/assets/blogs/2018/08/07/without-DAP.png) -->

## Microservices
You must have noticed something, all the features except text editing have been moved out of the editor.

Thus the text editor has been microserviced instead of the previously monolith structure.
This is the reason for the speed modern editors provide, while providing such advanced features.

While this is not a perfect example for a microservice architecture it is not a bad one.

The advantage of all editors built on these principles are
- Better editing functionality
- All editors have same syntax highlighting, intellisense and debugging capabilities.
- Very fast code feedback.
- Easily recover from crashes and errors.
- More fine control over code features.

Gone are the days editors are popular, because of their language support.
Now editors can focus on making text editing efficient and productive.

Language developers can focus on making their language easily written on multiple editors simultaenously.

If you are feeling adventurous, you might wanna try other editors for their editing features.
Here is a list of editors with their editing features you might wanna try out:

! Beware by being adventurous you might be caught in the middle of the [Editor Wars](https://en.wikipedia.org/wiki/Editor_war). Take your next steps very carefully!

- Neo[vim] - Modal editing with Action-Object methodology
- Kakoune/Helix - Modal editing with Object-Action methodology.
- Emacs - Macro editing with lisp based configuration.
- Visual Studio Code - Beginner Friendly, simple text editor for noobs.

# Goodbye!
