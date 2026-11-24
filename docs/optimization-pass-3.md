# Project-lifetime token review

On 2026-11-24 the maintainer approved six changes after a review of all 66 contracts at `8ff2b03`. The review used the generated packages, contract requirements, and repeated operations below. [Pass 2](optimization-pass-2.md) records the basis for retaining per-test reporting, release separation, independent checking, and creative controls.

| Affected files or contracts | Observation and change |
|---|---|
| Both generators | A fresh context previously loaded seven core index rows and seven files containing build metadata. Generate the core rule bodies once in `AGENTS.md`, starting with CORE-TERMS. Keep the modular sources in this repository and index the other selected contracts by path. |
| SW-TEST | A successful run can produce one line per case. Capture the full run, inspect exit status, totals and failure excerpts first, and consult details when required. |
| CORE-EVIDENCE | The session-local retrieval rule required checking the same fixed source after resumption. Reuse requires a recorded verified claim, a fixed source version, and a supporting location. Changed claims, mutable sources, current-status questions, and missing provenance require retrieval. |
| CORE-AUDIT and archive format | Reconstructing a conversation at each checkpoint repeated earlier exchanges. Each new fallback segment identifies its predecessor and the interval covered. Native transcripts remain the first choice. |
| LIT-QUALITY, LIT-ORIGINALITY, SW-OPS, SW-TEST | Selective builds could omit release-gate prerequisites. Package the dependencies, scope checks to the assigned stage, and evaluate READY on a readiness request or authorized gate. |
| WF-RECORDS, WF-STATE, MA-COORD, CORE-COMPLETION | Several destinations requested the increment result. Record it in the work authority, link it from the handoff with the next action and owner, and summarize it for the human. |

## Measurements and verification

- **Fresh context.** The same mixed enterprise selection with all roles, tools, and providers measured 5,156 tokens before and 4,710 after, saving 446 tokens per fresh load (8.7%). Counts use `o200k_base` on LF-normalized generated instructions plus every separately required core and organization file. Both builds used the same project name, organization template, and normalized generation comment. This measures input text before provider caching.
- **Package checks.** Ran both generators with only SW-OPS selected, only the proofreader role selected, and all options selected. The packages contained 15, 18, and 66 contract IDs respectively. Compared file inventories and text after normalizing line endings and the generation comment. Checked every embedded body against its source and resolved each declared dependency. The mixed fixture exposed a platform-specific difference in role ordering, corrected with ordinal sorting.
- **Missing prerequisite.** Replaced one release dependency with an unknown ID in a temporary source tree. Both generators named the missing ID, exited unsuccessfully, and emitted no ZIP.
- **Test output.** Ran a synthetic suite of 1,000 cases twice, retaining all 1,001 report lines each time. The passing run exited 0. The injected failure exited 1 and identified the case, expected value, and actual value. Captured report text measured 7,013 and 7,016 tokens. The totals and relevant failure excerpt measured 11 and 21 tokens respectively, excluding exit status and tool wrappers.
- **Archive recovery.** Saved two reconstruction segments with the packaged PowerShell archive tool. Starting from the second gzip file, followed its stored path to the first and recovered both exchanges exactly once in chronological order.
- **Instruction walkthrough.** Inspected the packaged rules for resuming with a pinned citation versus a mutable source, handing off an increment, proofreading a passage, and then assessing the manuscript for READY. These checks establish what the instructions and packages contain. Agent behavior and lifetime savings on a live project remain unmeasured.
