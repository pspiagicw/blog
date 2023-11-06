+++
title = "DevLog 2"
author = ["pspiagicw"]
date = 2023-01-25
categories = ["development", "devlog"]
tags = ["golang", "linux", "programming"]
series = ["devlog"]
+++


# `qemantra`

I have finally released `v0.2.1` of my project `qemantra`. This release removed a lot of code, made it cleaner.

Things I have learned while developing this release.

- How to build a sexy website for any project.
Using `vhs` and `mdbook`, I made a website inspired from WezTerm, mostly it's homepage.
I tried to include a visual element (Picture or GIF) to improve user engagement and understanding.

- How not to complicate `argument parsing`. 
When using `flaggy`, I used to have a separate struct for each subcommand, over the structs I had for actually running the program.
With [this](https://abhinavg.net/2022/08/13/flag-subcommand/), I eliminated flaggy and brought the good'ol `flag` package.
I also tried to eliminate almost all other `struct`s. Now I have a single struct for the entire project. This simplifies things a lot.

Things I could have improved
- Testing: Even though I don't write a single line of code without testing, refactoring made lot of the tests not-passing.
Causing my CI/CD (`Github Actions`) to fail on every commit. I would have to re-write these tests.

- Website deployment: 
Currently deploying the `qemantra` website is a chore. I need to build, archive, transfer to my server (Using sftp) and then unarchive and restart my reverse proxy.
This is a lot of work and I would have to improve the workflow by a large margin. This is my plan over the next few days.

- Better planning:
This release was a little mess, the website had a lot of references to the `v0.0.1` release, I had to do a little cleanup for the few days after the release.
Next time I can have a ready changelog and beautiful CI/CD pipelines to make the process easier.

Try it [here](https://qemantra.pspiagicw.xyz)

# `bsharp` or `b#`

This is my Lisp implementation inspired from `bash`. I finally built a hand-written recursive descent parser.
My last implementation `boombash` had no actual parser. It had a very rude implementation and had no actual AST creation.

With the current implementation I have finally created a proper AST. I have also started the `evaluator` work. It can evaluate strings, numbers and other simple objects.

Ideas I have for this project
- Write a compiler: 
Once I have a working interpreter, I can have convert it into a working compiler. I am learning this while writing a VM based compiler `uranus` ( My implementation for `monkey` from `Writing a Interpreter/Compiler in Go.`).

- Writing a transpiler:
As `b#` is inspired from Bash and aims to replace bash scripts, transpiling to Bash script sounds like a good idea!
With this evaluation shifts to the much better bash implementation.

- Adding a macro system
`Writing a Interpreter in Go` has a secret chapter called `Writing a Macro System`. In keeping with this, I am also interested in making a macro system for `b#`.
Anyway every lisp is incomplete without a macro system!

Try it [here](https://github.com/pspiagicw/bsharp)

You can also checkout [uranus](https://github.com/pspiagicw/uranus) and [boombash](https://github.com/pspiagicw/boombash)




My goals for next few days/week.

- Work on publishing [`groom`](https://github.com/golang-groom/groom) with a sexy website.
- Complete `groom-install`, bringing number of subcommands to 3.
- Maybe implement task dependency ordering using a topological sort for `groom-make`.
- Finally complete `dpm` and `bbx`.


