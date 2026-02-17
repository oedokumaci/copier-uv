# Requirements

To use this Copier template, you will need:

- [Git v2](https://git-scm.com/)
- [uv](https://docs.astral.sh/uv/)

To install Git version 2, [follow the official instructions](https://git-scm.com/downloads).

To install uv:

=== "Linux/macOS"

    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

=== "Windows (WSL recommended)"

    We recommend using [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) for the best experience:

    ```powershell
    wsl --install
    ```

    Then inside WSL, install uv:

    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

    Alternatively, install uv natively on Windows:

    ```powershell
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

To install Python with uv:

```bash
uv python install 3.X  # Replace X with your desired version, e.g., 3.12
```

Then generate a project with:

```bash
uvx --with copier-templates-extensions copier copy --trust --vcs-ref HEAD "gh:oedokumaci/python-production-template" /path/to/your/new/project
```
