---
name: to-tickets
description: >-
  Use when the user types "/to-tickets" or asks to break down a large project, complex feature, or design spec into manageable vertical slice tickets.
  Creates tracer-bullet tickets with dependency tracking to fit cleanly inside individual context windows.
---

# To Tickets Workflow (Tracer-Bullet Vertical Slicing)

Break complex software requirements or specs into small, self-contained **tracer-bullet tickets** that prevent token overload and memory degradation.

## Principles of Vertical Slicing
1. **Vertical, Not Horizontal:** Each ticket cuts through all layers (UI, API/logic, storage/schema, tests) so it is demonstrable and verifiable on its own.
2. **Context Window Sized:** Each ticket must be sized to complete within a single fresh context window (one conversation session).
3. **Explicit Blocking Edges:** Declare dependencies clearly (`Blocked by: Ticket-01`) so work can be executed in dependency order.
4. **Expand-Contract for Wide Refactors:** If a change impacts many files across the project, expand first (add new form alongside old), migrate callers in small batches, then contract (delete old form).

## Pipeline Steps

### 1. Gather Context
Read the conversation, `CONTEXT.md`, relevant ADRs, or existing specs.

### 2. Draft Tickets
Structure each ticket using this format:

```markdown
### Ticket [NN]: <Descriptive Title>
- **What it delivers:** End-to-end user visible behavior.
- **Blocked by:** Ticket numbers that must complete first, or "None (Can start immediately)".
- **Acceptance Criteria:**
  - [ ] Criterion 1
  - [ ] Criterion 2
- **Estimated Scope:** Small / Medium (fits 1 session)
```

### 3. Review with User
Present the list to the user and verify:
- Is the granularity right? (not too broad, not too trivial)
- Are the dependencies ("Blocked by") accurate?

### 4. Save Tickets
Save approved tickets to disk under `.agents/tickets/` (e.g. `.agents/tickets/01-setup-schema.md`, `.agents/tickets/02-api-endpoint.md`).
