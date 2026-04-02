# AGENTS.md

## Task Completion Requirements

The following command must pass before considering tasks completed:
```
pwsh -ExecutionPolicy Bypass -File .\Test-Ahk.ps1
```

## Project Overview

This project is split between AutoHotkey v1 and AutoHotkey v2 during an active migration.

- `my-autohotkey-scripts.ahk` is the canonical AutoHotkey v2 entrypoint.
- `my-autohotkeyv1-scripts/my-autohotkeyv1-scripts.ahk` is the deprecated AutoHotkey v1 entrypoint.
- The v1 tree is legacy code being migrated into v2 over time.

## V2 Layout

- `my-autohotkey-scripts/shared/` is for reusable v2 helpers.
- `my-autohotkey-scripts/hotkeys/` is for hotkey-driven behavior.
- `my-autohotkey-scripts/hotstrings/text/` is for text expansion hotstrings.
- `my-autohotkey-scripts/hotstrings/actions/` is for hotstrings that perform actions instead of emitting raw text.

## Migration Rules

- Prefer implementing new behavior in the v2 tree.
- Do not migrate v1 code unless the task explicitly calls for migration.
- If copying logic from v1, keep the v1 source intact unless the task explicitly calls for migration.
- Avoid adding new shared code to the v1 tree.

## Shared Helpers

- Reusable non-feature helpers belong in `my-autohotkey-scripts/shared/`.
- Root `Lib/` is reserved for v2 library files, not general feature helpers.

## AutoHotkey v2 Style

- Use same-line opening braces for normal code constructs such as `if`, `for`, `while`, `switch`, functions, and classes.
- Use next-line opening braces for hotkey and hotstring block bodies after `::`.

## Commit Messages

Use semantic commit messages when creating commits. Prefer a short type prefix followed by a concise summary.

Examples:
- `feat: add v2 hotkey for window snapping`
- `fix: correct clipboard restore logic`
- `docs: clarify migration guidance in AGENTS.md`
