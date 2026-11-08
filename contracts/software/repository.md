---
id: SW-REPO
summary: Multi-component and multi-deliverable repository rules; illustrative layout.
requires: [WF-WORKSPACE]
---
# Repository structure

A component is an implementation boundary; a deliverable is independently built, packaged, or deployed. One repository is not one release.

- Each deliverable has identifiable source, build, and check boundaries. Document release and deploy boundaries when applicable.
- Shared interface and protocol definitions have one canonical location (`interfaces/`); no divergent copies.
- Extract shared libraries only for demonstrated reuse.
- Check changed components and affected integration boundaries. Cross-component changes need compatibility checks.
- Single-deliverable projects MAY use `src/` and `tests/` directly.
- `contracts/` is reserved for these agent contracts.

Illustrative only, not a scaffolding checklist:

```text
AGENTS.md  README.md  contracts/  docs/
apps/<deliverable>/  interfaces/  packages/  tests/  tools/
```
