+++
title = "The Weirdest mode in Emacs"
author = ["pspiagicw"]
date = 2021-09-21T00:00:00+05:30
tags = ["linux", "emacs"]
categories = ["emacs"]
draft = false
summary = "Want to control MPD from Emacs ? Why not, you use Emacs for everything anyway."
+++

> Note: The user has switched to `neovim` since writing this post. The information may not be up-to-date

Considering Emacs has a lot of inbuilt functionality , existence of this mode is not a suprise.

If you don't know  about MPC-Mode , this mode  allows us to control , manage and restructure your music database
by interfacing with the MPD Server.

MPD(Music Player Daemon) is a popular music server on the Linux world. It helps in keeping your large music collection organized.
You can also stream , and remotely control your own music collection.


## The Suprise {#the-suprise}

The biggest problem with this mode, is the lack of documentation.
There is minimal documentation for this mode , available through `describe-package` command.
Although it is not enough to use it efficiently. And for evil-users the journey is quite hard.


## How does it work ? {#how-does-it-work}

To start the mpc interface , just use the command `mpc` using `M-x`.
The interface contains 5 windows/splits.
Here's a pic for reference

{{< figure src="mpc.png" >}}

The screen is effectively divided into 2 parts vertically. The top split is further divided into 3 splits  horizontally.
The bottom split is split into 2 horizontally splits.

- The top-left split is the `Genre` split. 

- The top-middle split is the `Artist | Composer` split.

- The top-right one is the `Playlist | Album` split.

- The bottom-left split is the `Status` split.The bottom-right split is the `MPC-Songs` split.

Now that we know what each split is called, let's begin!

One things you have to know about MPC is that you cannot select a single song! You have to select a artist / playlist / genre .


### MPC-Songs {#mpc-songs}

This is the main split with the main information. It shows the songs included in currently selected artist / playlist / genre.
Use the `mpc-playlist` command to show the current playlist. You can select a song using the command `mpc-select`. Remove it using the `mpc-playlist-delete` command.
You can save the current playlist using `mpc-playlist-create`.If viewing a different playlist  in "MPC-Songs" split. , you can use
`mpc-playlist-add` to add it in the current playlist.

{{< figure src="mpc-songs.png" >}}


### MPC Playlist {#mpc-playlist}

This view is useful for viewing all the differnt albums and playlists you currently have.Again to actually select a song use the command `mpc-select`.
Moving up and down is using the standard C-n and C-p.When a album or playlist is selected , the artists involved are shown in the "MPC-Artist" split.
The white line denotes where the involved artists name ends and uninvolved artists name starts.To add the selected album to current playlist use `mpc-playlist-add`

In the same way the currently selected album / playlist has it's genre shown in the "MPC-Genre" split.

{{< figure src="mpc-playlist.png" >}}


### MPC Genre {#mpc-genre}

This view works in the same way. When selected a genre using `mpc-select` , all the artist involved are shown in the "MPC-Artist" split.
All the albums in the genre are shown in the "MPC-Album" split.

{{< figure src="mpc-genre.png" >}}


### MPC Artist {#mpc-artist}

In the same way , you can select a artist using `mpc-select`. And it's information will be shown in the respective splits.

{{< figure src="mpc-artist.png" >}}


### MPC Status {#mpc-status}

The currently playing song , album and artist are shown here.Also there is a graphical volume bar.
This is a little lacking as it does not show whether "Shuffle , Consume , Single " modes are active.
It has a mouse-based volume bar , but it cannot be controlled using keyboard  , nor there is a command for it.

{{< figure src="mpc-status.png" >}}


## Evil Keybindings {#evil-keybindings}

Currently the `evil-collection` does not support mpc-mode.Although it has been requested (<https://github.com/emacs-evil/evil-collection/issues/535>) .
Using `general.el` I have created some of my own keybindings. My keybindings also need custom function for moving up and down.

```emacs-lisp
(defun move-mpc-down ()
  (interactive)
  (evil-next-visual-line)
  (mpc-select))
(defun move-mpc-up ()
  (interactive)
  (evil-previous-visual-line)
  (mpc-select))
```

Below are the keybindings I use for MPC-mode.

You can change these , according to your workflow.
The `mpc-play-at-point` simply plays whatever you have selected directly , clearing the current playlist.

```emacs-lisp
(general-define-key
 :keymaps 'mpc-mode-map
 :states 'normal
 "j" 'move-mpc-down
 "k" 'move-mpc-up
 "t" 'mpc-toggle-play
 "r" 'mpc-toggle-repeat
 "s" 'mpc-toggle-shuffle
 "S" 'mpc-toggle-shuffle
 "c" 'mpc-toggle-consume
 "a" 'mpc-playlist-add
 "p" 'mpc-playlist
 ">" 'mpc-next
 "<" 'mpc-prev
 "R" 'mpc-playlist-delete
 "RET" 'mpc-select
 "x" 'mpc-play-at-point)
```


## Down the Rabbit Hole {#down-the-rabbit-hole}

Keep falling in the rabbit hole of Emacs! Till next time!


