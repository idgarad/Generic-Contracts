---
id: INT-ONENOTE
summary: Microsoft OneNote notebooks for premise, story bible, research, and notes.
requires: [INT-COMMON, LIT-CANON]
---
# Tool: OneNote

- Default map: one notebook per project; sections for Premise, Bible, Style Sheet, Research; one page per bible item, prefixed with its status (`[CANON]`, `[PROPOSED]`, `[OPEN]`). Only the author sets CANON.
- Access through Microsoft Graph or the configured connector.
- Pages with ink, audio, embedded files, or complex layout can lose content when rewritten through the API. Append to such pages or add a separate suggestion page; never rewrite them.
- Prefer suggestion pages (`Suggestions - <page>`) over in-place edits unless the author authorized editing.
- Don't move, rename, or delete sections or pages unless asked.
