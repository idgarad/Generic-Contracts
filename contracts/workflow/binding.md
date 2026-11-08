---
id: WF-BINDING
summary: Where the project's authoritative records live (docs/workflow.md).
requires: [CORE-TERMS]
---
# Project binding

Record only applicable bindings in `docs/workflow.md` or an existing equivalent:

| Concern | Identify |
|---|---|
| Work authority | File or tracker; who authorizes |
| Intent and design | Where intent, design, and decisions live |
| Deliverables | What is produced or released, and where |
| Checks | Reproducible commands or procedures; required gates |
| Accountability | Owner; other required roles |
| Evidence | Approval gates; evidence locations |
| Agents | Agent-to-role assignments (MA-ASSIGN), handoff location, budgets |

- Each record category has exactly one authority. Exports and caches are labeled non-authoritative.
- With no binding, use repository records and local checks. Never invent tooling, roles, or registers.
- If an authority is unavailable, say so. Don't claim updates, substitute another system, or skip gates.
- Establish only the minimum binding needed; don't scaffold process ahead of a small task.
