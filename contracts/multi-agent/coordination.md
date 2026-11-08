---
id: MA-COORD
summary: Several agents on one project: shared authority, leases, integrator, handoffs, conflicts.
requires: [WF-PLANNING, WF-STATE]
---
# Multi-agent coordination

- **One work authority.** All agents read and update it. No private backlogs.
- **Leases.** Each agent works only on its assigned increment and files, components, or chapters, recorded in the work authority with agent and role. Edit outside a lease only after its holder or the human releases it. Leases end with the increment.
- **One integrator.** A named human or agent merges results and resolves conflicts. Agents never overwrite each other's work; on conflict, stop and report to the integrator.
- **Separate making from checking.** The agent that produced a work product does not verify or accept it. A different agent or the human reviews it under the relevant role contract.
- **Handoffs** go through the work authority and `.ai/common/handoff.md`, never one agent's private memory or folder. Each names: what was done, status, evidence, open issues, next owner.
- **Specify and verify.** Every assignment states acceptance criteria and a stop condition. The receiving agent checks a handoff's claims against its evidence before building on them, and asks when the assignment is ambiguous.
- **Shared resources** (services, ports, test data) have one owner. Never stop another agent's resources.
- Parallelism does not authorize extra scope.
