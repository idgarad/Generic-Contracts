# Writing contracts

Goal: the fewest tokens that still change behavior.

- **Frontmatter:** `id`, `summary` (15 words or fewer; shown in the picker and in AGENTS.md), `requires` (list of IDs), `shim` for providers only, and `domain` (`software`, `literature`, `any`) only when the folder doesn't already imply it.
- One contract, one subject. Target 40 lines or fewer; core stays under 150 lines total.
- Define terms only in `CORE-TERMS`; elsewhere just use them. Refer to other contracts by ID, never by section number.
- State each rule once. If two contracts need it, put it in the more general one and `require` that.
- Imperative bullets. Use MUST/SHOULD/MAY only where the force matters.
- Rules only: no rationale paragraphs, history, or examples unless the example *is* the rule.
- Lower layers (domain, role, provider) may tighten rules, never weaken them.
- No vendor names outside `providers/`.
- Role contracts use: **Mission**, **May**, **Must not**, **Output**, and **Done when** if needed.
