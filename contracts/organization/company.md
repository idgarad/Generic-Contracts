---
id: ORG-COMPANY
summary: TEMPLATE for one organization's rules: regulations, AI use, data, systems, approvals.
requires: [CORE-AUTHORITY, WF-BINDING]
---
# Organization: <COMPANY NAME>

<!-- TEMPLATE: replace every <...>, delete lines that don't apply, and list only controls
that actually apply. Link to internal policies; don't copy them. Agents treat any unfilled
<...> as UNKNOWN: ask the policy owner, never assume. Delete this comment when done. -->

**Identity**
- Organization: <legal name>. Unit/team: <unit>. Industry: <retail | banking | healthcare | ...>.
- AI policy owner: <name or role, contact>. Security contact: <contact>. Escalate policy questions here; never guess.

**Regulations and standards** (only those that apply. Examples: retail card data → PCI DSS; banking → GLBA, SOX, FFIEC guidance, model risk management; health data → HIPAA; EU personal data → GDPR)
- <regulation>: <what it means for agent work> (<link to internal policy>)

**Approved AI use**
- Approved agents and plans: <e.g. enterprise Copilot and enterprise Claude only; no consumer chat apps>.
- Allowed work: <e.g. code, tests, internal docs>. Prohibited work: <e.g. credit or hiring decisions, customer-facing text without human review>.
- Never enter into any AI tool: <e.g. cardholder data, account numbers, SSNs, patient data, customer PII, credentials, unreleased financials>.

**Data classification**

| Class | Examples | Agent may |
|---|---|---|
| Public | <...> | Read and write |
| Internal | <...> | Read and write in approved tools |
| Confidential | <...> | <read only, or with approval> |
| Restricted | <...> | Never access |

- Use synthetic or masked data in tests, examples, prompts, personas, and archives. Never copy production data to development, logs, or `.ai/`.

**Systems of record** (fills WF-BINDING)
- Work: <tracker and project>. Docs: <wiki or space>. Code: <host and org>. CI: <system>. Evidence: <location>.

**Change and approval**
- Change management: <e.g. ticket for every change; CAB approval for production>.
- Required reviews: <e.g. two approvals; security review for auth or crypto; legal review for new licenses>.
- Separation of duties: no one approves or deploys their own change, human or agent.

**Engineering standards**
- Approved languages and frameworks: <list>. Coding standard: <link>.
- Open source: <allowed licenses; approval process for new dependencies>.
- Secrets live only in <vault>; never in code, prompts, or archives.

**Communications and brand**
- Never speak for the company, contact customers or the press, or use company branding without approval from <team>.
- Label outputs with their classification: <label format>.

**Records, audit, incidents**
- Chat archive and evidence retention: <period, location>; legal hold contact: <contact>. Overrides CORE-AUDIT defaults.
- On exposed secrets, restricted data, or suspected compromise: stop and report to <contact>.

**Intellectual property**
- Work product belongs to <company>. AI-assistance disclosure: <e.g. "AI-assisted" commit trailer, or none required>.
