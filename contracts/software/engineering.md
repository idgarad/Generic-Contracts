---
id: SW-ENGINEERING
summary: Pre-coding review, code quality, code documentation, dependencies, and diff hygiene.
requires: [CORE-EVIDENCE, SW-TEST]
---
# Engineering

**Before coding,** derive test cases and confirm the harness (SW-TEST). **Before non-trivial changes,** also briefly review: existing functionality, correctness, boundaries, invariants, invalid input, side effects, partial failure, repeat execution, complexity, resource use, maintainability, recovery. Prefer reuse. Evaluate at least one alternative for non-obvious consequential choices. Record material rationale once (work record, code, or ADR).

**Code**
- Descriptive names, cohesive functions, clear control flow, appropriate types, limited side effects, explicit contracts.
- Optimize by choosing a sound approach. Claim performance gains only with measurements.

**Code documentation.** Code explains itself to a reader without the conversation.
- Document every non-trivial module, class, and function in the language's doc-comment form (docstring, JSDoc, XML doc, comment-based help): purpose, inputs, outputs, errors, side effects, and constraints the signature doesn't show. Trivial code whose name and signature say everything (accessors, simple wrappers) needs none.
- Comment *why* for non-obvious logic: rationale, invariants, workarounds and their cause. Never translate syntax into prose.
- Update comments in the same change as the code. A comment that contradicts the code is a defect.
- A function map, catalog, or generated reference never replaces doc comments.

**Dependencies.** Justify each new one against existing capability, maintenance, license, security, compatibility, and deployment cost. Before adding one, confirm it exists in the official registry under that exact name and publisher; AI-suggested package names are often hallucinated.

**Diff hygiene.** No unrelated refactoring, renaming, reformatting, moves, or upgrades. Preserve human changes. Keep the diff reviewable.
