+++
title = "New Blog Design"
date = 2024-05-30
authors = ["pspiagicw"]
draft = true
summary = "A revealing review of my own blog"
+++

You must be reading this post on the new redesigned blog theme.

For the ones that can guess, this blog runs on `Hugo`. 
My reasons to choose `Hugo` were simple, it was written in `Go`.
Atleast that's what I tell people.

The theme I am using is called [`nightfall`](https://themes.gohugo.io/themes/hugo-theme-nightfall/).

The theme is very simple with a almost empty homepage and a `linux-shell` like interface for the `header`.
This is what I wanted for most part in my blog. 

But the default colorscheme, font and the presentation elements of the theme was not to my liking.

By default it uses a `Sans-Serif` font, like `OpenSans`. I hate sans-serif font, especially for nerdy things.

Let me rant systematically

## Colorscheme

- New 

- Old

The colorscheme I wanted was a very dark almost black theme, with flat/matte colors. 
They don't pop, but provide enough constrast for HTML elements to differentiate themselves.

I would say the best tool to use is `ChatGPT`, I only provided a few dark colors and it completed the rest of the colorscheme for me.

> I was using the `ChatGPT-3.5` model that is freely available.

I don't know how, but it has a innate sense of colors within it's text-only model.

Here's the pallete I am using for this website

```scss
$white: #FAFAFA;
$black: #2f2f2f;
$blue: #659DBD;
$red: #BD5A5A;
$green: #77A88D;
$charcoal: #1a1a1a;

$backgroundDarker: #1C1C1C;
$backgroundDark: #0F0F0F;
$backgroundCode: #000000;
```

## Fonts

I only like `Monospace` fonts, especially for reading purposes.
I have becomed accustomed to it.
I will change it wherever possible.

In the same ferver, I moved to these 3 fonts for this blog

- Fira Mono (for Headings and Title)
- Iosevka (for Code Samples and `these types of inline code`)
- Ubuntu Mono (for normal text, like the one you are reading!)

It makes the blog much more readable and so much more nerdy.
I don't care if you don't like it.

## Elements

For some reason, most elements of the blog were invisible.

Like `blockquotes`.

> I mean these kind of text. 

Earlier they were not at all contrasted, you would think that's a mistake.
But now they are clearly bordered with full visibility to the text written inside them.

The code blocks were also replaced with `Line Number` and other useful stuff.


## HomePage

- New

- Old

I didn't change much of the homepage, other than the font, and adding icons.

Most of the aesthetic changed because of the colorscheme

## Conclusion

Overrall I am very happy with the CSS work I have achieved over the weekend.
Most times I am far from artistic, I even wrote a blog post about it!


