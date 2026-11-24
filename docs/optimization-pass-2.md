# Optimization Pass 2 (branch `ClaudeOptimizationPass2`)

**Goal:** add three maintainer-directed software rules, then review every contract against documented, peer-reviewed references.
**Rule applied:** as in [Optimization Pass 1](optimization-pass-1.md), a contract changes only where a cited finding, a governing rule, or a dated maintainer observation supports the change. Every other contract stays as it is.
**Date:** 2026-11-24.

## Sources

| # | Finding used | Source | Type |
|---|---|---|---|
| S16 | Comments and code that disagree point either to a bug or to a "bad comment" that misleads later programmers. iComment found 60 such inconsistencies (33 new bugs, 27 bad comments) in Linux, Mozilla, Wine, and Apache. | Tan, Yuan, Krishna, Zhou. */\* iComment: Bugs or Bad Comments? \*/*. SOSP 2007. [Purdue](https://www.cs.purdue.edu/homes/lintan/publications/icomment_sosp07.pdf) | Peer-reviewed |
| S17 | In a study of 48 experienced programmers, those given commented programs answered more comprehension questions than those given the same programs without comments. | Woodfield, Dunsmore, Shen. *The Effect of Modularization and Comments on Program Comprehension.* ICSE 1981, pp. 215–223. [DOI](https://doi.org/10.1145/390017.808317) | Peer-reviewed |
| S18 | CWE-489, Active Debug Code: "The product is released with debugging code still enabled or active." Mitigation, in the build, compilation, and distribution phases: "Remove debug code before deploying the application." | MITRE CWE 5.0. [CWE-489](https://cwe.mitre.org/data/definitions/489.html) | Industry standard (not peer-reviewed) |
| M1 | The maintainer has observed too much generated code with no explanation, and a function map used in place of documentation. | Maintainer observation, 2026-11-24 | Dated incident |
| M2 | The maintainer requires tests to report their own results when no harness exists, and requires test code to stay out of production releases unless specified. | Maintainer direction, 2026-11-24 | REQUIRED (maintainer) |

**Re-verified from Pass 1**
- **S2** (Gloaguen et al.): the recommendation is now confirmed in the paper's own text (arXiv 2602.11988v3, Introduction): "Human-written context files should only include instructions required for coding agents that are not already present in the README ... and be rigorously evaluated before adoption." The venue is an oral at the ICLR 2026 MemAgents workshop. CONTRACT-STYLE already follows this, so nothing changes.
- **S13** (Chakrabarty, Laban, Wu): the seven category names in LIT-QUALITY match the section headings 4.4.1–4.4.7 in arXiv 2409.14509v5. They were read from an extracted summary of the page, not the verbatim text. Nothing changes.

**Caveats**
- S17's result comes from the bibliographic record and secondary summaries of the abstract. The full text was not retrieved.
- S18 is an industry standard, not peer-reviewed research. It is cited as authoritative practice.
- The self-reporting test rule rests only on M2. No peer-reviewed source was found for it, and none is claimed.
- Considered and excluded:
  - Mathews and Nagappan, *Test-Driven Development for Code Generation* (arXiv 2402.13521). Giving an LLM tests alongside the problem raised its success on MBPP and HumanEval, which would support SW-TEST "Test strategy precedes coding". It is excluded because its venue could not be confirmed this pass: the ACM page for DOI 10.1145/3691620.3695527 refused the request.
  - Wen, Nagy, Bavota, Lanza, *A Large-Scale Empirical Study on Code-Comment Inconsistencies* (ICPC 2019). Its venue is confirmed, but the full text could not be retrieved, so none of its findings are used.

## Changes

| Contract | Change | Basis |
|---|---|---|
| SW-ENGINEERING | New **Code documentation** section. Non-trivial modules, classes, and functions get doc comments in the language's own form, covering purpose, inputs, outputs, errors, side effects, and constraints. Trivial code is exempt. Non-obvious logic gets a *why* comment. Comments change in the same change as the code, and a comment that contradicts the code is a defect. A function map never replaces doc comments. | M1, S17, S16 |
| SW-TEST | New **Self-reporting** section. Each test logs its name, the case it verifies, PASS or FAIL, and expected vs actual on failure, for passes as well as failures. Entry points exit non-zero on failure. Projects with a harness use its reporter. Logs go to stdout plus a timestamped file in `Reports/` unless the binding names another place, and never include secrets. | M2 |
| SW-TEST | New **Release separation** section. Production builds contain no test code, fixtures, mocks, test data, test-only flags, hooks, endpoints, or test logging unless the work record or binding requires them. Test doubles are injected rather than switched on by a test mode. The release artifact is inspected before READY is claimed. Operational diagnostics count as production features. | M2, S18 |
| LIT-CONTROL | Two overlapping AI-prose bullets are merged into one rule: mark the passage and record it, linked to its archived chat. "Validate ... free from plagiarism" now reads "check for plagiarism and record the check, its result, and what it couldn't cover", because a check cannot prove a negative (CORE-EVIDENCE: claim only what a check demonstrates). | S1, CORE-EVIDENCE |

The two SW-TEST sections and the SW-ENGINEERING section were committed first, on branch `contract-rules-tests-docs-release`. This pass branches from that commit.

## Reviewed, untouched

No new peer-reviewed finding applied to the contracts below, so they stay as they are. Pass 1 sources S1–S15 are still reflected where Pass 1 applied them.

- All core contracts. Always-loaded core is unchanged at 1,435 words and 135 lines, under the 150-line limit.
- Workflow, multi-agent, organization, provider, and integration contracts.
- SW-DESIGN, SW-DOCS, SW-LIFECYCLE, SW-OPS, SW-REPO, SW-SECURITY.
  - SW-DOCS needs no edit for M1: the "function map never replaces doc comments" rule is stated once, in SW-ENGINEERING.
  - SW-OPS needs no edit: the READY check for test code is stated once, in SW-TEST.
- LIT-CANON, LIT-MANUSCRIPT, LIT-ORIGINALITY, LIT-QUALITY.
- Every role contract. Code reviewers and developers already load SW-ENGINEERING and SW-TEST through `requires`.

## Measurements

| Measure | Before | After |
|---|---|---|
| Always-loaded core (words) | 1,435 | 1,435 |
| All contracts (words) | 9,798 | 10,039 (+2.5%). The growth is in SW-TEST and SW-ENGINEERING, which load only for software projects. |
| SW-TEST / SW-ENGINEERING (lines) | 23 / 17 | 34 / 22, both under the 40-line limit |
