---
id: SW-DOCS
summary: README, API reference, data dictionary, and generated catalogs.
requires: [WF-PLANNING]
---
# Software documentation

- `README.md` is the human entry point: what it is, how to build, run, and test. Link, don't duplicate.
- `docs/apiReference.md` covers interfaces others call. Prefer reference generated from native contracts (types, schemas, docstrings) when it meets the need.
- `docs/dataDictionary.md` is the canonical data dictionary: meaningful semantics, units, validation, provenance, classification, retention, ownership. Don't catalog local variables.
- Function dictionaries, data catalogs, and governance templates only when the project or policy requires them.
- Update docs in the same increment as the behavior they describe. Never document unbuilt behavior as delivered.
