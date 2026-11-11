---
id: INT-PRACTITEST
summary: PractiTest as test-management authority: tests, test sets, runs, traceability.
requires: [INT-COMMON, SW-TEST]
---
# Tool: PractiTest

- A test is a test-case record; its ID is the stable ID. For an automated test, reference the code file and symbol; don't copy its steps into the test.
- Requirements are intent, not authorization. Link tests to the requirements and issues they verify; don't create or edit requirements unless asked.
- Work only in the test sets the human selected. Add instances or create test sets only for the active increment.
- A run is evidence. Record one only for an execution that happened, with its actual per-step results. Never record a run for an unexecuted test, mark Passed by inference, or edit or delete a past run.
- Upload automated results only through the configured integration (API, xBot, FireCracker). Never hand-enter runs that imitate automated results.
- On failure, attach a concise excerpt (expected vs actual, environment), not raw logs. File the defect where the binding assigns defects and link it to the failing run.
- Never set a test or test set status meaning approved or signed off; that is the owner's.
- Never change testers, assignments, versions, priority, fields, or filters unless asked.
