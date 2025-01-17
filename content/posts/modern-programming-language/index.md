+++
title = "modern programming languages"
authors = ["pspiagicw"]
date = 2025-01-17
draft = false
summary = "A modern programming language must have these features."
+++

Welcome to my first post of 2025, hopefully quality and frequency of my posts increase.

One thing I hate about modern programming languages are the uncessary bullcrap I have to bother with.
For example, I started from scratch on a new laptop today, I had to install all the compilers/editors I needed.

That's when installing the language compiler/interpreter is not enough. That's where this list comes from.

## batteries included approach

The first few pages of `Head First Python` stresses on the fact that Python comes batteries included, meaning unlike Java or C++, you have all the libraries you need right there with the language.
Most languages are `batteries-included` in similar ways,

But I think we need to update that definition. I have the following proposal.

A modern programming language should have
- A have a language server bundled with it, or atleast easily installed through the language tools.
- A have a formatter included with it.
- A dependency management, most languages have these (`rust` has `Cargo`, `go` has `Go`).
- A build system included with it. It should tighly integrate with the language. Bonus points for VCS hooks.
- A project management system. It should be able to create projects with template code.
- A test runner. It should handle all types of tests including benchmarks and examples.
- A system of installing binary/executable packages easily using the package manager.
- A simple system of publishing any package or binary/executable.
- Keep my home folder clean.

> The following rants only include languages I have worked with. Any other language can just be easily pointed out.

## include a fucking language-server

I installed lua through my package manager, although I know lua is designed as an embedded language, the process of installing the language-server is not easy.
Plus getting it to run on a bare-bones debian installation is quite the struggle.

Including a language-server should be step one in any new language geared to be used seriously.

`Rust` is better, it has to be installed with a simple command, similar thing with `Go`. 
Python falls in a similar category, but with a cruel twist. The language server for Python is written in JavaScript/TypeScript. 

You might guess why that angers me, I need another language for this one to used properly!!!

## most old languages don't have formatters

Most old languages don't have formatters. This is understandable as they were not designed with this collabrative aspect in mind. 
They were designed for corporations by corporations, not for nerds in their bedroom.

But it is time that most languages should have a formatter included with it. 

## dependency management

This is a modern need, with collabrative coding, but most languages mutated for it. 
Most languages either have a included solution or stick to a third-party solution which is tightly integrated.

## build system

This is one quite a peculiar one. Cause most people end up using the build-system in their text editor, or something like `make`.
But adding a built-system integrated with the language, one can utilize the optimizations, `code-gen`, documentation etc elegantly.

This is not something you see often, but dependency-management tools usually bundle this or have it easily pluggable.
It makes it easy for `git hooks` to be integrated.

## project management system

This sounds similar to the above 2 issues, but it simply refers to the creation of template projects. 
This is usually supported by frameworks or plugins. 

## tests need running

Having a testing framework and a beautiful test runner is simply neccessary.
I don't need to fiddle with testing frameworks, I need all the assert variants and I need the test-data shown properly.
It should also include options for integration, fuzzy and benchmark testing. If you have come this far, include a test-coverage scanner.

## binaries and packages

All languages come with a package-manager that can execute binaries or executables, `pip`/`cargo`/`go`/`npm`, all include this feature. 
But some are not up to the mark.

They should have a specified directory where the binaries are installed. 
If dependencies are a thing (for interpreted languages), keep them separate and uninstall them properly.
Should be able to update everything without much problem.

## publishing should be as easy as downloading

Publishing a package online should be a secure and safe, yet easy method. I don't need to install a separate package to publish the package. 
The format for the details of my package shouldn't change suddenly.

## keep my file system clean

Your language doesn't need to keep cache/packages/binaries and other stuff directly in my home folder (Looking at you `Go`!). 
Either hide it using the `.dotfiles` technique or do one better use the fucking `~/.cache`, `~/.config` and `~/.local` folders for once.

# End

I think should would be the end of my rant. Please take above points into consideration while building your next language.
