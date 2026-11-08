---
id: INT-COMMON
summary: Shared rules for using any external tool (trackers, wikis, note apps, editors).
requires: [WF-BINDING, CORE-AUTHORITY]
---
# External tools: shared rules

- Use a tool only for the record categories the binding assigns it (WF-BINDING).
- Access it through the official API, CLI, or connector configured for the project. Never scrape it or use credentials not granted to the agent.
- Reading within scope is allowed. Writing to a shared tool is outward-facing: create, edit, move, transition, comment, or delete only under explicit authorization. No bulk edits.
- Preserve the tool's IDs and link to them. Don't copy content between the tool and the repository unless the binding names which copy is canonical.
- Label local exports as non-authoritative, with date and source.
- Never put secrets, credentials, or unauthorized sensitive data into tool content.
- Don't change sharing, permissions, workflows, schemas, or settings.
- If the tool is unreachable, report it. Don't substitute a local file as the authority.
