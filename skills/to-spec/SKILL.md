---
name: to-spec
description: >-
  Use when the user types "/to-spec" or asks to turn the current discussion, interview, or PRD into a comprehensive technical specification.
  Synthesizes requirements into user stories, architectural decisions, test seams, and explicit out-of-scope boundaries without interviewing.
---

# To Spec Workflow (Technical Specification Generator)

This skill synthesizes the current conversation, interview notes, `CONTEXT.md`, and ADRs into a comprehensive, unambiguous **Technical Specification**.

## Core Rules
1. **Synthesize, Don't Interview:** Do NOT start a new round of questioning. Extract and organize what has already been decided.
2. **Domain Glossary Compliance:** Strictly use canonical terms defined in `CONTEXT.md`. Respect existing architectural decisions in `docs/decisions/`.
3. **Save to Repository:** Save the completed specification file to `docs/specs/<feature-slug>-spec.md`.
4. **No Code Implementation Yet:** Focus purely on creating the contract and engineering blueprint.

---

## Specification Template

Follow this structure strictly when generating the spec:

```markdown
# 📐 Technical Specification: <Feature Name>

**Status:** Draft / Approved  
**Date:** <Date>  
**Reference:** CONTEXT.md, relevant ADRs  

---

## 1. Problem Statement
Describe the problem that the user or business is facing from their perspective.

## 2. Solution Overview
High-level description of how this feature solves the problem without diving into low-level code lines.

## 3. User Stories (Extensive)
A detailed, numbered list covering all user personas and workflows:
1. As a <persona>, I want <action/capability>, so that <business benefit>.
2. As a <persona>, I want <action/capability>, so that <business benefit>.

## 4. Technical Implementation Decisions
- **Data Models & Storage:** Any schema changes, localStorage keys, or database tables.
- **Interfaces & API Contracts:** Payload structures, request/response formats.
- **State Management:** How data flows through the application.
- **UI Components:** New or modified views, dialogs, or notification patterns.
*(Avoid fragile code snippets; focus on structural decisions and contracts).*

## 5. Testing Decisions & Seams
- Identify testing seams (the highest level boundary to verify external behavior).
- Define acceptance tests for happy paths and critical edge cases.

## 6. Out of Scope (Strict Boundaries)
Explicitly list capabilities, edge cases, or related features that are intentionally NOT part of this implementation to prevent scope creep.

## 7. Next Actions
Recommend proceeding to `/to-tickets` (for vertical slicing) or `/new-feature` (for direct implementation).
```

## Completion
1. Write the file to `docs/specs/<feature-slug>-spec.md`.
2. Present a clean summary of the spec to the user with link to the file.
