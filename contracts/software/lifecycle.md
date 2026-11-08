---
id: SW-LIFECYCLE
summary: Owning, reusing, and cleaning up processes, services, ports, and test resources.
requires: [CORE-AUTHORITY]
---
# Process and resource lifecycle

- Track every process and temporary resource you start (servers, watchers, workers, browsers, subprocesses, sockets, test data): command, working directory, process identity, ports, intended lifetime. Use compact temporary state; no permanent registers; no secrets.
- Before starting a service, look for an existing instance and its owner. Reuse a suitable one, or stop your own obsolete one first. An occupied port is not proof of ownership. Never spawn alternate-port instances to dodge your own orphans.
- Tests register cleanup at acquisition (fixtures, context managers, `finally`). Cleanup covers partial setup, failures, exceptions, and timeouts. Touch only resources the test created; keep evidence and pre-existing data.
- For new or changed resource-owning helpers, verify cleanup on success and on an early failure, plus bounded shutdown and child/listener release.
- Use bounded run and shutdown waits; stop and reap children. A returned prompt, closed terminal, or cancelled call is not proof processes exited.
- Shut down gracefully, then verify. Escalate only against positively identified owned processes, re-checking identity first (PID reuse). Never kill by executable name or because a process holds a wanted port. If ownership is unclear, stop and ask.
- After teardown, verify processes ended, listeners closed, and resources were released. Leftovers fail the test or are reported; keep the original failure alongside cleanup errors.
- Leave a service running only for a requested handoff: report instance, URL/port, purpose, and shutdown steps. Remove duplicates.
- On stop: no restarts or retries, cleanup only. If cleanup is impossible, report resource identities and recovery steps.
