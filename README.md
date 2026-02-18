# Python Production Template (ARCHIVED)

> **This repository has been archived.** The project has moved to [oedokumaci/python-production-template](https://github.com/oedokumaci/python-production-template).
>
> **Why?** This repo was a GitHub fork of [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv), which caused several problems:
>
> - **Polluted tag history** — upstream tags (1.0.0–1.11.9) mixed with our own (0.1.0–0.16.0), making version resolution confusing
> - **Copier `--vcs-ref HEAD` workaround** — the conflicting tags forced users to always pass `--vcs-ref HEAD` to get the correct version, instead of copier just picking up the latest release automatically
> - **Fork label** — GitHub marked this as a fork rather than an independent project, despite having diverged significantly with AI-native features, a different toolchain, and its own identity
>
> The new repository is a clean, independent repo with correct tag history. Use it instead.

[![ci](https://github.com/oedokumaci/python-production-template/workflows/ci/badge.svg)](https://github.com/oedokumaci/python-production-template/actions?query=workflow%3Aci)
[![documentation](https://img.shields.io/badge/docs-zensical-blue.svg?style=flat)](https://oedokumaci.github.io/python-production-template/)

An AI-native [Copier](https://github.com/copier-org/copier) template for Python projects managed by [uv](https://github.com/astral-sh/uv). Ships with deep Claude Code integration, a modern toolchain, and a batteries-included development workflow so you can go from `copier copy` to production-ready in minutes.

## Features

- **Claude Code integration** -- every generated project includes a `CLAUDE.md` with project-aware guidance and custom skills (`/commit`, `/release`, `/review-pr`, `/docs-deploy`) so AI assistants understand your codebase from day one
- **Cursor IDE support** -- full `.cursor/` directory with always-apply rules pointing to `CLAUDE.md` and skills symlinked from `.claude/skills/`, so Claude Code and Cursor share the same AI context
- **Modern Python toolchain** -- [uv](https://github.com/astral-sh/uv) for dependency management, [Ruff](https://github.com/charliermarsh/ruff) for formatting and linting, [ty](https://github.com/astral-sh/ty) for type checking
- **Task runner** -- [taskipy](https://github.com/taskipy/taskipy) tasks for every workflow: `fix`, `ci`, `test`, `docs`, `changelog`, `profile`, and more
- **Pre-commit hooks** -- pre-configured Ruff formatting and linting hooks
- **CI/CD** -- GitHub Actions workflow for format checking, linting, type checking, and testing
- **Documentation site** -- [Zensical](https://zensical.org/) with [mkdocstrings](https://github.com/mkdocstrings/mkdocstrings) for auto-generated API docs
- **CLI support** -- `__main__.py` entry point with argument parsing out of the box
- **Structured logging** -- [loguru](https://github.com/Delgan/loguru) with JSON output
- **Optional marimo notebooks** -- interactive [marimo](https://marimo.io/) notebooks for data science workflows
- **Auto-generated changelog** -- conventional commits parsed by [git-changelog](https://github.com/pawamoy/git-changelog)
- **All open-source licenses** -- every license from [choosealicense.com](https://choosealicense.com/appendix/)
- **Smart defaults** -- git email and username auto-detected from your git config

## Quick Start

Make sure you have [Git](https://git-scm.com/) and [uv](https://docs.astral.sh/uv/) installed, then:

```bash
uvx --with copier-templates-extensions copier copy --trust --vcs-ref HEAD "gh:oedokumaci/python-production-template" /path/to/your/new/project
```

See the [documentation](https://oedokumaci.github.io/python-production-template) for the full guide.

### Updating an existing project

To pull in the latest template changes to an already-generated project:

```bash
uvx --with copier-templates-extensions copier update --trust --vcs-ref HEAD --defaults
```

See the [update documentation](https://oedokumaci.github.io/python-production-template/update) for details.

## Credits

Based on [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv) by Timothee Mazzucotelli.
