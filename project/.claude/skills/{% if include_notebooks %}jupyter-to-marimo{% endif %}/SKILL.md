---
name: jupyter-to-marimo
description: Convert Jupyter notebooks (.ipynb) to marimo notebooks (.py). Use when the user wants to migrate or convert a Jupyter notebook to marimo format.
---
# Jupyter to Marimo Conversion

Convert Jupyter notebooks to marimo format.

## Process

**ALWAYS run the CLI conversion first before reading any files.** Converted Python files are much smaller than raw `.ipynb` JSON, saving tokens.

### Step 1: Convert

```bash
uvx marimo convert <notebook.ipynb> -o <notebook.py>
```

### Step 2: Validate

```bash
uvx marimo check <notebook.py>
```

Fix any reported issues.

### Step 3: Clean Up

- Verify metadata block includes all required packages
- Remove Jupyter artifacts: `display()` calls, magic commands (`%`, `!`)
- Ensure final cell expressions are displayable (not indented/conditional)
- Replace ipywidgets with marimo equivalents:
  - `ipywidgets.IntSlider` → `mo.ui.slider()`
  - `ipywidgets.Dropdown` → `mo.ui.dropdown()`
  - `ipywidgets.Text` → `mo.ui.text()`
- Add `EnvConfig` widget if environment variables are needed

### Step 4: Final Verification

```bash
uvx marimo check <notebook.py>
```

Confirm no errors were introduced during cleanup.
