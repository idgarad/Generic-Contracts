---
id: WF-STATE
summary: Agent handoff, temporary state, memory limits, and retention budgets.
requires: [CORE-TERMS, CORE-AI-FOLDER]
---
# Agent state

Classify records by purpose, not author. AI-written requirements are project knowledge, not agent memory.

- **Handoff**: `.ai/common/handoff.md`, one file updated in place, 200 lines or fewer. Active work reference, last verified state, blockers, next action, links. No copies of requirements, tasks, or criteria.
- Reconcile the work authority and handoff with reality at authorization, pause, resume, completion, and acceptance. On resume, check current state; don't replay stale plans.
- **Temporary state** (plans, logs, raw output, scratch) goes in the agent's own `.ai/<agent>/` folder (CORE-AI-FOLDER). Defaults: 50 MiB total under `.ai/`, 7-day retention. Before exceeding a budget, report and propose a fix; never relocate files to evade it.
- Agent memory never sets requirements, approves decisions, widens scope, or overrides records or evidence.
- Before discarding temporary state, move anything consequential to its canonical record. Findings must stay actionable without ignored files: keep reproduction, expected vs actual, provenance.
- Delete only positively identified disposable artifacts. Never delete required evidence, human work, or a sole decision record.
- No per-session memory archives, repository snapshots, or auto-committed logs or transcripts. Version control holds history.