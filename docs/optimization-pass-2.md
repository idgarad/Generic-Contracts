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
| S19 | LLM agents conform to a visible majority, and conformity substantially lowers multi-agent performance. | Weng, Chen, Wang. *Do as We Do, Not as You Think: the Conformity of Large Language Models.* ICLR 2025 (oral). [ICLR](https://proceedings.iclr.cc/paper_files/paper/2025/file/1da9ca7e9cef4b1af63913f05d1630a4-Paper-Conference.pdf) | Peer-reviewed |
| S20 | Across seven benchmarks, majority voting accounts for most of the gain attributed to multi-agent debate; debate alone does not improve on voting. | Choi, Zhu, Li. *Debate or Vote: Which Yields Better Decisions in Multi-Agent Large Language Models?* NeurIPS 2025. [NeurIPS](https://neurips.cc/virtual/2025/poster/116557) | Peer-reviewed |
| S21 | With faulty agents injected, hierarchical multi-agent structures degraded least of the linear, flat, and hierarchical structures tested; agents that challenge or inspect others' messages recover most errors. | Huang et al. *On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents.* ICML 2025, PMLR 267. [PMLR](https://proceedings.mlr.press/v267/huang25ay.html) | Peer-reviewed |
| S22 | Structured intermediate artifacts (requirements, designs, interface specs) under defined procedures, instead of free chat between agents, reduce cascading errors from chained LLMs. | Hong et al. *MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework.* ICLR 2024. [ICLR](https://proceedings.iclr.cc/paper_files/paper/2024/hash/6507b115562bb0a305f1958ccc87355a-Abstract-Conference.html) | Peer-reviewed |
| M1 | The maintainer has observed too much generated code with no explanation, and a function map used in place of documentation. | Maintainer observation, 2026-11-24 | Dated incident |
| M2 | The maintainer requires tests to report their own results when no harness exists, and requires test code to stay out of production releases unless specified. | Maintainer direction, 2026-11-24 | REQUIRED (maintainer) |

**Re-verified from Pass 1**
- **S2** (Gloaguen et al.): the recommendation is now confirmed in the paper's own text (arXiv 2602.11988v3, Introduction): "Human-written context files should only include instructions required for coding agents that are not already present in the README ... and be rigorously evaluated before adoption." The venue is an oral at the ICLR 2026 MemAgents workshop. CONTRACT-STYLE already follows this, so nothing changes.
- **S13** (Chakrabarty, Laban, Wu): the seven category names in LIT-QUALITY match the section headings 4.4.1–4.4.7 in arXiv 2409.14509v5. They were read from an extracted summary of the page, not the verbatim text. Nothing changes.

**Caveats**
- S17's result comes from the bibliographic record and secondary summaries of the abstract. The full text was not retrieved.
- S18 is an industry standard, not peer-reviewed research. It is cited as authoritative practice.
- The self-reporting test rule rests only on M2. No peer-reviewed source was found for it, and none is claimed.
- S21's degradation figures differ between the arXiv versions and the ICML poster, so the contract uses only the ranking, not a number.
- S22's hallucination claim is argued mainly from design; its measured results are code benchmarks. It supports the existing MA-COORD handoff rule and changes nothing.
- Considered and excluded:
  - Mathews and Nagappan, *Test-Driven Development for Code Generation* (arXiv 2402.13521). Giving an LLM tests alongside the problem raised its success on MBPP and HumanEval, which would support SW-TEST "Test strategy precedes coding". It is excluded because its venue could not be confirmed this pass: the ACM page for DOI 10.1145/3691620.3695527 refused the request.
  - 2026 work on multi-agent handoffs and shared memory (e.g. *Multi-Agent Memory Inconsistency*, arXiv 2611.22245; *Governed Shared Memory for Multi-Agent LLM Systems*, arXiv 2606.24535). These are preprints with no confirmed peer-reviewed venue.
  - Wen, Nagy, Bavota, Lanza, *A Large-Scale Empirical Study on Code-Comment Inconsistencies* (ICPC 2019). Its venue is confirmed, but the full text could not be retrieved, so none of its findings are used.

## Changes

| Contract | Change | Basis |
|---|---|---|
| SW-ENGINEERING | New **Code documentation** section. Non-trivial modules, classes, and functions get doc comments in the language's own form, covering purpose, inputs, outputs, errors, side effects, and constraints. Trivial code is exempt. Non-obvious logic gets a *why* comment. Comments change in the same change as the code, and a comment that contradicts the code is a defect. A function map never replaces doc comments. | M1, S17, S16 |
| SW-TEST | New **Self-reporting** section. Each test logs its name, the case it verifies, PASS or FAIL, and expected vs actual on failure, for passes as well as failures. Entry points exit non-zero on failure. Projects with a harness use its reporter. Logs go to stdout plus a timestamped file in `Reports/` unless the binding names another place, and never include secrets. | M2 |
| SW-TEST | New **Release separation** section. Production builds contain no test code, fixtures, mocks, test data, test-only flags, hooks, endpoints, or test logging unless the work record or binding requires them. Test doubles are injected rather than switched on by a test mode. The release artifact is inspected before READY is claimed. Operational diagnostics count as production features. | M2, S18 |
| LIT-CONTROL | Two overlapping AI-prose bullets are merged into one rule: mark the passage and record it, linked to its archived chat. "Validate ... free from plagiarism" now reads "check for plagiarism and record the check, its result, and what it couldn't cover", because a check cannot prove a negative (CORE-EVIDENCE: claim only what a check demonstrates). | S1, CORE-EVIDENCE |
| MA-COORD | New **Working folders** bullet. It points to the CORE-AI-FOLDER rule (write only to your own folder and `.ai/common/`, read others' folders, never edit them) and adds that what an agent reads in another agent's folder is an unverified claim, not authority or evidence. | Maintainer direction 2026-11-24, S21 |
| MA-ASSIGN | Makers report to the planner or integrator, not along a chain of agents. | S21 |
| MA-ASSIGN | When several agents judge one question, each records its answer before seeing the others'. Answers are combined by vote against the criteria, without extra debate rounds, and agreement between agents is not evidence. | S19, S20 |

The two SW-TEST sections and the SW-ENGINEERING section were committed first, on branch `contract-rules-tests-docs-release`. This pass branches from that commit.

## Reviewed, untouched

No new peer-reviewed finding applied to the contracts below, so they stay as they are. Pass 1 sources S1–S15 are still reflected where Pass 1 applied them.

- All core contracts. Always-loaded core is unchanged at 1,435 words and 135 lines, under the 150-line limit.
- Workflow, organization, provider, and integration contracts.
- SW-DESIGN, SW-DOCS, SW-LIFECYCLE, SW-OPS, SW-REPO, SW-SECURITY.
  - SW-DOCS needs no edit for M1: the "function map never replaces doc comments" rule is stated once, in SW-ENGINEERING.
  - SW-OPS needs no edit: the READY check for test code is stated once, in SW-TEST.
- LIT-CANON, LIT-MANUSCRIPT, LIT-ORIGINALITY, LIT-QUALITY.
- Every role contract. Code reviewers and developers already load SW-ENGINEERING and SW-TEST through `requires`.

## Measurements

| Measure | Before | After |
|---|---|---|
| Always-loaded core (words) | 1,435 | 1,435 |
| All contracts (words) | 9,798 | 10,141 (+3.5%). The growth is in SW-TEST, SW-ENGINEERING, MA-COORD, and MA-ASSIGN, none of which is always loaded. |
| SW-TEST / SW-ENGINEERING (lines) | 23 / 17 | 34 / 22, both under the 40-line limit |
| MA-COORD / MA-ASSIGN (lines) | 15 / 25 | 16 / 28 |
