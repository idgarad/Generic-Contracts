---
id: MA-ASSIGN
summary: How to split work across agents and match agents to roles.
requires: [MA-COORD]
---
# Work assignment

**Split by** independent outcomes with clear boundaries (component, chapter, document), not by steps within one file. Parallelize only where leases don't overlap.

**Default pattern**
1. Planner (human or senior agent): increment, criteria, leases.
2. Makers: produce within leases.
3. Checker (a different agent): review or test against criteria.
4. Integrator: merge, reconcile records, report.

Makers report to the planner or integrator, not along a chain of agents; hierarchical teams degrade least when one agent errs.

**Matching agents to roles.** Record in `docs/workflow.md`:

| Role | Agent | Basis |
|---|---|---|
| e.g. ROLE-SENIOR-DEV | <agent> | <observed result in this project> |

- Assign on observed results in this project, not reputation. Revise when evidence changes.
- The checker SHOULD use a different provider or model than the maker; models rate their own output higher.
- When comparing alternatives, judge against stated criteria, evaluate them in both orders, and don't favor length.
- When several agents judge the same question, each records its answer before seeing the others'; agents conform to a visible majority. Combine answers by vote against the criteria; extra debate rounds rarely beat the vote. Agreement between agents is not evidence (CORE-COMPLETION).
- Give cheaper or faster agents bounded, well-specified tasks. Reserve stronger agents for design, review, and ambiguous work.
