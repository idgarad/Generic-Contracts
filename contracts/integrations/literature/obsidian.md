---
id: INT-OBSIDIAN
summary: Obsidian vault as home for premise, story bible, style sheet, and drafts.
requires: [INT-COMMON, LIT-CANON]
---
# Tool: Obsidian

- The vault holds the canonical records. Default map: `Premise.md`, a `Bible/` folder with one note per character, place, or rule, `Style Sheet.md`, `Manuscript/` with one note per chapter.
- Bible notes carry a `status` property: `canon`, `proposed`, `rejected`, or `open`. Only the author sets `canon`.
- Reference with `[[wikilinks]]` instead of copying facts between notes.
- Don't rename or move notes unless authorized. Obsidian fixes links only for renames made inside the app, so outside renames break links.
- Preserve frontmatter properties, tags, aliases, and block IDs.
- Never touch `.obsidian/` (settings, plugins, themes). Don't edit `.canvas` files unless asked.
- Daily notes and journals are private; read them only when asked.
