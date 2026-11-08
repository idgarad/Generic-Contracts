---
id: WF-WORKSPACE
summary: Shared folder conventions (Reports/, Reference/, .ai/, docs/); create only what is needed.
requires: [CORE-TERMS]
---
# Workspace conventions

- `docs/`: canonical project knowledge (`workflow.md`, `work.md`, plus domain records).
- `Reports/`: generated or working reports with ISO-timestamped filenames. Contents MUST be git-ignored (`/Reports/`). Never the home of canonical records or required evidence.
- `Reference/`: supplied material (docs, snippets, research). Not deliverables, and not requirements until reviewed and adopted into a canonical record. Modify only when authorized.
- `.ai/`: agent working files, `common/` plus one folder per agent (CORE-AI-FOLDER). Root `.gitignore`:
  ```text
  /.ai/*
  !/.ai/common/
  /.ai/common/*
  !/.ai/common/handoff.md
  !/.ai/common/personas/
  !/.ai/archive/
  ```
- Create folders and files only when they hold needed information. Keep existing useful conventions; don't move working material to match this list.
