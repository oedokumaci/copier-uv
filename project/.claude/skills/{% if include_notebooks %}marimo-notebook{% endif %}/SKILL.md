---
name: marimo-notebook
description: Write marimo notebooks in Python files with proper format and best practices. Use when creating or editing marimo notebooks, or when the user asks about marimo patterns.
---
# Marimo Notebook Skill

Write marimo notebooks in Python files following best practices.

## Running Notebooks

```bash
uv run <notebook.py>                    # Script mode (testing)
uv run marimo run <notebook.py>         # Interactive viewing
uv run marimo edit <notebook.py>        # Interactive editing
```

## Script Mode Detection

```python
if mo.app_meta().mode == "script":
    # CLI execution
else:
    # Browser execution
```

## Key Principle

**Show all UI elements always. Only change the data source in script mode.**

```python
# GOOD: Always create widget, switch data source
slider = mo.ui.slider(1, 100, value=50)
data = default_data if mo.app_meta().mode == "script" else load_data(slider.value)

# BAD: Conditional widget creation
if mo.app_meta().mode != "script":
    slider = mo.ui.slider(1, 100)
```

## Common Mistakes

**Don't guard cells with `if` statements.** Marimo's reactivity handles dependencies. Guards prevent output rendering.

**Don't use try/except for control flow.** Only catch specific, expected exceptions.

**Cell output:** Only the final expression renders. Use ternary operators, not indented conditionals.

## Best Practices

- Prefix loop variables with underscore (`_name`, `_model`) to avoid cell conflicts
- Use `pathlib.Path` over `os.path`
- Use PEP 723 format for dependencies in file headers
- Run `uvx marimo check <notebook.py>` before delivery
