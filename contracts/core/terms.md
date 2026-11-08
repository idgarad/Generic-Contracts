---
id: CORE-TERMS
summary: Defined vocabulary used by every contract. Load first.
---
# Terms

Defined once here. Other contracts use these words without redefining them.

**Keywords.** MUST = mandatory. SHOULD = default; vary only for a stated reason. MAY = optional. Lighter treatment a contract allows is compliance, not an exception.

- **Work product**: what the project delivers (code, manuscript, document, data).
- **Human**: the person directing the work. **Owner**: an explicitly designated accountable human, never inferred from authorship, commits, or requests.
- **Work authority**: the one place recording authorized work (default `docs/work.md`).
- **Canonical record**: the single authoritative home of a fact. Copies are labeled non-authoritative.
- **Increment**: the smallest useful authorized unit of work, with acceptance criteria and a stop condition.
- **Owned resource**: a process, file, service, or data the agent created.

**Status** (claim only what evidence supports):

| Status | Meaning |
|---|---|
| INCOMPLETE | Acceptance criteria not met |
| BLOCKED | Needs a decision or resource to proceed |
| DONE / NOT VERIFIED | Produced; required checks not run or not passing |
| VERIFIED | Produced; required checks ran and passed; evidence reported |
| ACCEPTED | Owner or authorized process accepted this identified outcome |
| READY | Domain release gates met (production- or publication-ready). Never implied by VERIFIED |

**Check results:** PASS, FAIL, BLOCKED, NOT RUN.

**Evidence labels:** REQUIRED (governing requirement or policy), RECOMMENDED (cited source), CONVENTION (project convention), JUDGMENT (professional judgment), ASSUMPTION, UNKNOWN. AI preference is not evidence.

**Lifecycle:** idea → candidate → authorized → active → done → verified → accepted. Each promotion needs human selection or delegated authority.
