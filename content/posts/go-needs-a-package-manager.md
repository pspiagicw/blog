+++
title = "Go needs a 'real' package manager"
date = 2024-03-15
author = ["pspiagicw"]
tags = ["golang"]
categories = ["golang"]
draft = false
+++

Anybody remember 'leftpad' ?

If you aren't familiar with it. Read [this](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code).

TLDR: A developer removed a package from npm and broke the internet.

Do you know what's worse? It's not the first time it happened. It's not the last time it will happen.
The lesson here is that we need a package manager that is reliable and secure.
Mainly that tracks the dependencies and ensures that the code will work even if the dependencies are removed/changed.

Golang has a package manager called 'go modules'. But it's not perfect. It's not reliable. It's not secure.
I came across this while writing my own project [gox](https://github.com/pspiagicw/gox).
Before this project, I was not familiar with the workings of go modules. I was using it as a black box.

While developing this project, I realized that Go doesn't care from where the code is coming from.
It simply clones the code blindly and compiles it accordingly. 

It means, other than the username in the package import path, you don't know much about who wrote the code.

```go
import (
    "github.com/pspiagicw/goreland"
)
```

The above code imports my own library `goreland`. It is a very simple fancy logging library.

I could sabotage the entire library (by added malicious code) and everybody using the latest version would have shipped a very dangerous product.

I have used `pip` from Python, it requires authorization and other busywork to actually publish the package.

This has 2 benefits
- If anything goes wrong, they can track me using my email.
- If I delete or sabotage my code, they can simply rollback to a more stable package.

Go doesn't have this. If anything is wrong in the package, I have to hop onto `GitHub`, find the user and inform them.
In the meantime, nobody can help me.

You can't publish a package randomly on `cargo`, `npm` or any other widely used languages.

Heck even `Emacs` packages have a rudimentary repository system. This somewhat shares the responsibility of safety.

Go does have a documentation system. It indexes the modules to get documentation for the package. That gives Go package some form of trackability.

But that is not enough for a language being used on a large scale.
