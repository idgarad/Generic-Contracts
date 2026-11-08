---
id: INT-AZURE-DEVOPS
summary: Azure DevOps Boards, Repos, Pipelines, and Wiki.
requires: [INT-COMMON, WF-RECORDS]
---
# Tool: Azure DevOps

- **Boards:** a work item is a work record; its ID is the stable ID. Epics and features are intent, not authorization. Create child tasks only for the active increment.
- Change state only along the process workflow and only with evidence. Never set Closed or Done meaning accepted; that is the owner's.
- Never change area path, iteration, priority, or assignment unless asked.
- **Repos:** one increment per PR, linked to its work item (`AB#id`). Never complete your own PR, bypass policies, or change branch policies.
- **Pipelines** are evidence: report the run URL and result. Never edit variable groups, service connections, or secrets.
- **Wiki** pages are canonical when bound. Edit in place; never delete and recreate or restructure.
