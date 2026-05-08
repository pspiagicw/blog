+++
title = "A Real Operating System"
draft = false
author = "pspiagicw"
date = 2026-05-08
summary = "When shit hit's the fan, you need a real OS"
+++

Recently I got myself into a weird situation.
I was setting up my NAS, for which I connected it to my monitor and was about to flash my removable media with the Proxmox ISO.
But my fancy 1440p monitor suddenly failed. 

It went into factory mode, started cycling RGB colors. I was not able to fix it after about an hour of troubleshooting. I decided to RMA the monitor and move ahead.

But my NAS was not ready! Better yet, I hadn't even flashed my removable media yet. But now that my monitor was not working I couldn't work on my primary PC.

The only computing device that I had that had a integrated screen were my Chromebook, my android tablet and my ROG ally.

I didn't want to fiddle with USB-C adapters plus my ROG Ally was untouched for a long time. And I realized, apart from my PC and ROG Ally, none of my devices have a real operating system.

## What is a real operating system ?

From what I can think of, a real operating system should have these features

- Access to raw hardware devices
- Access to a terminal or terminal-esque interface.
- Ability to install apps natively.
- To be hackable or best replaced with Linux.
- To be able to be used with a keyboard/mouse.

I want to explain what I mean by that.

## Access to raw hardware devices
I should be able to flash a operating system onto a removable media. From what I know, ChromeOS, iOS and iPadOS can't do that. They simply read the file-system and don't provide raw hardware access.

ChromeOS can do the flashing, but it's not easy and not supported. In theory you fool the ChromeOS Recovery Utility into flashing a removable media with a different ISO (rather than ChromeOS ISO).
Android can do the flashing by installing apps like EtcherDroid.

Winners => MacOS, Linux, Windows, ChromeOS, Android

## Terminal or terminal-esque interface
I should be able to open a terminal, install apps and use it normally. Android and ChromeOS allow me to do that through (Termux and Crostini) but iOS and iPadOS can't do that natively.

For iOS/iPadOS there are 2 approaches, either emulate the entire terminal interface (which is slow) or get a native interface with limited apps. 

This comes from the limitations of iPadOS/iOS which means only binaries registered while installing can be run. So you either register the emulator or register a small subset of binaries.

ChromeOS has a terminal interface, but for some reason Google removed hardware acceleration from the environment which means apps like Moonlight can't use hardware decoding.

Android has a terminal interface using either Termux or in newer Android versions a integrated terminal. This is rumoured to be a move to merge android with ChromeOS with Linux as the base.

Winners => Android, Linux, MacOS, Windows

## Ability to install apps natively.
This is a doozy which only applies to ChromeOS. ChromeOS is a read-only operating system which doesn't support installing other apps. There are exception, like Steam. But they aren't installed through a App-Store. 

They are installed by the system on your request. It can run Android Apps, but I don't want a touch-dependent app running on my desktop system. Plus they are emulated and not running natively.
And obviously they don't have access to the full system.

It can install apps on the integrated Linux environment, but it can only run command line apps as hardware acceleration is disabled (Atleast don't run proper GUI apps).

You used to be able to install apps on ChromeOS using the Chrome Web Store, basically converting extentions into applications, but they removed that feature last year for some reason.

Winner => Everybody except ChromeOS

## To be used with Keyboard/Mouse
Here the only loser is iOS and Android, which makes sense since both are operating systems designed for smartphones. But iPadOS's great support for keyboard and touchpad, kinda spoils you.

But it isn't that transparent. Samsung and few other android manufacturers modify stock Android for a better experience with keyboard/mouse. 
It isn't consistent and there isn't a standard development philosophy.

## Results
The only real winners are Linux, MacOS and Windows.

And that's sad to hear. We have gone through about 20-years of software and hardware evolution, but the only true operating systems are the ones that we were using at the turn of the century.

I might rant about why the fuck is the tech industry in this limbo, but till then may you share the frustration with the tech industry.





