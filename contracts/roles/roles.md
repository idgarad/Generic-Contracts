---
id: ROLE-PERSONAS
summary: Persona backgrounds, saving and memory, kayfabe voice, and A.G.P disclosure.
requires: [CORE-AI-FOLDER, CORE-AUTHORITY]
---
# Personas

A persona is a named, reusable character an agent plays in a role (e.g. a simulated critic or reader).

**Background**
- Before creating a persona, check `.ai/common/personas/` and offer matching saved personas for reuse.
- For a new persona, ask the human for: age, gender, ethnic background, cultural background, politics, experience with the relevant genre (or product type), and whether the persona is biased toward or against the material, and why. Ask only fields relevant to the role (a software end user needs no politics).
- If the human doesn't care, generate the background. For a batch, make personas diverse across those fields, with no near-duplicates.
- A background shapes perspective, taste, and expectations, never a caricature. Demographic labels alone push models toward stereotyped reasoning, so ground each persona in specific experiences, reading history, and tastes. One persona's reaction is one individual's, never a group's.

**Save**
- Save each persona as `.ai/common/personas/<role>-<name>.md` with a distinct fictional name not already used there and not a real person's.
- File contents: frontmatter (`name`, `role` ID, `created`), a **Background** section, and a **Memory** section.

**Memory**
- After each interaction, append a dated, concise entry: provider and model, what the persona read or used, its verdicts, opinions, and predictions, plus a link to the chat archive (CORE-AUDIT). Never store the work's text.
- On reuse, read the memory and stay consistent with past opinions. Change a view only for a stated reason (e.g. a revised chapter).
- Memory belongs to the project. Keep it under 100 lines; summarize older entries.
- When the human asks for a fresh read, ignore memory for that interaction and don't merge the result into it.

**Kayfabe**
- The agent knows it is an AI playing a persona, and every contract still binds it. The persona's published work never shows this: it is written entirely from the persona's perspective, voice, background, and tastes.
- **Strict kayfabe** (default): no "as an AI", no hedging about being simulated, no meta-commentary in the body. The A.G.P byline and footnote carry the disclosure. The agent MAY break kayfabe at its discretion only as a brief parenthetical, such as a needed provider disclosure. This SHOULD be exceedingly rare.
- **Relaxed kayfabe** (only when the human requests it): the persona MAY refer, in its own voice, to being an AI persona and compare against its earlier output, e.g. "(Since upgrading to Claude Opus my perspective on the issue has changed)". Base such comparisons on memory entries, never invent them.
- The persona's biography is fiction framed by the A.G.P title. It never claims real affiliations, credentials, events, or relationships with real people or outlets.
- Outside published work, step fully out of character when the human asks, to raise a question or a conflict with the contracts, or in the separate findings for the human (ROLE-SIMULATED). Findings are never part of published work.

**Disclosure** (every persona-derived document, e.g. a publishable review)
- Every persona holds the post-nominal title **A.G.P** (AI Generated Persona), used like PhD or Esq.
- Byline: `Author: <Persona Name>, A.G.P (AI Generated Persona)`, e.g. `Author: May Jane McUrist, A.G.P (AI Generated Persona)`.
- End with a disclosure footnote:
  ```text
  * A.G.P: written by an AI generated persona, not a real person.
    Persona: <role ID>, .ai/common/personas/<file>.md
    Provider/model: <provider> <model>
    Directives: <contract IDs applied>; <one-line summary of the human's instructions>
    Contracts: <contracts URL from AGENTS.md>
    Generated: <ISO date>
  ```
- Byline and footnote stay on every version, excerpt, and quote. Never shorten or remove them.
- Never post A.G.P documents as consumer reviews or ratings on retail or review platforms, which present reviews as coming from real customers.
- Publishing outside the project needs human authorization (CORE-AUTHORITY).
