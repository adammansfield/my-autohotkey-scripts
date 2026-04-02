# TODO

## Migrate AHKv1 to AHKv2

### Completed Foundation

- [x] Restructure the repository so v2 is canonical and v1 lives under `my-autohotkeyv1-scripts/`
- [x] Relocate the current working v1 files into the legacy subtree
- [x] Create the empty v2 bootstrap under `Lib/` and `my-autohotkey-scripts/`
- [x] Add `my-autohotkey-scripts/shared/` for reusable v2 helpers
- [x] Add v2 `reload-ahk.ahk` as a copied replacement for the v1 reload hotkey
- [x] Add v2 `hotstrings/actions/t3code.ahk` for the T3 Code sidebar helper extracted from v1 `ai.ahk`
- [x] Add `Test-Ahk.ps1` and make it the required validation command

### Migration Completion Pattern

All `Verify` checklist items below are manual verification steps to be performed by the user after the code change is made.

For each v1 script below:

- [ ] Create the v2 destination file in the canonical tree
- [ ] Port syntax and replace v1-only helpers with v2/shared equivalents
- [ ] Wire the file into the correct v2 `index.ahk`
- [ ] Validate with `pwsh -ExecutionPolicy Bypass -File .\Test-Ahk.ps1`
- [ ] Ask the user to manually verify the change after the code update is made
- [ ] Remove the migrated file from the v1 `index.ahk` only after the user manually verifies the v2 version

### Wave 1: Easiest and Lowest-Risk Files

- [x] `my-autohotkeyv1-scripts/hotstrings/text/abbreviations.ahk`
  - [x] Port the two direct text expansions with no helper dependencies
  - [x] Verify `btw` and `brb`

- [x] `my-autohotkeyv1-scripts/hotkeys/capslock.ahk`
  - [x] Port `CapsLock::Esc` and `ToggleCapsLock()`
  - [x] Verify normal CapsLock and `Shift+CapsLock`

- [ ] `my-autohotkeyv1-scripts/hotkeys/audio.ahk`
  - [ ] Port volume hotkeys and microphone mute toggle
  - [ ] Verify the hardcoded microphone device name still works in v2

- [ ] `my-autohotkeyv1-scripts/hotkeys/display.ahk`
  - [ ] Port the registry toggle and tooltip behavior
  - [ ] Verify theme state tracking still matches the actual Windows theme after reload

- [ ] `my-autohotkeyv1-scripts/hotkeys/gnucash.ahk`
  - [ ] Port the `#if WinActive("GnuCash")` block to `#HotIf`
  - [ ] Verify the transaction hotkey still matches the assumed split-count workflow

### Wave 2: Shared Hotstring Helpers and Helper-Driven Text Files

- [ ] `my-autohotkeyv1-scripts/hotstrings/actions/etc.ahk`
  - [ ] Port `CtrlBackspaceThenSend`, `BackspaceThenSend`, and `SendNumberMinUntilHour`
  - [ ] Move these helpers into v2 locations that other text/action files can reuse
  - [ ] Verify OneNote/Slack backspacing timing still works

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/symbols.ahk`
  - [ ] Port Unicode symbol hotstrings after the helper functions exist in v2
  - [ ] Replace legacy `strlen` calls with `StrLen`
  - [ ] Verify representative checkmark, tree-branch, Greek, and non-breaking-space cases

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/languages.ahk`
  - [ ] Port the window-scoped language hotstrings after the helper functions exist in v2
  - [ ] Keep the console/devenv/Windows Terminal exclusions intact
  - [ ] Verify representative German, Bulgarian, Hebrew, and Serbian hotstrings

- [ ] `my-autohotkeyv1-scripts/hotstrings/actions/date.ahk`
  - [ ] Port timestamp hotstrings and helper functions `GetQuarterNumber()`, `GetWeekNumber()`, and `ToDeutschDay()`
  - [ ] Rework `SendStopWatch()` with v2 clipboard handling
  - [ ] Verify both pure text expansions and the spreadsheet stopwatch flow

### Wave 3: Markdown and Generic Text Expansion

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/markdown.obsidian.ahk`
  - [ ] Port the Obsidian-specific markdown overrides first
  - [ ] Preserve include order so Obsidian overrides still win over generic markdown hotstrings
  - [ ] Verify code-fence expansions in Obsidian

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/markdown.onenote.ahk`
  - [ ] Port the OneNote-specific markdown overrides after shared OneNote helpers are available
  - [ ] Port `OneNoteSendChainOfThought()`
  - [ ] Verify OneNote task and chain-of-thought hotstrings

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/markdown.ahk`
  - [ ] Port the generic markdown/task/code hotstrings
  - [ ] Port `SendChainOfThought()`
  - [ ] Verify that generic markdown still yields to the Obsidian and OneNote overrides

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/coding.ahk`
  - [ ] Port the mixed text-expansion and clipboard-based snippets
  - [ ] Replace `WinClip` paste flows with v2 clipboard helpers
  - [ ] Verify region/snippet insertion in editors that auto-complete aggressively

- [ ] `my-autohotkeyv1-scripts/hotstrings/text/autocorrect.ahk`
  - [ ] Prefer replacing this file with a known v2-compatible autocorrect source instead of hand-porting it
  - [ ] Diff the replacement against the current file and preserve any repo-specific edits
  - [ ] Enable only after the replacement passes validation in the v2 tree

### Wave 4: Mid-Complexity Hotkeys and Clipboard Utilities

- [ ] `my-autohotkeyv1-scripts/hotkeys/etc.ahk`
  - [ ] Port durable helpers such as `StringDedent()` and `StringUnescapeNewLine()`
  - [ ] Replace image clipboard operations with v2 equivalents
  - [ ] Decide whether one-off helpers like `ArchiveSwarmReview()` should be kept, moved, or dropped

- [ ] `my-autohotkeyv1-scripts/hotkeys/obsidian.ahk`
  - [ ] Port line-formatting hotkeys and the clipboard-preserving line capture flow
  - [ ] Re-test the workaround for untoggling formatted tasks in Obsidian
  - [ ] Verify interaction with Obsidian Vim mode and clipboard settings

- [ ] `my-autohotkeyv1-scripts/hotstrings/actions/ai.ahk`
  - [ ] Keep the existing v2 `t3code.ahk` subset and port only the remaining role-prompt hotstrings/functions
  - [ ] Replace `WinClip` prompt-paste logic with v2 clipboard helpers
  - [ ] Verify the remaining prompt helpers still paste correctly

- [ ] `my-autohotkeyv1-scripts/hotstrings/actions/codetags.ahk`
  - [ ] Port the mnemonic class and codetag emitters
  - [ ] Replace the clipboard-based paste path with v2 clipboard helpers
  - [ ] Preserve the `#if !WinActive("Remote Desktop Connection")` behavior

### Wave 5: OneNote-Heavy Shared Logic

- [ ] `my-autohotkeyv1-scripts/hotkeys/onenote.ahk`
  - [ ] Port line formatting hotkeys, markdown task toggling, paste-popup clearing, and timestamp recoloring
  - [ ] Reuse shared v2 helpers for delayed sends, clipboard restore, and OneNote HTML paste
  - [ ] Verify OneNote paste-popup handling still works after v2 migration

- [ ] `my-autohotkeyv1-scripts/hotstrings/actions/logging.ahk`
  - [ ] Extract reusable helpers first: `DelayedSend()`, `SendClearLine()`, `OneNotePaste()`, and `RoundMin()`
  - [ ] Port the simple log flows before the monthly-template and standup generators
  - [ ] Validate HTML paste, timestamp coloring, and clipboard preservation in OneNote before removing the v1 version

### Wave 6: Hardest and Most Stateful Files

- [ ] `my-autohotkeyv1-scripts/hotkeys/vim.ahk`
  - [ ] Port the `Vim` mode class and all mode-dependent hotkeys to v2 syntax
  - [ ] Rebuild the clipboard and HTML paste logic on top of migrated v2 helpers
  - [ ] Re-test the OneNote navigation workaround and visual-mode resets after every major step

- [ ] `my-autohotkeyv1-scripts/hotkeys/prototype.ahk`
  - [ ] Leave `AlertedReload()` as already copied into v2 and migrate only the remaining prototype utilities that are still useful
  - [ ] Decide whether `SplitSideMonitorWindows()`, `DumpBytesToFile()`, and the empty `PrototypeFunction()` still belong in the project
  - [ ] Remove dead prototype code instead of porting it if it no longer serves a real workflow

### Library Ports to Defer Until Needed

- [ ] Port only the v1 libraries actually required by migrated v2 files
  - [ ] `WinClip`
  - [ ] `winclipAPI`
  - [ ] `Speak`
  - [ ] `VistaAudioControl`
  - [ ] `consoleapp`
  - [ ] `ping`
  - [ ] `ExceptionHandler`

### Final Cleanup

- [ ] Empty the v1 `hotkeys/index.ahk`
- [ ] Empty the v1 `hotstrings/text/index.ahk`
- [ ] Empty the v1 `hotstrings/actions/index.ahk`
- [ ] Remove the legacy `my-autohotkeyv1-scripts/` subtree after all migrated files are verified in v2
