---
id: INT-GITLAB
summary: GitLab issues, merge requests, and pipelines.
requires: [INT-COMMON]
---
# Tool: GitLab

- **Issues** are the work authority when bound. Use existing labels, milestones, and boards; don't create new ones.
- **Merge requests:** one increment per MR. Description states outcome, linked issue, checks and results, status, limitations. Use closing patterns (`Closes #n`) only when authorized to close the issue.
- Never merge, approve your own MR, force-push protected branches, or change CI/CD variables, protected branches, or approval rules.
- **Pipelines** are evidence: report the pipeline URL and result per job that matters.
- Use `glab` or the configured connector.
