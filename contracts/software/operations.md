---
id: SW-OPS
summary: Resilience, diagnostics, failure handling; production-ready gate.
requires: [CORE-EVIDENCE, SW-TEST, SW-SECURITY]
---
# Operations

- Design for timeouts, partial failure, stale state, unavailable dependencies, malformed responses, authorization failures, retries, concurrency, and duplicates where relevant.
- Never routinely swallow exceptions or strip diagnostic context.
- Operationally significant behavior SHOULD have safe diagnostics, meaningful exit codes, redacted logs, dependency checks, and recovery guidance. Use existing tooling before adding a harness.
- Assess **READY (production-ready)** only for a readiness request or an authorized release gate. Verify release separation per SW-TEST and all applicable security (SW-SECURITY), operational, deployment, and acceptance gates.
