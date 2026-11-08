---
id: PROV-COPILOT
summary: GitHub Copilot discovery and path-scoped instructions.
shim: Create .github/copilot-instructions.md containing "Follow AGENTS.md at the repository root."
---
# Provider: GitHub Copilot

- **Discovery.** Copilot reads `.github/copilot-instructions.md`; the coding agent and recent IDE builds also read `AGENTS.md`. Support varies by IDE and version; verify.
- **Path-scoped rules** go in `.github/instructions/*.instructions.md` with `applyTo` globs. They may tighten, never weaken, listed contracts.
- **Tuning.** Add rules only for problems observed in this project, each dated.
