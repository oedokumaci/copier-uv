---
name: release
description: Perform a copier-uv template release by updating the changelog, committing, tagging, and pushing. Use when the user asks to release, cut a release, bump the version, or publish a new version.
---
# Release Skill

Perform a full release for the copier-uv template.

## Process

1. Ensure you are on `main` and up to date:
   ```bash
   git checkout main
   git pull
   ```
2. Run the changelog command to auto-determine the next version:
   ```bash
   make changelog
   ```
3. Read `CHANGELOG.md` and extract the new version number from the latest heading.
4. Present the changelog diff to the user for review. **Wait for user approval before continuing.**
5. Run the release with the determined version:
   ```bash
   make release version=X.Y.Z
   ```
   This stages `CHANGELOG.md`, commits as `docs: Update changelog for version X.Y.Z`, creates an annotated tag, and pushes both commit and tag.

## Important

- **Always wait for user approval** after showing the changelog diff before running `make release`.
- The version should NOT have a `v` prefix (e.g., `0.5.0` not `v0.5.0`).
- Only changelog-relevant commit types appear: `build`, `deps`, `feat`, `fix`, `refactor`.
- If there are no releasable commits since the last tag, inform the user and stop.
- This is a Copier template, not a Python package — there is no `__init__.py` to update.
