---
name: docs-deploy
description: Deploy the documentation site to GitHub Pages. Use when the user asks to deploy docs, publish docs, or update the docs site.
---
# Docs Deploy Skill

Deploy the copier-uv template documentation to GitHub Pages.

## Process

1. Ensure you are on `main` and up to date:
   ```bash
   git checkout main
   git pull
   ```
2. Deploy the docs:
   ```bash
   make docs-deploy
   ```
   This runs `mkdocs gh-deploy`, which builds the docs and pushes them to the `gh-pages` branch.

3. Inform the user the docs have been deployed.

## Important

- Always ensure you're on `main` with a clean working tree before deploying.
- If there are uncommitted changes, warn the user and ask whether to proceed.
