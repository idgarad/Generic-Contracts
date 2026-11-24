# Chat archive format (written from context)

At the first checkpoint, cover the conversation from its start. At each later checkpoint, cover only exchanges after the last successful save for this conversation. For recovery, follow predecessor links and read oldest first. A full earlier archive can serve as the first link.

Save each segment with `chat-save` under the current agent's name (`-a` or `-Agent`). Pass a file, or pipe it in with `-` (Bash) or `-Stdin` (PowerShell). Use the returned archive path for links. If nothing has changed, reference the last successful save.

**Header**
- Agent, provider, and model
- Segment start and end time
- Previous archive: exact project-relative path or bound evidence reference, or NONE at conversation start. If a predecessor is missing, mark the gap and its extent as PARTIAL.
- Work item IDs
- AGENTS.md generation stamp
- Persona, if any
- Completeness of this segment: VERBATIM, PARTIAL (state what is missing), or RECONSTRUCTED (summarized from context)

**Body**
- Human prompts verbatim
- Agent responses verbatim, or as close as available
- Tool actions as commands and outcomes, not raw output
