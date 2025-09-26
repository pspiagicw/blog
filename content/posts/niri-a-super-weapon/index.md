+++
title = "Niri a super-weapon"
author = "pspiagicw"
date = 2025-09-26
draft = false
summary = "Tiling window management at it's best."
+++

I started using X11 window managers almost as soon as I switched to Linux, youtuber [DistroTube](https://www.youtube.com/distrotube) and [Luke Smith](https://www.youtube.com/@LukeSmithxyz) guided me into this world.

ArchLinux for a OS, MPD for music and `neomutt` for emails were not far. The golden pot at the end is a [dotfiles](https://github.com/pspiagicw/dotfiles) repository, which is a testament to how much free time a Linux user can have.

Awesome, BSPWM, OpenBox, Qtile, XMonad all can be seen as my favorite hobbies during my teens. I am pretty sure, weeks went by configuring them to my tastes. Obviously a global pandemic helped.

All of these tools, sold me a idea. The ideal setup is not just the right hardware, but the right software. You can't run something stock, you need to configure your tools.

All I want to say is I loved these window managers. But none of them came close to how much I love `Niri`.

## niri

It is different from other window managers. Instead of tiling, it is a scrolling window manager. Windows don't get smaller as more windows pop up, they simply scroll out of view.

The experience is very unique at first. The upsides were visible almost instantly.

- Windows don't change sizes, your neovim window is as important as your `fastfetch/neofetch` window. That is to say, your work area doesn't shrink.
- Workspaces are mostly dynamic and instead of horizontal, they are vertical. You go down for a workspace, not right.

The 2 best things I enjoyed about Niri are the configuration language and the keyboard workflow.

## configuration

The configuration of Niri is written in something called KDL, which is another language akin to TOML, JSON, YAML. But I feel it's the best for something like this.

For comparison, `waybar` uses json, which feels almost like vomit at times, on the other spectrum `eww` uses it's own LISP, which gives me goosebumps to configure.
These tools are at opposite end of the spectrum, one uses a common language and another a bespoke language, both cause problems for the user.

KDL is not a Niri specific language, but it feels unique and very intuitive for a configuration language. KDL is awesome!

## keyboard workflow

Now to discuss what I found to be a super weapon. 

Because you have dynamic workspaces and you select windows like they are on a grid.
The only primary operations are to go sideways (for selecting other windows) or up-down (to select other workspaces).

In theory this means you can manage with 2 keybind pair, left-right and up-down. Thus the awkward selecting workspace-1 or workspace-2 keybinds are missing by default.
They can be put if you need, but they are not one-to-one with other tiling window managers. You can find more on their documentation.

What this means is I don't have to contort my hand to press the number-1,2,3 keys. I can focus any window I want to, using 'h,j,k,l' and the mod-key.
Not only that if you configure it properly, all the keybinds can be  on the home-row. 

The only keybinds not on my home-row are rarely used keybinds, like `kill-window` and `exit-niri`.

Plus it has a overview-button. You got lost ? don't know where a specific window is ? or want to rearrange something, see every window and every workspace all at once.

## conclusion

I really downplayed what Niri is, please do check it out [here](https://github.com/YaLTeR/niri).

I really need to explain this and maybe help somebody configure it. 
I was always helped by those 'Getting Started wth X' blog posts, they show you everything from Window Managers, to GPG encryption, SSH, using `neomutt`/`ncmpcpp/mpd/mpc`/`newsboat` etc.

I guess my next blog idea is here!


