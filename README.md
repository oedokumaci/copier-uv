# Copier UV

[![ci](https://github.com/oedokumaci/copier-uv/workflows/ci/badge.svg)](https://github.com/oedokumaci/copier-uv/actions?query=workflow%3Aci)
[![documentation](https://img.shields.io/badge/docs-zensical-blue.svg?style=flat)](https://oedokumaci.github.io/copier-uv/)

An AI-native [Copier](https://github.com/copier-org/copier) template for Python projects managed by [uv](https://github.com/astral-sh/uv). Ships with deep Claude Code integration, a modern toolchain, and a batteries-included development workflow so you can go from `copier copy` to production-ready in minutes.

## Features

- **Claude Code integration** -- every generated project includes a `CLAUDE.md` with project-aware guidance and custom skills (`/commit`, `/release`, `/review-pr`, `/docs-deploy`) so AI assistants understand your codebase from day one
- **Cursor IDE support** -- `.cursorrules` symlink to `CLAUDE.md` for seamless Cursor integration
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
uvx --with copier-templates-extensions copier copy --trust --vcs-ref HEAD "gh:oedokumaci/copier-uv" /path/to/your/new/project
```

See the [documentation](https://oedokumaci.github.io/copier-uv) for the full guide.

## Credits

Based on [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv) by Timothee Mazzucotelli.
