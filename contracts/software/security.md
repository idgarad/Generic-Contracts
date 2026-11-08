---
id: SW-SECURITY
summary: Preserving security controls; validating security, isolation, and limit claims.
requires: [CORE-EVIDENCE]
---
# Security

- Preserve controls: input validation, output encoding, least privilege, secret handling, dependency safety, filesystem and command safety, transport protection. Never weaken a control to make code run.
- Never write secrets, credentials, or unauthorized sensitive data to code, logs, reports, or agent state.
- Validate security, resource-limit, and isolation claims at the enforcing layer in the supported runtime, including host and wrapper defaults. Mocks, framework clients, or alternate hosts are not evidence for untested boundaries; disclose differences.
- Define isolation for shared browser, filesystem, network, and process state where relevant. A separate port or process is not proof of isolation.
- Security exceptions follow CORE-AUTHORITY.
