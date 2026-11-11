# Chat archive format (written from context)

Use when no native transcript exists (CORE-AUDIT). Save the result with `chat-save`: pass a file, or pipe it in with `-` (`.sh`) or `-Stdin` (`.ps1`).

**Header**
- Agent, provider, and model
- Start and end time
- Work item IDs
- AGENTS.md generation stamp
- Persona, if any
- Completeness: VERBATIM, PARTIAL (state what is missing), or RECONSTRUCTED (summarized from context)

**Body**
- Human prompts verbatim
- Agent responses verbatim, or as close as available
- Tool actions as commands and outcomes, not raw output
