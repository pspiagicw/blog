+++
title = "Syntax highlighting for Tree-sitter"
draft = false
author = "pspiagicw"
date = 2024-05-26
summary = "You have a tree-sitter grammar. You just need syntax highlighting."
+++

If you haven't read the previous post, you might wan't to check it out [here](https://falconite.xyz/posts/tree-sitter/).

This post explores how to write tree-sitter queries for a custom grammar and enable syntax highlighting within `Neovim`.
If you don't know how to make a tree-sitter grammar or want a primer, click [here](https://falconite.xyz/posts/tree-sitter/).


> This guide is focused on `Neovim`, you may refer to it for syntax highlighting, but you will have to adapt the neovim configuration part.

## neovim configuration

You can setup neovim to parse your local tree-sitter grammar by adding these line to your config.


```lua
-- Somewhere in you config
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.hotshot = {
    install_info = {
        -- url = "~/code/other-projects/tree-sitter-hotshot",
        url = "<path-to-your-tree-sitter-folder>",
        files = { "src/parser.c" }
    },
    filetype = "ht"
}

-- To add filetype to the extension of `.ht'`
vim.filetype.add({ extension = { ht = 'hotshot' } })
```

After loading the config, you can run this in Neovim.

```vim {linenos=false}
:TSInstall hotshot
```

This would install the corresponding grammar. 

> This doesn't install the tree-sitter queries. 
> It only makes it recognize the grammar.
> We will cover the queries part later in the post.


## tree-sitter queries

Tree-sitter has a excellent querying syntax inspired from `scheme`.
This query syntax is the reason it's as efficient at it's job.
Parsing is of no use without using it for something.

You write the queries inside the `queries` directory inside your `tree-sitter-<language>` directory.
- Inside this directory the `highlights.scm` file provides syntax highlights. 
- Other features like `indentation`/`text-objects` can be defined inside the `queries` directory.

For reference here is how my directory is layed out.

```txt
.
├── bindings
│   ├── c
│   ├── .... (some other files)
│   └── swift
├── grammar.js
├── .... (some other files)
├── programs
│   ├── arithmetic.ht
│   ├── booleans.ht
│   ├── .... (some other files)
│   └── variables.ht
├── queries
│   └── highlights.scm    <== The `highlights.scm`
└── src
    ├── grammar.json
    ├── node-types.json
    ├── parser.c
    └── tree_sitter

11 directories, 31 files

```

In this `highlights.scm` you will write all the queries for highlighting.

To query you use the following syntax.

```scheme
(node-type optional_name: (subquery-to-match) @tag)
```

For example, to match a integer with the tag `number`. You can write

```scheme
;; In 'queries/highlights.scm'
(integer) @number
```
This will match all `integer` rules within your tree-sitter grammar to match with the `@number` tag.

But what are tags ?

---

## Tree-sitter tags

These tags are either user-defined or pre-defined keywords used to mark the query.
These can be later used for any operation on the matching elements.

Or in this case, predefined syntax targets defined by `Neovim` and most editors.

> There are multiple tags predefined by `Neovim`, I haven't found a place where all the tags are defined. These tags are taken from existing langauge queries like `Go`.

---

These queries can also contain multiple matching targets. For example these are the keywords tagged.

```scheme
;; In 'queries/highlights.scm'
[
 "let"
 "while"
 "fn"
 "cond"
 "lambda"
 ] @keyword
```

For matching other simple targets, like `booleans` and `strings`. Here's how you can do that.

```scheme
;; In 'queries/highlights.scm'
(boolean) @constant
(integer) @number
(string) @string
```

For variables, `Neovim` provides 3 targets.
- `@type` for type declarations
- `@function` for function names
- `@property` for classes etc.


For example, for matching the name of a function in a `function call`.
We need to use a subquery to match the `fname` inside a `fcall`.
We optionally provide a name to the query.

```scheme
;; In 'queries/highlights.scm'
(fcall name: (fname) @function)
```
The `fname` rule inside the `fcall` rule is matched and tagged with `@function.`

Accordingly all the other keywords are matched with appropriate tags.


```scheme
;; In 'queries/highlights.scm'
(fcall name: (fname) @function)

(fdec name: (identifier) @function)

(lambda argument: (identifier) @type)

(fdec argument: (identifier) @type)

(let name: (identifier) @property)
```

Other targets like `punctuation` and comments also need to be matched.
Here is the code for matching them.

```scheme
;; In 'queries/highlights.scm'
(comments) @comment

(operator) @operator


")" @punctuation
"(" @punctuation
"{" @punctuation
"}" @punctuation
```

It's all the queries you can write for a small language like `hotshot`. Here's the `highlights.scm` file in it's entirety.

```scheme
;; `queries/highlights.scm`.
(fcall name: (fname) @function)

(fdec name: (identifier) @function)

(lambda argument: (identifier) @type)

(fdec argument: (identifier) @type)

(let name: (identifier) @property)

(boolean) @constant
(integer) @number
(string) @string

[
 "let"
 "while"
 "fn"
 "cond"
 "lambda"
 ] @keyword

(comments) @comment

(operator) @operator


")" @punctuation
"(" @punctuation
"{" @punctuation
"}" @punctuation
```

Now's the time to embed these into `Neovim`.

## Integration with neovim

`Neovim` doesn't support installing queries when you install the `tree-sitter` grammar (Atleast for local installation).
You need to manually `symlink` the queries directory.

```sh
# ln -s ~/.config/nvim/queries/hotshot ~/code/other-projects/tree-sitter-hotshot/queries
$ ln -s ~/.config/nvim/queries/hotshot <your-queries-directory>
```

> You need to make the `~/.config/nvim/queries` directory if it doesn't exist already.

Now the syntax highlighting should work.

## tips and tricks

- You can use `tree-sitter highlight` to test and highlight code while writing the queries.
    
    It requires the `tree-sitter` config to be initialized, but if are developing for a complex language, it is useful.

- Develop the queries incrementally, start with the simple rules and then move to the bigger ones.

    Once you know your editor understands the queries, you can be confident about complex queries.

## help

The documentation for `tree-sitter` is spotty and hard to understand. Here are some references where you might find further help.

- In `neovim`  the `:help treesitter-query` provides with the highlight groups to target (The `@comment` , `@property` tags)

- The official documentation by `tree-sitter`, available [here](https://tree-sitter.github.io/tree-sitter/syntax-highlighting)

- The official tree-sitter grammar for [`Go`](https://github.com/tree-sitter/tree-sitter-go), [`Rust`](https://github.com/tree-sitter/tree-sitter-rust) and [`Python`](https://github.com/tree-sitter/py-tree-sitter).
    These are a little hard to understand but might provide insights into real-world applications.


