---
name: new-feature
description: >-
  Use when the user types "/new-feature", asks to implement a feature, or asks to work on a ticket from /to-tickets.
  Executes a disciplined 7-step pipeline (Requirement -> Inspect -> Plan -> Ask if risky -> Implement -> Test -> Review & Summary).
---

# New Feature & Implementation Workflow

When triggered (e.g. `/new-feature <Description>` or `/new-feature implement Ticket 01`), follow this pipeline strictly in order.

## Pipeline Steps

### 1. Requirement & Scope
*   Read the user's description, spec, or ticket carefully.
*   If the requirement is ambiguous or missing acceptance criteria, stop and ask clarifying questions.

### 2. Inspect
*   Read `CONTEXT.md` (domain glossary) and any ADRs in `docs/decisions/` to align with canonical terms and architecture.
*   Inspect relevant existing code, data models, state management, and reusable UI components.

### 3. Plan
*   Create a step-by-step implementation plan with files to create, files to modify, and tests to run.

### 4. Ask if Risky (Guardrail)
*   Evaluate risk (e.g., changes to persistent storage, auth, external APIs, breaking contracts).
*   **STOP** and present the plan and risk evaluation to the user.
*   Wait for user confirmation before writing code.

### 5. Implement
*   Write minimal, clean, safe changes adhering to `rules/global-coding-standards.md`.
*   Preserve existing working behaviors.

### 6. Test & QA
*   Run unit tests, verify types, and check for runtime errors.
*   Follow the **Sweet Spot QA Triage** (Self-check for low/medium risk, invoke Senior QA Subagent with targeted diff for high risk).

### 7. Review & Summary
*   Summarize what was built and verify against acceptance criteria.
*   Execute Git commit with conventional commit message (e.g., `feat: ...`).
