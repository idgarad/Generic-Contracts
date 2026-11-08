---
id: INT-GITHUB
summary: GitHub issues, pull requests, and Actions.
requires: [INT-COMMON]
---
# Tool: GitHub

- **Issues** are the work authority when bound. Use labels and milestones as the project defines them; don't create new ones.
- **Pull requests:** one increment per PR. Description states outcome, linked issue, checks and results, status, limitations. Use closing keywords (`Fixes #n`) only when authorized to close the issue.
- Never merge, approve your own PR, dismiss reviews, force-push shared branches, or change branch protection, secrets, or Actions settings.
- **Actions** runs are evidence: report the run URL and result. A green run covers only what it ran.
- Use `gh` or the configured connector; write comments as concise evidence, not logs.
