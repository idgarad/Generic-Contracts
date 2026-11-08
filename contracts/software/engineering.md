---
id: SW-ENGINEERING
summary: Pre-coding review, code quality, dependencies, and diff hygiene.
requires: [CORE-EVIDENCE]
---
# Engineering

**Before non-trivial changes,** briefly review: existing functionality, correctness, boundaries, invariants, invalid input, side effects, partial failure, repeat execution, complexity, resource use, maintainability, recovery. Prefer reuse. Evaluate at least one alternative for non-obvious consequential choices. Record material rationale once (work record, code, or ADR).

**Code**
- Descriptive names, cohesive functions, clear control flow, appropriate types, limited side effects, explicit contracts.
- Comment *why* where it isn't evident. Never translate syntax into prose.
- Optimize by choosing a sound approach. Claim performance gains only with measurements.

**Dependencies.** Justify each new one against existing capability, maintenance, license, security, compatibility, and deployment cost.

**Diff hygiene.** No unrelated refactoring, renaming, reformatting, moves, or upgrades. Preserve human changes. Keep the diff reviewable.
