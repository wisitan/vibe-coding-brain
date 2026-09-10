---
name: grill-with-docs
description: >-
  Use when the user types "/grill-with-docs" or asks to design a new subsystem, define domain rules, or establish project specifications.
  Conducts an interactive interview and writes decisions directly to CONTEXT.md (glossary) and docs/decisions/ (ADRs) on the fly (Stateful).
---

# Grill With Docs Workflow (Stateful Architecture & Domain Modeling)

This skill conducts a deep architectural interview while grounding decisions directly into the project repository as concrete documentation.

## Core Rules
1. **Stateful (Immediate Documentation):** When a domain term or business definition is resolved, update or create `CONTEXT.md` immediately. When a significant, hard-to-reverse architectural decision is reached, create an ADR immediately.
2. **Ground in Existing Codebase:** Inspect existing files, databases, and APIs first. Never ask the user questions that can be answered by reading the codebase.
3. **Structured Rounds with Recommendations:** Ask questions in frontier rounds with recommended choices.
4. **No Code Implementation Yet:** Do NOT write application source code during this session. Focus 100% on aligning terms, constraints, and architecture.

## The Two Primary Artifacts

### 1. `CONTEXT.md` (Domain Glossary & Ubiquitous Language)
Located at project root (`./CONTEXT.md`).
- Records canonical domain terms (e.g., "Creator", "Lead", "Payout", "Transcription Job").
- Clarifies what each term means and what it explicitly does NOT mean.
- Keep it free of low-level code implementation details.

### 2. Architectural Decision Records (ADRs)
Located at `docs/decisions/` (e.g., `docs/decisions/0001-use-sqlite-for-local-cache.md`).
Create an ADR **only** when all three criteria are met:
1. **Hard to reverse:** The cost of changing it later is high.
2. **Surprising without context:** A future developer would wonder "Why was it built this way?"
3. **Result of a real tradeoff:** Genuine alternatives were evaluated.

## Round Format

```markdown
❓ **Q1 - <Question Title>**
<Context and architectural options>

➡️ **Recommended Answer:** <Your reasoned recommendation>

---

❓ **Q2 - <Question Title>**
<Context and options>

➡️ **Recommended Answer:** <Your reasoned recommendation>
```

## Session Completion
When all questions in the design tree are answered:
1. Confirm that `CONTEXT.md` and any ADRs are saved to disk.
2. Provide an executive summary of the agreed architecture.
3. Advise the user to proceed with `/to-tickets` (for complex systems) or `/new-feature` (for straightforward execution).
