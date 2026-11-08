---
id: PROV-DEEPSEEK
summary: DeepSeek models used through a third-party harness or chat.
shim: Depends on the harness; ensure it loads AGENTS.md (e.g. Aider: --read AGENTS.md).
---
# Provider: DeepSeek

- **Discovery.** DeepSeek models run inside another harness (IDE extension, CLI agent) or chat. Follow that harness's instruction-file rules and confirm `AGENTS.md` is loaded; in chat, attach it and the listed contracts.
- **Tuning.** Add rules only for problems observed in this project, each dated.
