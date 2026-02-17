# Working on a project

The generated project has this structure:

```
📁 your_project ------------------- # your freshly created project!
├── 📄 CHANGELOG.md --------------- #
├── 📄 CLAUDE.md ------------------ # AI assistant guidance
├── 📁 .claude -------------------- # Claude Code configuration
│   └── 📁 skills ----------------- # Claude Code skills (/commit, /fix, etc.)
├── 📁 .cursor -------------------- # Cursor IDE configuration
│   ├── 📁 rules ------------------ # Cursor rules (always-apply → CLAUDE.md)
│   │   └── 📄 project.mdc ------- #
│   └── 📁 skills → .claude/skills  # symlink for Cursor skill discovery
├── 📄 .cursorrules → CLAUDE.md --- # legacy symlink (deprecated)
├── 📄 .pre-commit-config.yaml ---- # pre-commit hooks configuration
├── 📁 config --------------------- # tools configuration files
│   ├── 📄 coverage.ini ----------- #
│   ├── 📄 pytest.ini ------------- #
│   ├── 📄 ruff.toml -------------- #
│   └── 📁 vscode ----------------- # VSCode/Cursor settings
│       ├── 📄 launch.json -------- #
│       ├── 📄 settings.json ------ #
│       └── 📄 tasks.json --------- #
├── 📄 CONTRIBUTING.md ------------ #
├── 📁 docs ----------------------- # documentation pages
│   ├── 📄 changelog.md ----------- #
│   ├── 📄 contributing.md -------- #
│   ├── 📄 credits.md ------------- #
│   ├── 📁 css -------------------- # extra CSS files
│   │   └── 📄 apidocs.css -------- #
│   ├── 📄 index.md --------------- #
│   ├── 📄 license.md ------------- #
│   └── 📄 notebooks.md ----------- # (if notebooks enabled)
├── 📄 LICENSE -------------------- #
├── 📄 zensical.toml -------------- # docs configuration
├── 📁 notebooks ------------------ # marimo notebooks (if enabled)
│   ├── 📄 README.md -------------- #
│   └── 📄 starter.py ------------- #
├── 📄 pyproject.toml ------------- # project metadata, dependencies, and tasks
├── 📄 README.md ------------------ #
├── 📁 scripts -------------------- # helper scripts
│   └── 📄 gen_credits.py --------- # script to generate credits
├── 📁 src ------------------------ # the source code directory
│   └── 📁 your_package ----------- # your package
│       ├── 📄 __init__.py -------- # public API exports
│       ├── 📄 __main__.py -------- # module entry point
│       ├── 📁 _internal ---------- # internal implementation
│       │   ├── 📄 __init__.py ---- #
│       │   ├── 📄 cli.py --------- # CLI implementation
│       │   ├── 📄 debug.py ------- # debug utilities
│       │   └── 📄 logging.py ----- # loguru configuration
│       └── 📄 py.typed ----------- #
└── 📁 tests ---------------------- # the tests directory
    ├── 📄 conftest.py ------------ # pytest fixtures, etc.
    ├── 📄 __init__.py ------------ #
    └── 📄 test_main.py ----------- # tests for main entry point
```

## AI Integration

Every generated project ships with first-class support for **Claude Code** and **Cursor IDE**. A single `CLAUDE.md` file serves as the source of truth for AI context, with both tools configured to read from it automatically.

### Claude Code

- **`CLAUDE.md`** — project-aware guidance loaded automatically by Claude Code
- **`.claude/skills/`** — custom skills invokable with `/commit`, `/fix`, `/test`, `/pr`, `/release`, `/review`

### Cursor IDE

- **`.cursor/rules/project.mdc`** — always-apply rule that references `CLAUDE.md` via `@CLAUDE.md`
- **`.cursor/skills/`** — symlink to `.claude/skills/` so Cursor discovers the same skills
- **`.cursorrules`** — legacy symlink to `CLAUDE.md` (deprecated, kept for backward compatibility)
- **`config/vscode/`** — shared VSCode/Cursor settings (formatter, linter, debug configs)

This means you maintain one set of AI instructions (`CLAUDE.md` + `.claude/skills/`) and both Claude Code and Cursor use them seamlessly.

## Environment

The project uses [uv](https://github.com/astral-sh/uv) for dependency management
and [taskipy](https://github.com/taskipy/taskipy) for task running.

## Git Repository

The version is managed via `__version__` in `src/your_package/__init__.py` (read by [hatch](https://hatch.pypa.io/)). The git repository is automatically initialized when you generate the project.

To add remote, you can do the following:                                        

```bash
git add . && git commit -m "chore: Initialize repository from template"
```

Then you can create the repository on GitHub using `gh` CLI:

```bash
gh repo create <org-name/repo-name> --source=. --private --push
```

## Dependencies and virtual environments

Dependencies are managed by [uv](https://github.com/astral-sh/uv).

Use `uv sync` to install the dependencies and create the virtual environment.

Dependencies are written in `pyproject.toml`. Runtime dependencies are listed under the `[project]` and `[project.optional-dependencies]` sections, and development dependencies are listed under the `[dependency-groups]` section.

Example:

```toml title="pyproject.toml"
[project]
dependencies = [
  "fastapi>=1.0",
  "importlib-metadata>=2.0",
]

[project.optional-dependencies]
test = [
  "pytest",
]

[dependency-groups]
test = [
  "pytest>=8.2",
]
```

## Tasks

Tasks are defined in `pyproject.toml` using [taskipy](https://github.com/taskipy/taskipy).
Run tasks with `uvx --from taskipy task <name>`.

!!! tip "Shell Alias"
    For convenience, you can add an alias to your shell configuration (e.g., `~/.zshrc` or `~/.bashrc`):

    ```bash
    alias t='uvx --from taskipy task'
    ```

    Then run tasks with just `t <name>`, e.g., `t fix`, `t test`, `t ci`.

List all available tasks:

```bash
uvx --from taskipy task --list
```

Available tasks:

| Task | Description |
|------|-------------|
| `run` | Run module entrypoint |
| `setup` | Install dependencies |
| `format` | Format code (writes changes) |
| `lint` | Lint and auto-fix (writes changes) |
| `fix` | Format + lint auto-fix |
| `format_check` | Check code formatting (CI) |
| `lint_check` | Check linting (CI) |
| `typecheck` | Run type checking |
| `test` | Run test suite |
| `test_cov` | Run tests with coverage |
| `ci` | Run all CI checks (format, lint, typecheck, test) |
| `docs` | Serve documentation locally |
| `docs_build` | Build documentation (strict) |
| `changelog` | Update changelog |
| `clean` | Delete build artifacts and caches |
| `profile` | Profile module with Scalene (CPU, memory, GPU) |
| `profile_memory` | Profile module memory with Memray |
| `profile_memory_report` | Generate Memray flamegraph report |

## Pre-commit Hooks

The project includes pre-commit hooks for code quality. Install them with:

```bash
uvx pre-commit install
```

Run hooks manually on all files:

```bash
uvx pre-commit run --all-files
```

The hooks run:
- Code formatting with Ruff
- Linting with Ruff

## Logging

- Logging uses [loguru](https://github.com/Delgan/loguru) and writes to **stderr** by default (JSON format).
- No log file is created unless you explicitly request one:
  - Programmatic: `configure_logging(log_file=Path("app.log"), json_logs=True, level="INFO")`
- Console format can be switched to human-readable with `json_logs=False` when calling `configure_logging`.

## Workflow

The first thing you should run when entering your repository is:

```bash
uvx --from taskipy task setup
```

This will install the project's dependencies in a virtual environment (`.venv/`).

### Development

The typical development workflow is:

```bash
# 1. Create a feature branch
git switch -c feat/my-feature

# 2. Write code and tests
# (edit files in src/your_package and tests/)

# 3. Run your application
uvx --from taskipy task run

# 4. Auto-format and lint-fix
uvx --from taskipy task fix

# 5. Run all CI checks
uvx --from taskipy task ci

# 6. Commit your changes (Angular convention)
git add .
git commit -m "feat: Add my feature"

# 7. (Optional) Clean up commits with interactive rebase
git rebase -i main

# 8. Push and create a pull request
git push -u origin feat/my-feature
gh pr create
```

Once the PR is created, have it reviewed (or use the `/review` skill for AI review).
When approved, merge the PR into `main`.

### Releasing

After merging feature branches, release from `main`:

```bash
# 1. Switch to main and pull latest changes
git checkout main
git pull

# 2. Update the changelog (auto-determines version from commits)
uvx --from taskipy task changelog

# 3. Review the generated changelog, edit if needed

# 4. Update __version__ in src/your_package/__init__.py (hatch reads version from here)

# 5. Commit the release directly to main
git add .
git commit -m "chore: Release version X.Y.Z"
git push

# 6. Tag the version and push the tag
git tag vX.Y.Z
git push --tags

# 7. Create a GitHub release
gh release create vX.Y.Z --generate-notes
```

!!! tip "Version Consistency"
    The version in `__init__.py` should match the tag (without the `v` prefix).
    For example, if `__version__ = "1.2.0"`, the tag should be `v1.2.0`.

## Quality analysis

The CI checks are started with:

```bash
uvx --from taskipy task ci
```

This runs format checking, linting, type checking, and tests.

For individual checks:

```bash
uvx --from taskipy task lint      # linting with auto-fix
uvx --from taskipy task typecheck # type checking only
uvx --from taskipy task test      # run tests
```

### Linting

Code quality analysis is done with [Ruff](https://github.com/astral-sh/ruff).
The analysis is configured in `config/ruff.toml`.
In this file, you can deactivate rules
or activate others to customize your analysis.

You can ignore a rule on a specific code line by appending a `noqa` comment ("no quality analysis/assurance"):

```python title="src/your_package/module.py"
print("a code line that triggers a Ruff warning")  # noqa: ID
```

...where ID is the identifier of the rule you want to ignore for this line.

### Type checking

Type checking is done with [ty](https://github.com/astral-sh/ty).

If you cannot or don't know how to fix a typing error in your code, as a last resort you can ignore this specific error with a comment:

```python title="src/your_package/module.py"
result = data_dict.get(key, None).value  # ty: ignore[ID]
```

## Tests

Run the test suite with:

```bash
uvx --from taskipy task test
```

Behind the scenes, it uses [`pytest`](https://docs.pytest.org/en/stable/) and plugins to collect and run the tests, and output a report.

For tests with coverage:

```bash
uvx --from taskipy task test_cov
```

## Profiling

Profile your module with various tools:

```bash
# CPU, memory, and GPU profiling with Scalene
uvx --from taskipy task profile

# Memory profiling with Memray
uvx --from taskipy task profile_memory
uvx --from taskipy task profile_memory_report  # Generate flamegraph
```

These profiling tasks run your module's `__main__.py` entry point.

## Continuous Integration

The quality checks and tests are executed in parallel in a [GitHub Workflow](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions). The CI is configured in `.github/workflows/ci.yml`.

## Changelog

Changelogs are absolutely useful when your software is updated regularly, to inform your users about the new features that were added or the bugs that were fixed.

Update the changelog with:

```bash
uvx --from taskipy task changelog
```

This uses [git-changelog](https://github.com/pawamoy/git-changelog) to automatically update the changelog based on your commit messages.

For this to work properly, use the [Angular commit message convention](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit).

For a quick reference:

```
<type>[(scope)]: Subject

[Body]
```

Scope and body are optional. Type can be:

- `build`: About packaging, building wheels, etc.
- `chore`: About packaging or repo/files management.
- `ci`: About Continuous Integration.
- `docs`: About documentation.
- `feat`: New feature.
- `fix`: Bug fix.
- `perf`: About performance.
- `refactor`: Changes which are not features nor bug fixes.
- `style`: A change in code style/format.
- `tests`: About tests.

## Releases

See the [Releasing](#releasing) section under Workflow for a detailed step-by-step guide.

In short:

1. Update the changelog: `uvx --from taskipy task changelog`
2. Review and edit if needed
3. Update `__version__` in `src/your_package/__init__.py`
4. Commit: `git commit -m "chore: Release version X.Y.Z"`
5. Tag: `git tag vX.Y.Z`
6. Push: `git push && git push --tags`
7. Create release: `gh release create vX.Y.Z --generate-notes`

## Documentation

The documentation is built with [Zensical](https://zensical.org/) and the [mkdocstrings](https://github.com/pawamoy/mkdocstrings) plugin.

### Serving

Zensical provides a development server with files watching and live-reload.
Run `uvx --from taskipy task docs` to serve your documentation on `localhost:8000`.

### Building

Build the documentation with:

```bash
uvx --from taskipy task docs_build
```
