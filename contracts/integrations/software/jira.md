---
id: INT-JIRA
summary: Jira as the work authority: issues, statuses, links, and evidence.
requires: [INT-COMMON, WF-RECORDS]
---
# Tool: Jira

- An issue is a work record; the issue key is its stable ID. Outcome and acceptance criteria live in the issue (or its criteria field), not in the repository.
- Epics and roadmap items are intent, not authorization. Work only issues the human selected.
- Create sub-tasks only for the active increment.
- Transition status only along the project workflow and only with evidence. Never set a resolution or status meaning accepted; that is the owner's.
- Reference the issue key in branches, commits, and PR titles. Add a concise evidence comment (checks, results, links), not raw logs.
- Never change sprints, priority, assignee, or fix version unless asked.
