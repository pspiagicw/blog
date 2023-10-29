+++
title = "Python Project Starter"
date = 2022-12-23
author = ["pspiagicw"]
tags = ["linux", "python", "devops"]
categories = ["python"]
draft = false
+++

I recently dived back into Python and got to build a fully featured Python application.
Here's how maybe you can setup a sick Python Project setup.


## Dependencies

For obvious reasons you need `pip` which is the package manager for Python.

You may use `pipx` which is what I use. It provides a isolated environment for every package installed through pip.
It is designed to be accompanied with command line tools written in Python. 

A very good example for this would be the official `kaggle` command line tool.
Installing this through `pipx` means it is kept in a separate virtual environment and it's dependencies are tracked.
If any other command-line tool has the same dependency but with a different version it would not cause problems.

Another side effect of this is that when you delete a `pipx` package, it's dependencies are also deleted, which is not the default behaviour when using `pip`.

For following this tutorial you will need 2 python packages.

- `poetry` It manages our Python project for us.
- `poethepoet` It is a task runner. You can run `make` but DOS/Windows users may face problem installing  and configuring `make`.By using `poethepoet` we use a os-agnostic task runner.


You can install it using `pip` or `pipx`.


```shell
pip install poetry poethepoet

```

```shell
pipx install poetry
pipx install poethepoet

```

## `init!`

Creating a project directory is trivial.

```shell
poetry new <project-name>
```

This would create a new directory with the name `<project-name>`. It will ask you for some defaults simply answer them as you wish. You can change these later.

It would ask for your program dependencies.If you have any dependency in mind, please feel free to add them.

It will ask for development dependencies. I recommend skipping this question for now (To skip simply leave the prompt empty and press Enter).

Simply move into the new directory using `cd <project-name>`

## `dev!`

Let's install a few dependencies which will help you maintain a clean code. These are not the dependencies that the project uses to run.
These are only needed when developing/contributing to the project. That's the reason it is called the development dependencies.

Ofcourse development of any software is a subjective process. You can take help of any number of tools.

These are my suggestions

- `black` is the formatter that I prefer. It is simple and non-intrusive. You are free to install any formatter that you currently use.

- `pytest` is the testing framework. I have never required anything beside `pytest`. Although if you need complex features you may install other testing frameworks

- `pydocstyle` ensures that all the code is documented. Especially useful when working on group projects where every little function may need to be documented.

- `pdoc` extracts the documentation from the code and converts into user friendly html format. You can use `sphinx` but it requires knowledge of `RST` format.
This might be a learning curve and ensuring everybody learns and uses it in a team is hard.

- `pre-commit` is the most important tool. It provides `git-hooks` which does not allow us to commit code without checking it through all the above programs.

Keep in mind we are installing these tools in a development environment, not production. Thus we would need to tell poetry to add them to the dev dependencies.
To do the same run

```shell
poetry add -G dev black pytest pydocstyle pdoc pre-commit

```

This will not only create a new virtual environment for your dependencies but also create a `poetry.lock` file which will track all dependencies.
## `pre-commit!`

Let's configure `pre-commit`. For that we need a `.pre-commit-config.yml` file in the root of our project.

Populate the `.pre-commit-config.yml` file with the given content. For more information refer to the `pre-commit` documentation.

The given file configures some checks to be done before commiting any code. This includes
- formatting changes.
- documentation validation.
- misc things like trailing whitespaces.


```yaml
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-added-large-files
-   repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
    -   id: black
-   repo: https://github.com/pycqa/pydocstyle
    rev: 6.1.1  # pick a git hash / tag to point to
    hooks:
    -   id: pydocstyle

```

Now is a good time to initialize `git`. Add the current folder to `git` and make a initial commit.

```sh
# In the project root
git init
git add .
git commit -m "Initial Commit"

```

## `poethepoet!`

Now we can configure the task runner. This would help you to run common tasks like formatting , testing without enabling the virtual environment.
`poethepoet` uses `pyproject.toml` file for the list of tasks.

You only need to append the following section


```toml
[tool.poe.tasks]
test = "pytest"
run = ["doc", { shell = "python -m <project-name>"}]
format = [ { shell = "black <project-name> tests"}]
init = [ { shell = "poetry install"} , { shell = "poetry run pre-commit install"} , { shell = "poetry run pre-commit "} ]
doc = "pdoc -o docs <project-name>"

```

After adding this code you can run tasks using `poe`.

For example to format the entire code.

```sh
poe format
```
This would automatically run the formatting tool `black` within the virtual environment `poetry` created for us.
We don't have to manually run anything.

This is just the tip of the iceberg. We can run any tasks including building Docker images or deploying to PyPI.
Refer to the `poethepoet` documentation for more information.

To configure `pre-commit` and confirm every dependency is already installed. Run `poe init`.
This would make sure all dependencies are installed and configure pre-commit.

Until now `pre-commit` has not integrated with git. `poe init` takes care of doing this.
It will also run `pre-commit` for the first time to check if everything is working.

Because we have setup `pydocstyle` within `pre-commit` it may complain about missing documentation within the pre-generated code.

Everything we need will be inside the virtual environment. Isolation at it's peak!

## `coding!`

Now the only thing remaining is coding!. Build your dream app.

The features provided through this process are

- `pre-commit` for automatically formatting, checking and maintaining code quality
- `poethepoet` for a os-agnostic task runner. This will run irrespective of your operating system or dev environment. 
- `poetry` for creating and managing a separate virtual environment. All dependencies will be handled by `poetry`.

If you need others to run your software. You only need to tell them to install `poetry` and `poethepoet`.

Then clone the repository and run `poe init` within the project root. It will setup everything needed to develop and run your application.

Some tips:

- Adding non-development dependencies
```sh
poetry add <dependency>
```
- Add a cute .gitignore to ignore `__pycache__` folders and other build files.
- If possible setup a Continous Integration workflow using GitHub Actions or any other CI service.
- Maybe add a `Dockerfile` and make it more isolated.

## `errata!`

## `print("Goodbye and may you have a good day!")`












