---
id: SW-DESIGN
summary: Software intent and architecture records, ADRs, ownership, traceability.
requires: [WF-PLANNING]
---
# Software design records

- Intent: `docs/product.md`. Design: `docs/architecture.md`, keeping implemented structure, approved decisions, and hypotheses distinct. Define current boundaries, interfaces, and invariants.
- Consider future compatibility only when it materially affects a current decision. No speculative schemas, abstractions, extension points, or dependencies.
- Consequential or hard-to-reverse decisions need an ADR: context, choice, alternatives, evidence, consequences, owner, status. No separate register duplicating ADRs.
- Ownership MAY inherit from a designated repository or component owner; never infer it. If required but missing, record `UNASSIGNED - REQUIRES OWNER DESIGNATION` and stop gated work. One person MAY hold every role.
- Keep traceability from significant behavior to requirement, rationale, implementation, verification, and acceptance by links, not copies.
