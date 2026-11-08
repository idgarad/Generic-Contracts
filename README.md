# Generic Contracts

Modular instruction contracts for AI agents. A project's `AGENTS.md` only lists which contracts apply, and agents load just those. Definitions live in one place (`CORE-TERMS`) and each rule is stated once, which keeps context small across a project. Customize freely.

## Layout

```text
contracts/
  core/         always loaded: terms, principles, authority, evidence, completion, .ai folder, chat audit
  organization/ company.md: fill-in template for one employer's rules (always loaded when chosen)
  workflow/     binding, planning, records, agent state, workspace, enterprise
  software/     design, engineering, repository, testing, security, ops, lifecycle, docs
  literature/   canon, creative control, manuscript, quality, originality
  integrations/ tool rules: software/ (Jira, Confluence, GitHub, GitLab, Azure DevOps),
                literature/ (Obsidian, OneNote, Scrivener, Word, Google Docs), general/ (Notion)
  multi-agent/  coordination, assignment
  roles/        software/, literature/, simulated/ (used only when assigned)
  providers/    anthropic, openai, copilot, google, cursor, deepseek
tools/new-agents.sh, tools/new-agents.ps1
```

## Build a project's AGENTS.md

```sh
bash tools/new-agents.sh [output-dir]
```

Windows (PowerShell 5.1 or 7+):

```powershell
powershell -ExecutionPolicy Bypass -File tools\new-agents.ps1 [-OutDir path]
```

The first question (software, literary, both, or neither) filters every later menu, so you only see relevant contracts, roles, and tools. A literary project gets 4 prompts plus 4 menus; enterprise scale is asked only for software. The script writes one file, `<YYYYMMDDTHHMMSS>-AGENTS.zip`. Unzip it at the project root to get `AGENTS.md` and `contracts/`, containing only the selected contracts and their dependencies.

It then prints any provider shim to create (e.g. `CLAUDE.md` containing `@AGENTS.md`).

## Rules for the system

- Precedence: tool/system instructions > core > organization > workflow > domain > tools > multi-agent > role > provider. Lower layers may tighten, never weaken.
- Menu filtering: a contract's domain is inferred from its folder (`software`, `literature`, otherwise any). Override it with a `domain:` frontmatter field, as the literary-only simulated personas do.
- `contracts/` in a project is reserved for these contracts. Software interface definitions go in `interfaces/`.
- Don't name a contract file after an agent instruction file (`claude.md`, `gemini.md`, `agents.md`). Case-insensitive file systems make agents auto-load it.
- Evidence behind contract wording: [docs/optimization-pass-1.md](docs/optimization-pass-1.md).
- To add a contract, drop a `.md` file with frontmatter into the right folder; the script picks it up. Files starting with `_` are hidden from menus and included only through `requires`. See [CONTRACT-STYLE.md](CONTRACT-STYLE.md).
