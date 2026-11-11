---
id: CORE-AUDIT
summary: Archive agent chats as an audit trail of what was asked, decided, and produced.
requires: [CORE-AI-FOLDER, CORE-EVIDENCE]
---
# Chat archive (audit trail)

Archive chats whenever possible, so questions about what was asked, decided, and AI-produced (creative control, authorship, change history) can be answered later.

- **Where:** `.ai/archive/<agent>/<YYYYMMDDTHHMMSS>-<topic>.<ext>.gz` (gzip-compressed), or the evidence location named in the binding (WF-BINDING).
- **When:** at the end of each session or increment, at handoff, before context is compacted or cleared where the tool allows, and whenever the human says "save chat".
- **How:** run `tools/chat-save.sh` (or `.ps1`). It copies the native transcript where it can find one (Claude Code, Codex); otherwise pass it a file or stdin. Duplicate copies are fine; never overwrite. `chat-check` verifies archiving works.
- **Written from context** (no native transcript): follow `tools/archive-format.md`.
- Never fabricate or embellish an archive. Label gaps; never present a summary as verbatim.
- Redact secrets, credentials, and unauthorized sensitive data, marking each `[REDACTED: reason]`.
- Archives are append-only. Never edit or delete one except to redact; add corrections as a dated note.
- Archives are exempt from WF-STATE budgets and temporary-retention cleanup. Keep them for the life of the project unless the binding sets another retention.
- Link archives from the records they support: work items, ADRs, AI-drafted passage records, persona memory.
- If a session can't be archived, record that and why in `.ai/common/handoff.md`.
