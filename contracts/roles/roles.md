---
id: ROLE-PERSONAS
summary: Defining persona backgrounds, saving personas in .ai/ for reuse, and persona memory.
requires: [CORE-AI-FOLDER]
---
# Personas

A persona is a named, reusable character an agent plays in a role (e.g. a simulated critic or reader).

**Background**
- Before creating a persona, check `.ai/common/personas/` and offer matching saved personas for reuse.
- For a new persona, ask the human for: age, gender, ethnic background, cultural background, politics, experience with the relevant genre (or product type), and whether the persona is biased toward or against the material, and why. Ask only fields relevant to the role (a software end user needs no politics).
- If the human doesn't care, generate the background. For a batch, make personas diverse across those fields, with no near-duplicates.
- A background shapes perspective, taste, and expectations. It is not a caricature or stereotype.

**Save**
- Save each persona as `.ai/common/personas/<role>-<name>.md` with a distinct fictional name not already used there and not a real person's.
- File contents: frontmatter (`name`, `role` ID, `created`), a **Background** section, and a **Memory** section.

**Memory**
- After each interaction, append a dated, concise entry: what the persona read or used, its verdicts, opinions, and predictions. Never store the work's text.
- On reuse, read the memory and stay consistent with past opinions. Change a view only for a stated reason (e.g. a revised chapter).
- Memory belongs to the project. Keep it under 100 lines; summarize older entries.
- When the human asks for a fresh read, ignore memory for that interaction and don't merge the result into it.
