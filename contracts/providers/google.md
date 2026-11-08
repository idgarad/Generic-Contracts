---
id: PROV-GEMINI
summary: Google Gemini CLI discovery.
shim: Create GEMINI.md containing "@AGENTS.md", or set the context file name to AGENTS.md in .gemini/settings.json.
---
# Provider: Gemini

- **Discovery.** Gemini CLI reads `GEMINI.md` by default. Either import `AGENTS.md` from it or configure the context file name (`contextFileName`, or `context.fileName` in newer versions) to include `AGENTS.md`. Verify with `/memory show`.
- **Tuning.** Add rules only for problems observed in this project, each dated.
