---
id: PROV-OPENAI
summary: ChatGPT / OpenAI Codex discovery and usage notes.
shim: None for Codex (reads AGENTS.md). For ChatGPT, attach AGENTS.md and contracts/ to the Project.
---
# Provider: OpenAI (ChatGPT, Codex)

- **Discovery.** Codex reads `AGENTS.md` from the repository root down to the working directory; closer files govern their subtree. ChatGPT without repository access sees only what is attached: add `AGENTS.md` and the listed contracts to the Project files.
- **Tuning.** Add rules only for problems observed in this project, each dated.
