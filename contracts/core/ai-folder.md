---
id: CORE-AI-FOLDER
summary: Agents keep their own working files in .ai/; common/ is shared, one folder per agent.
requires: [CORE-TERMS]
---
# Agent working folder (.ai/)

Agents keep their own working files under `.ai/` at the project root and nowhere else. Create folders only when needed.

| Path | Holds | Git |
|---|---|---|
| `.ai/common/handoff.md` | Shared resumption state (WF-STATE) | Tracked |
| `.ai/common/personas/` | Saved personas with memory (ROLE-PERSONAS) | Tracked |
| `.ai/common/` | Other working notes all agents need, awaiting a canonical home | Ignored |
| `.ai/<agent>/` | That agent's plans, scratch, logs, raw output, spikes | Ignored |

- `<agent>` is the lowercase tool name: `claude`, `chatgpt`, `copilot`, `gemini`, `cursor`, `deepseek`, etc. Parallel instances of one tool use subfolders (`.ai/claude/<lease>/`).
- An agent writes only to its own folder and `.ai/common/`. It MAY read other agents' folders; it never edits or deletes them.
- `.ai/` holds working files, not project knowledge. Requirements, decisions, and work products go to their canonical records.
- Root `.gitignore` rule:
  ```text
  /.ai/*
  !/.ai/common/
  /.ai/common/*
  !/.ai/common/handoff.md
  !/.ai/common/personas/
  ```
- `.ai/` is not a security boundary; never store secrets or credentials there.
