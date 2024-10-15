+++
title = 'nixing my life!'
author = ["pspiagicw"]
date = 2024-08-11
summary = "How NixOS became by ultimate freedom"
+++

Isolation is a very important function to me. 
Everthing should have it's own scope and it's own place.

I have chased this idea for the last 2 years. 
Since I have been building multiple projects across various domains.

Let me describe this ordeal in depth.

## The itch

I always had a itch to keep my life (Photos, Documents, Games) separate from my programming (Editors, Programming, Projects).

This itch developed not only due to the privacy problems but also the fact that my main computing device was used by family members.

It also makes it easy to use during my lazy days. I don't want to manage Xmonad when I want to browse through some photos or just watch a movie.

## separate OS

The solution is to run 2 operating systems. One user-friendly Ubuntu/PopOS types for ease of access where all my multimedia including my photos and games would be managed.
A separate dual-booted specialty operating system with all the window-managers, terminal emulators and editors I want. Obviously running either Gentoo or Arch!


This had quite a few problems

- I had to shutdown and boot again whenever I wanted to do something else.
- This was on a i3 6th-Gen (mobile) and a hard-drive to boot everything.

Nevertheless it was extremely slow and cubersome, but I had lots of time and it sufficed for me.

## distrobox

The lockdown ended and I had to attend University in-person. 

The University requirements were simple, you should be able to go from debugging a kernel to playing `Witcher 3` within seconds.
The previous setup didn't help this endeavour.

The solution I settled on was to use distrobox.
Use a `PopOS` distro as my main OS. And use a separate Arch Linux distro on the shell.
By using distrobox and it's separate home directory feature, I could have a separate home directory for my programming stuff.

Also my new laptop with a fast SSD helped me achieving this.

`distrobox` for the uninitiated is a CLI tool to run multiple linux distro simultaenously through docker.
Instead of using `docker` as a throwaway build/development environment, it encourages docker to be used as a complete CLI environment
You can use it for everything including GUI apps and even running games through `Steam`.
It can install sound, graphics drivers and connect this secondary distro to your main distro.

This meant, my development tools (Python, poetry, Go, neovim) all were separated from normal life (Photos, College Work, Games and GUI apps).

## HomeLab

When I came back from college, I had some money I could invest in a home-lab. It was a pre-owned Lenovo ThinkCentere M600.

It was one of the most powerful desktop I had held in my hand. 
I learnt the entire home-lab thing and got a perfect solution.

Use a desktop laptop with PopOS/Mint. Whenever I want to program, simply SSH into the homelab.
But maintaining docker and reverse proxy is hard. It required manual intervention atleast once a day, mostly because of my shitty WIFI.

The next problem I faced is that "running a stable, server operating system is opposite of using latest editors, packages etc."
I had to manually compile/download mostly everything, including the `Go` compiler, `neovim` and tools like `ripgrep`.
Managing everything was irritating and took a lot of my time.

## Enter NixOS

I had used Nix 5 years back, back when I was a distrohopper and didn't explore and adapt to the workflow NixOS provided.

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

One awesome feature that changed my workflow is including a `flake.nix` in every project folder. 
This along with `direnv` allows starting a environment with all packages isolated.

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
Using NixOS on the host system means that configuration is done automatically.

## Obsession

My obsession with software isolation is complete, I have the right tool to fuel this obsession and I don't think I am going anywhere else soon.

Hope your obsession is also resolved and happy coding!
