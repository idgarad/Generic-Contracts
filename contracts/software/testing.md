---
id: SW-TEST
summary: Verification standards, defect reproduction, regression tests, test-case records.
requires: [CORE-EVIDENCE, WF-RECORDS]
---
# Testing

- Testing is part of implementation. Add applicable normal, boundary, invalid-input, failure, regression, state-transition, and idempotency checks.
- For each material acceptance criterion: an observable result and a check that distinguishes compliance from a plausible failure. When timing, concurrency, quantities, isolation, or resource release matter, assert them directly; elapsed time or an unrelated final result is insufficient. Justify tolerances.
- Check risky test infrastructure with a deliberately failing or fault-injected case.
- Never delete valid tests, weaken assertions, change expected values to hide defects, or silently skip failures. Requirement changes explain affected test changes.
- Distinguish real execution, simulated time, mocks, and inspection; claim only what each proves.
- Provide reproducible local build and test commands plus required pipeline checks, as the project justifies.
- Coverage is evidence, not proof. Use risk-based gates; no arbitrary percentages or filler tests.

**Defects.** Record expected vs actual, basis, reproduction, environment, impact; label unconfirmed reports. For an authorized fix, reproduce with the smallest check and add a regression test that fails before and passes after. If impractical, record why and the alternative verification.

**Test cases.** Link to the requirement, feature, or defect: preconditions, action, observable expected result. Distinguish proposed, implemented, executed. The automated test is the canonical copy of its steps; reference file and symbol, don't duplicate. Adding a test is not evidence it ran.
