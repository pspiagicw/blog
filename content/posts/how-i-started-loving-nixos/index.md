+++
title = 'nixing my life!'
author = ["pspiagicw"]
date = 2024-08-11
summary = "How NixOS became my ultimate goal"
+++

Isolation is a very important function to me. 
Everthing should have it's own scope and it's own place.

I have chased this idea for the last 2 years. 
Since I have been building multiple projects across various domains.

Let me describe this ordeal in depth.

## Roles

I have been always coding on my own since high school and never thought it as a task.
But once college came about, the `hobby` became `study`.

My hobby and study have to be kept separate. Thus the isolation anxiety began.

## distrobox

The first and most simple solution was to use distrobox.
Use a `PopOS` distro on my main laptop. 
Use distrobox and it's separate home directory feature.
`distrobox` can keep a separate home directory for each distribution you use.

`distrobox` for the uninitiated is a CLI tool to run multiple linux distro simultaenously through docker.
Instead of using `docker` as a throwaway build/development environment, it encourages docker to be used as a complete CLI environment
You can use it for everything including GUI apps and even running games through `Steam`.
It can install sound, graphics drivers and connect this secondary distro to your main distro very tightly.

This meant, my development tools (Python, poetry, Go, neovim) all were separated from normal life (Photos, College Work, GUI apps).

But the college  had a problem. 
The Python and Machine Learning courses meant I had to install large collections of Python libraries.
These included the behemoth `Tensorflow`, `OpenCV` and minor ones like `sklearn`. 
Although they were kept in a separate environment by `conda` or `miniconda`. 
I didn't like the pollution `conda` did on my environment.

So I launched a ran a separate VM for those tools. 
I would fire up those tools when required.

This is also one of the reasons to develop my tool [qemantra](https://github.com/pspiagicw/qemantra).

## HomeLab

My homelab ran docker for almost a year.
Then I became tired with maintaining all those tools and removed most of them.

Then I kept the homelab for a remote development machine. Meaning
- All editors, compilers and other tools installed on my homelab.
- To develop, I simply ssh into my home lab.

This meant I can development from anywhere (in my home) with any machine.

If I use cloudflare tunnels I can work from anywhere in the world!

I was very happy with this setup, but I had some hiccups.

I was using `Ubuntu Server` meant I get the most stable packages, also they are fucking old!

Most of my programs and development environment (Neovim Plugins) depends on latest `neovim`. 
Also most other tools were not in the repository or up-to-date, thus I had to manually compile/download them.

This included the `Go` compiler. Most of other binary packages were maintained in the /usr directory.
On top of this I had my own tools (`kato`, `groom` and `sinister`).

My projects required their own dependencies which were polluting my environment. 
For example my CLI tools required `vhs` and`qemu`.

Plus the multiple formatters, linters ,language servers and debuggers. Most of these were managed by `Mason`.

But updating all of these tools was a pain.

## Enter NixOS

I had used Nix 5 years back, back then I was a distrohopper and didnt explore and adapt to the workflow NixOS provided.

I came to NixOS with high expectectations due to the hype by both developers and Linux enthusiasts. AND DID IT DELIVER!

Right now all my Linux devices are under Nix or runs NixOS bare-metal.

Let me explain my setup in detail.

I have 3 devices, my laptop (`starship`) and my homelab (`falcon`) and my remote server (`skylab`). 

My laptop runs NixOS bare-metal. It has a GNOME system with only Chrome and WezTerm installed. 
It has encryption stuff (GPG) and my password-manager (pass) installed.

My remote server can't have it's operating system changed, thus I use `home-manager` to manage/configure everything.
This includes programs, bash, neovim and git.

My homelab runs NixOS bare-metal to run services like JellyFin.

All the configuration is stored in a single repository [here](https://github.com/pspiagicw/nixos). 

> Everything uses `Nix Flakes`, meaning the version of everything installed is locked. Unless I manually update it.

This post doesn't serve as a guide or a walkthrough, Nix is awesome but very hard to understand and explain. 
Thus I am not going to delve into the details of my config. 

My custom Nix packaged apps are available [here](https://github.com/pspiagicw/packages).

> FYI, my config is designed for aarch64 and amd64, all packages also work.

## Per project

One awesome feature I would use day and night is including a `flake.nix` in every project folder. 
This along with `direnv` allows storing a environment with all packages needed seaparately.

Imagine a `virtual environment` of everything you need, the compiler, the debugger, formatter etc. 
That's what using this feature looks like.


Here's how my Go development `flake.nix` looks like

```nix
{
  description = "Go development environment";

  inputs = {
    # Nixpkgs repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    custom.url = "github:pspiagicw/packages";
  };

  outputs = {
    self,
    nixpkgs,
    custom,
  }: {
    devShell.x86_64-linux = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in
      pkgs.mkShell {
        buildInputs = [
          pkgs.gopls
          pkgs.delve
          pkgs.gotools
          pkgs.go
        ];
      };
    devShell.aarch64-linux = let
      pkgs = import nixpkgs {system = "aarch64-linux";};
    in
      pkgs.mkShell {
        buildInputs = [
          pkgs.gopls
          pkgs.delve
          pkgs.gotools
          pkgs.go
          custom.packages.aarch64-linux.groom
        ];
      };
  };
}
```

This automatically installs the `go` compiler, the `gopls` language server protocol, the `delve` debugger and my custom task runner `groom`.
These tools are unique to that folder, meaning it will only be available when I am inside that directory.

You also need `direnv` to identify a `flake.nix` and load it automatically into the shell.


## Obsession


My obsession with software isolation is complete, I have the right tool to fuel this obsession and I don't think I am going anywhere else soon.

Hope your obsession is also resolved and happy coding!
