+++
title = "DevLog 1"
author = ["pspiagicw"]
date = 2022-12-23
categories = ["development", "devlog"]
tags = ["python", "linux", "programming"]
series = ["devlogs"]
+++

Welcome to my first devlog!

Here I would try to show what I have developed over the week! Even if the week is unproductive.


# Python Backends

Through a college project, I am getting to know the inner working of building a backend with Python.
I have only built a backend with `golang` which resulted to nothing as I scrapped the entire project.
Building a backend with Python was a great way of getting back to Python after a long time.

But I would say this project was one of the best project's I have written in a while. 
Let me elaborate

## Python ecosystem

The first thing that impressed me was how cohesive the Python ecosystem has become.
With the popularity of `poetry` and the usage of the `pyproject.toml` file, every tool is integrated and works with each other.

> `poetry` is an project management tool for Python. It handles project creation, dependency management and even building the Python project without hassle. It's one of the inspiration for [groom](https://github.com/golang-groom/groom)

The second thing was the how easily I could use libraries like `fastapi`.
When I imagined of working with `Flask` especially for building REST API's I was a little disgusted.


Then I found out about `fastapi`. It looked similar to things I had been working with `golang`.
After the initial introduction I was hooked. I Immediately started configuring a starter repo.

> `fastapi` is a library that enables making REST API's quite efficiently. If you are planning to make a REST API I would recommend `fastapi` for your next project instead of `Flask` or something heavy like `Django`.

## AutoCode Bliss

For the first time in my life, my entire repo was automated. Using tools like `pdoc` , `poethepoet` and `pre-commit`,
I had setup a simple workflow which ensured that never any  unformatted and untested code is pushed to the repository.

With `pre-commit` I can be confident that every commit is clean!

### Why such precaution ?

This project was not a personal project, it was a collaborative college project.
Which meant a lot of people were about to contribute and commit to the repository.
This workflow not only was enforced on myself but on everybody who wanted to contribute to the repository.

I knew this was needed to prevent problems in the future. I was mostly right!

## CI/CD

I also integrated a simple CI/CD pipeline within the repository which would check every PR.
It would then build a docker image out of the repository and push it to `DockerHub`.

## Hosting

 Through a friend's help I had set up a lightweight `x86` instance on the cloud.

I could run the docker image of my backend with the appropriate port forwarding.

But what happens when I update the image on `DockerHub`. Will I need to `ssh` into the cloud server and update the docker container manually ?

#### NO

That's where `watchtower` helped me. I found out about it through my self-hosting experiment and since then I have been using it regularly.

Basically whenever the `DockerHub` image updates, it automatically updates the local docker container with the updated image, preserving all the options like the port forwarding.


# Frontend

The frontend was handled by the aforementioned friend who is a wizard of React/React Native and gladly began work.

Thanks to him I am confident we can complete this college project and maybe learn a thing or two about collaborative development.

Writing this post has given me the idea of sharing my Python project setup. I believe it is quite good and maybe helpful to others.


BTW the [code](https://github.com/pspiagicw/placy)



