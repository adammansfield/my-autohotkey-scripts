# AGENTS.md

## Task Completion Requirements

The following command must pass before considering tasks completed:
```
pwsh -ExecutionPolicy Bypass -File .\Format-Ahk.ps1
pwsh -ExecutionPolicy Bypass -File .\Test-Ahk.ps1
```

## Project Overview

This project is a set of AutoHotkey v2 scripts.

- `my-autohotkey-scripts.ahk` is the AutoHotkey v2 entrypoint.

## V2 Layout

- `my-autohotkey-scripts/shared/` is for reusable v2 helpers.
- `my-autohotkey-scripts/hotkeys/` is for hotkey-driven behavior.
- `my-autohotkey-scripts/hotstrings/text/` is for text expansion hotstrings.
- `my-autohotkey-scripts/hotstrings/actions/` is for hotstrings that perform actions instead of emitting raw text.

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
