+++
title = "ChromeOS is Bliss!!"
author = "pspiagicw"
date = 2025-05-25
draft = false
summary = "If you want simplicity, try ChromeOS"
+++

I was always a Google fanboy, even after I turned to Linux as my rescue prince.

The fanboy in me resulted in buying a Chromebook, not for the fun of it. I really needed a laptop.

I own a Lenevo Legion gaming laptop. If you own something like this, you already know it's a pain in the ass to use.
It's `heavy`, `loud`, `large` and doesn't have great battery life, plus don't get me started on the charger!

## What I wanted

I wanted something that has great battery life, charges over USB-C (my first USB-C laptop!), and has enough power to run a terminal and a browser.
When you are REALLY programming you only need a browser for reading documentation and solving bugs along with a simple text editor.

For me the editor is `neovim`, thus I also needed a terminal to go with it.

## ChromeOS itself

For the uninitiated, ChromeOS is a immutable distro (calling it a distro is already going too far!), meaning you can't install any new apps on it.

As the name suggests it runs only Chrome, the only *apps* you can install on it are PWA or simply browser-based apps. 
Although the system underneath is based on Gentoo Linux, the actual filesystem is read-only (except for your home folder obviously!).

This is the new trend with SteamOS, bazzite, VanillaOS and Fedora Silverblue all going with the same approach, the operating system itself is read-only,
the only place you can make changes are your home folder. The pros ?

- The updates are solid, plus easy rollbacks
- You can't fuck up the system with shenanigans.
- The only apps you can install are mostly Flatpaks (which are already sandboxed, thus increasing security).

The cons ?

- You can't do shenanigans. You can't nerd out.

## What has ChromeOS has to offer

ChromeOS already has a terminal app which supports SSH with custom SSH keys and everything.
So work-wise I was sorted, my work happens only on remote servers, thus I don't need a local development environment.

But I do code for fun and develop my personal projects, how to do that ?

*Enter Linux inside ChromeOS*

ChromeOS has a option to enable a Linux container inside ChromeOS. Technically it runs a debian container inside a VM running on top of ChromeOS.
It does this to provide complete isolation, so you can't corrupt the OS.

What does this give you ? Ability to run GUI apps, play games and it will be integrated with ChromeOS. 

> The Linux container/VM is called *Crostini*.

> Technically you don't need to run games through Crostini, ChromeOS supports Steam out of the box. (in some models)

Thus I can install a terminal (although the native terminal app also works!), in my case `alacritty` and be on my merry way.
The reason I installed a separate terminal and not use the existing terminal app is simple, the native app doesn't support custom fonts, let alone `Nerd fonts`.

Installation of separate terminal app, means it starts up slowly (It has to boot the Crostini first), but once it's running, nothing to worry about.

Because of the tight integration, copy-paste, sound, file-system sharing etc, works flawlessly. 

## Costing

It costed me about INR 20k (~250 USD), which is pretty good, a powerful, solid laptop with great battery life at a cost of a cheap smarthpone.
I ditched the charger as I use my own 100w GAN charger which can charge this 65W laptop without a sweat. 
I don't store anything on the laptop, although it has 256 GB storage just in case.

Final result ?
- Battery life of around 10 hrs (with Linux running), without it 12+ hrs.
- Lightweight small laptop with a good keyboard. (To be honest the best out of all the laptops I have used in my lifetime).
- Integrates very tightly with my Pixel 8, can share links, files and even run apps (from my Pixel 8) right out of ChromeOS.

## Minor things to note.

- The chrome app on ChromeOS doesn't support profiles, meaning all your accounts are in one session, just like the old times.
- No backlight on the keyboard, obviously some models might provide this, mine doesn't.
- The android app support drains battery, so I mostly keep it disabled.
- The terminal app doesn't store the SSH keys securely (atleast from what I saw), I now keep my SSH keys inside the Linux container.

## Conclusion

I liked the simple no-bullshit experience so much, I stopped using the Pop-OS installation on my main laptop for development, now it's only used to backup my data and stuff.
I plan to use ChromeOS itself for most of my development stuff, although I will keep a Pop-OS installation just in case (mostly for gaming).


