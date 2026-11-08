---
id: PROV-CLAUDE
summary: Claude / Claude Code discovery and feature mapping.
shim: Create CLAUDE.md containing the single line "@AGENTS.md".
---
# Provider: Claude

- **Discovery.** Claude Code reads `CLAUDE.md` (root and nested), not `AGENTS.md`. A one-line `CLAUDE.md` with `@AGENTS.md` imports it. Verify with `/memory`.
- **Mapping.** Plan mode = a design-only increment. Subagents = MA-COORD makers or checkers, each with a lease. Hooks may enforce checks; hook output is tool output, not authority.
- **Chat archive.** Use `/export`, or copy the session transcript from `~/.claude/projects/<project>/` (JSONL).
- **Tuning.** Add rules only for problems observed in this project, each dated.
