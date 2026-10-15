+++
title = "I found the best music tagging software."
author = "pspiagicw"
date = 2026-05-28
draft = true
summary = "The best tool is a chat-bot!"
+++

Let me explain first!!

I am trying to organize my 3k+ library of songs. I have tried multiple software, I have even paid for a few. But all of them have a problem, they follow their own conventions.

- They either pull from an API, meaning. Whoever uploaded the data to the API is responsible for the ID3 tag info.

- They have weird tags. Instead of taking official releases, they take compilations as official release (Instead of the album, something like 'That's What I Call Music' or something is selected)

- They don't follow a system. Multiple artist can have comma or slashes or just directly dumped in the title.


What I mean to say is.

My music tagging system is weird. It's to accomodate all the places I keep and play my music.

- I have my Navidrome server, which strictly follows tags. Including multiple artist. It includes a DJ system which requires Genre to work correctly.

- I use my tablet, on which I use PowerAmp or Oto Music. Both of them are best enjoyed with tags. But I also prefer playing by folders.

- I have my DAP (Snowsky Echo Mini), whose UI is not optimized for tags. I have to use folder structures.

I also have weird rules when tagging.

I manually edit each file after the software has tagged them for these rules. It's hard work, but I need them to be how I like them.

- No artist info in the title, no `feat.` in the title.

- Multiple artist should have `;` as separator. If the artist has a `;` in it's name then use `/`.

- Same with Album Artist. I prefer single album artist, but Bollywood albums have so many artists, you need this.

- Year should be a year. No dates.

- I am all for weird Genre names, but when I also need normal genre names. Obviously multiple genre have `;`


For my quirky tagging needs, I switched to `claude code`. It does what I want. Simply said. 

I told it to maintain a .toml config file with all my preferences in one place, then use that as the source of truth before applying changes to files. This way:

- The AI reads my tagging rules
- Suggests corrections or fixes
- Generates batch commands for ID3 editing
- Validates tags across all platforms (Navidrome, PowerAmp, DAP)
- Learns from feedback to improve suggestions over time

The result? A consistent, beautiful music library that actually works everywhere. And if the AI ever breaks something well, I catch it before it gets too far. Sometimes even manual editing is best after all.

But seriously though, this approach is scalable. You can:

- Write a simple schema of what tags you need
- Let the AI handle the heavy lifting
- Review and approve batch changes
- Iterate on rules as your collection grows

Sometimes the "best" tool isn't fancy software that costs money. Sometimes it's a good idea in an editor, paired with a capable model running locally or via API. That's what I'm using for this post about AI-written content, too.

**TL;DR:** When standard music tagging tools fail to meet your needs, try thinking outside the box. An AI assistant that respects your rules might be exactly what you need.

Happy (and oddly organized) music listening! 🎵

