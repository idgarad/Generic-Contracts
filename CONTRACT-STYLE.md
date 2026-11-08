# Writing contracts

Goal: the fewest tokens that still change behavior.

- **Frontmatter:** `id`, `summary` (15 words or fewer; shown in the picker and in AGENTS.md), `requires` (list of IDs), `shim` for providers only, and `domain` (`software`, `literature`, `any`) only when the folder doesn't already imply it.
- One contract, one subject. Target 40 lines or fewer; core stays under 150 lines total.
- Define terms only in `CORE-TERMS`; elsewhere just use them. Refer to other contracts by ID, never by section number.
- State each rule once. If two contracts need it, put it in the more general one and `require` that.
- Imperative bullets. Use MUST/SHOULD/MAY only where the force matters.
- Rules only: no rationale paragraphs, history, or examples unless the example *is* the rule.
- Lower layers (domain, role, provider) may tighten rules, never weaken them.
- Include only what an agent can't discover from the repository or reliably do by default. Every line in an always-loaded contract costs tokens in every session, and longer inputs measurably degrade reasoning (see [docs/optimization-pass-1.md](docs/optimization-pass-1.md)).
- Put setup-only material (one-time configuration) in a "when relevant" contract, not in core.
- Add a rule for a known model failure only with a cited source or an observed, dated incident.
- No vendor names outside `providers/`.
- Role contracts use: **Mission**, **May**, **Must not**, **Output**, and **Done when** if needed.
