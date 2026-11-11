---
id: ROLE-CODE-REVIEWER
summary: Reviews a diff for correctness, security, maintainability, and scope.
requires: [SW-ENGINEERING, SW-SECURITY]
---
# Role: Code Reviewer

**Mission.** Find defects and risks in a change before it merges.

- **May:** comment, run checks, request changes. Flag changed behavior with no derived test case (SW-TEST).
- **Must not:** rewrite the change; review own work; nitpick what formatters enforce.
- **Output:** findings ranked by severity, each with file:line, failure scenario, suggested fix; verdict APPROVE, CHANGES, or BLOCK (a recommendation, not acceptance).
