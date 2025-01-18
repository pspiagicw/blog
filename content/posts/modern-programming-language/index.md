+++
title = "Modern Programming Languages"
authors = ["pspiagicw"]
date = 2025-01-17
draft = false
summary = "A modern programming language must have these features."
+++

Welcome to my first post of 2025! Hopefully, the quality and frequency of my posts will improve this year.

One thing I hate about modern programming languages is the unnecessary complications they bring.  
For example, I started fresh on a new laptop today, and I had to install all the compilers and editors I needed.  
This got me thinking: why is installing a language's compiler or interpreter not enough?  

That's where this list comes from—essential features every modern programming language should have.

## Batteries-Included Approach

The first few pages of *Head First Python* stress the idea that Python is "batteries included," meaning it provides many libraries out of the box.  
Most modern languages follow a similar philosophy, but I believe we need to expand the definition.

Here’s my proposal for what "batteries included" should mean in 2025:

- A bundled or easily installable language server.
- A built-in code formatter.
- Dependency management (like `Cargo` for Rust or `go` for Go).
- An integrated build system that tightly aligns with the language, with bonus points for VCS hooks.
- A project management system to create templates with starter code.
- A test runner that handles all types of tests, including benchmarks and examples.
- A package manager that supports installing and managing binaries or executables.
- A straightforward, secure system for publishing packages or binaries.
- A filesystem structure that keeps my home folder clean.


> The following rants are limited to languages I’ve worked with. Other languages may have similar flaws.

## Include a Proper Language Server

When I installed Lua through my package manager, I found that setting up its language server was unnecessarily difficult.  
Running it on a bare-bones Debian installation was even worse.

For example:
- Lua's language server (`lua-language-server`) often requires manual builds or additional tools to work.  
- Rust makes it easy with `rust-analyzer`, which can be installed with a single command:  `rustup component add rust-analyzer`.  
- Go provides `gopls`, which integrates seamlessly with most editors.  
- Python, however, has multiple language servers you can use, like pyright, pylsp, and jedi.
    - Pyright (written in JavaScript/TypeScript) requires Node.js to install.
    - Pylsp (Python Language Server Protocol) is written in Python but requires additional configuration to work with plugins like jedi.
    - Jedi is often used directly in editors but lacks some of the features modern developers expect.

The sheer number of options for Python creates confusion, especially for newcomers.

While choice can be a good thing, having a single, official language server would simplify the development experience.

A language server should be included or installable with minimal effort.

## Add Formatters to Old Languages

Most older languages don’t include code formatters, which is understandable since they were designed before collaborative coding became mainstream.  
However, in today’s world, built-in formatters should be standard.

For example:
- Python: Tools like `black` and `autopep8` are separate installations.  
- JavaScript: `prettier` dominates, but it requires installation through `npm`.  
- Ruby: `rubocop` provides linting and formatting but is not part of the core language.  
- C++: You’ll likely end up using `clang-format`, which is part of LLVM but not bundled with the language.

While these tools exist, integrating them into the language would simplify workflows for developers.

## Modern Dependency Management

With collaborative coding now ubiquitous, modern dependency management is a necessity.  
Many languages include their own solutions, like `Cargo` for Rust and `go.mod` for Go.  
However, some languages rely on third-party tools, like Python (`pip`) and JavaScript (`npm`).  

Even within these ecosystems, fragmentation exists:  
- Python: Alternatives like `poetry` and `pipenv` attempt to improve on `pip`.  
- JavaScript: `yarn` offers an alternative to `npm` with better caching and performance.  
- Ruby: `bundler` is the de facto dependency manager but requires separate installation.  
- C++: No standard solution exists; developers use tools like `vcpkg`, `Conan`, or `CMake` for dependency management.  

While flexibility is nice, it often leads to confusion for newcomers.

## Build Systems Should Be Standard

Build systems are often overlooked because many developers rely on text editors or tools like `make`.  
However, an integrated build system that leverages language-specific optimizations, code generation, and documentation would be far superior.

Languages like Java eventually developed tools like `Gradle` and `Maven` to fill this gap, but they remain separate installations.  
Rust integrates its build system (`Cargo`) directly into the language ecosystem, which is a far better approach.


## Project Management Tools

This ties into the above points but focuses on creating template projects.  
Frameworks and plugins often handle this, but why not include it natively?

For example:
- Rust: `cargo new` creates a project with boilerplate files and directories.  
- Go: `go mod init` sets up a module with all required metadata.  
- Python: Django and Flask provide project scaffolding tools but are specific to the framework.  

A universal, language-wide project management system would be a game-changer.

## Tests Need Running

Every language should include a comprehensive testing framework with a great test runner.  
It should support all types of testing—unit, integration, fuzzing, and benchmarking—and provide clear, detailed results.  

For example:
- Rust: `cargo test` is built into the ecosystem.  
- Go: `go test` supports testing as a first-class citizen.  
- Python: Tools like `unittest` and `pytest` are great but require separate installations.  
- JavaScript: Popular libraries like `Jest` and `Mocha` dominate but are not bundled with the language.

Include coverage tools and fuzzing support, too!

## Binaries and Packages

Package managers like `pip`, `cargo`, `go`, and `npm` allow for the execution of binaries and executables, but some implementations are lacking.

For example:
- Python: Tools like `pipx` emerged to solve the problem of globally installing CLI tools without polluting the main Python environment.
- JavaScript: `npx` runs binaries temporarily without polluting your environment.  
- Rust: `cargo install` places binaries in a predictable `~/.cargo/bin` folder.  
- Go: While `go install` allows fetching binaries, the installation defaults to `$HOME/go/bin`, cluttering the home directory.

Languages should adopt predictable, clean methods for handling binaries and dependencies.

## Publishing Should Be Easy

Publishing packages should be secure yet straightforward.  
I shouldn’t need to install additional tools just to publish.  

For example:
- Python: Once had multiple ways to publish packages (`setup.py`, `distutils`, `wheel`). Now, tools like `poetry` simplify the process, but it’s still not included with the language.  
- Rust: `cargo publish` makes publishing seamless.  
- Go: Publishing binaries requires manual setup, often involving GitHub releases or custom scripts.

Languages should aim for simplicity and stability in their publishing ecosystems.

## Keep My File System Clean

Languages should avoid cluttering my home folder with cache, packages, binaries, or other files.  

For example:
- Go: Creates a `~/go` directory in the home folder, often owned by `root`.  
- Python: `pip` sometimes leaves behind unused files in the home directory or environment.  
- Rust: Places binaries in `~/.cargo/bin`, which is a good example of organization.  
- This is unnecessary when proper standards like XDG (`~/.cache`, `~/.config`, `~/.local`) exist.

Follow the standards, keep my home folder clean, and make me happy.

## Conclusion

That’s the end of my rant. If you’re building a programming language, please consider these points!  

Modern programming languages can reduce developer frustration and improve the experience with thoughtful design and inclusion of these features.  
