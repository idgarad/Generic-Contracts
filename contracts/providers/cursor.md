---
id: PROV-CURSOR
summary: Cursor discovery and rules.
shim: None needed (reads AGENTS.md). Optional .cursor/rules/*.mdc only for path-scoped tightening.
---
# Provider: Cursor

- **Discovery.** Cursor reads `AGENTS.md` and `.cursor/rules/*.mdc`. Keep rules files thin; they may tighten, never weaken, listed contracts.
- **Tuning.** Add rules only for problems observed in this project, each dated.
