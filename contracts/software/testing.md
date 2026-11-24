---
id: SW-TEST
summary: Test strategy before code; standards, self-reporting tests, release separation, defects, test cases.
requires: [CORE-EVIDENCE, WF-RECORDS, SW-OPS]
---
# Testing

**Test strategy precedes coding.** Before writing code for a change, derive its test cases from the acceptance criteria: applicable normal, boundary, invalid-input, failure, regression, state-transition, and idempotency cases. Record them as proposed in the work record. Scale to the change: a one-line fix may need one case.
- Confirm a harness can run them before coding. If none can, set up the minimum one first (dependencies per SW-ENGINEERING) or report the gap; don't code ahead of it.
- Where practical, implement the cases first and confirm new ones fail for the expected reason. A test that passes before the change proves nothing about it.
- Cases found during coding are added to the record, not silently folded in. Never shape cases to fit code already written.

**Standards**
- For each material acceptance criterion: an observable result and a check that distinguishes compliance from a plausible failure. When timing, concurrency, quantities, isolation, or resource release matter, assert them directly; elapsed time or an unrelated final result is insufficient. Justify tolerances.
- Check risky test infrastructure with a deliberately failing or fault-injected case.
- Never delete valid tests, weaken assertions, change expected values to hide defects, or silently skip failures. Requirement changes explain affected test changes.
- Distinguish real execution, simulated time, mocks, and inspection; claim only what each proves.
- Provide reproducible local build and test commands plus required pipeline checks, as the project justifies.
- Coverage is evidence, not proof. Use risk-based gates; no arbitrary percentages or filler tests.

**Self-reporting.** Every test reports its own outcome, so results can be traced without a harness.
- Log each result, passes as well as failures: test name, the case or requirement it verifies, PASS or FAIL, and on failure expected vs actual.
- Every test entry point exits non-zero on any failure.
- Where a harness exists, use its reporter (e.g. JUnit XML, TAP); don't add parallel custom logging.
- Unless the binding names a location, log to stdout and to a timestamped file in `Reports/`. Never log secrets (SW-SECURITY).
- Capture verbose output outside model context. Read the runner's exit status, totals (including skips), and relevant failure excerpts first. Inspect the full report when diagnosis or a criterion requires it. Missing or incomplete results need investigation before claiming PASS.

**Release separation.** Unless the work record or binding requires otherwise, production builds and release artifacts contain no test code: tests, fixtures, mocks, test data, test-only flags, hooks, or endpoints, or test logging.
- Keep test code in files or directories the production build excludes. Inject test doubles; don't branch on a test mode in production code.
- When assessing READY, inspect the release artifact for test code and apply SW-OPS.
- Operational diagnostics (SW-OPS) are production features, not test code.

**Defects.** Record expected vs actual, basis, reproduction, environment, impact; label unconfirmed reports. For an authorized fix, reproduce with the smallest check and add a regression test that fails before and passes after. If impractical, record why and the alternative verification.

**Test cases.** Link to the requirement, feature, or defect: preconditions, action, observable expected result. Distinguish proposed, implemented, executed. The automated test is the canonical copy of its steps; reference file and symbol, don't duplicate. Adding a test is not evidence it ran.
