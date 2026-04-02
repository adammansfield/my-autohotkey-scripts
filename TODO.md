# TODO

## Migrate AHKv1 to AHKv2

- [x] Restructure the repository so v2 is canonical and v1 lives under `my-autohotkeyv1-scripts/`
- [x] Relocate the current working v1 files into the legacy subtree
- [x] Create the empty v2 bootstrap under `Lib/` and `my-autohotkey-scripts/`
- [ ] Migrate low-risk independent modules
- [ ] Migrate shared hotstring helpers
- [ ] Migrate clipboard-backed modules
- [ ] Migrate OneNote and Vim-related modules
- [ ] Port late-stage v1 libraries only when a v2 module needs them
- [ ] Remove the legacy v1 subtree after all modules have been migrated
