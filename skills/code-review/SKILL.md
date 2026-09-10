---
name: code-review
description: >-
  Use when the user types "/code-review" or asks to review code, PRs, or recent changes.
  Performs a comprehensive Two-Axis review evaluating (1) Standards & Code Health and (2) Spec & Requirements Fidelity.
---

# Code Review Workflow (Two-Axis Review)

When triggered (e.g. `/code-review` or `/code-review since HEAD~1`), perform a thorough read-only audit across two independent axes so that clean code does not mask missing requirements, and functional code does not mask technical debt.

## Rules of Engagement
*   **Read-only:** DO NOT modify any code or files during review.
*   **Diff-based:** Inspect `git diff` against HEAD, merge-base, or specified commit.

## Axis 1: Standards & Code Health
Evaluate code craftsmanship against repo standards and baseline code smells:
1. **Repository Standards:** Does it follow `rules/global-coding-standards.md`, `AGENTS.md`, and project architecture rules?
2. **Security Baseline:** No exposed secrets, no unsanitized user inputs (XSS prevention).
3. **Martin Fowler Code Smells:**
   - *Mysterious Name:* Variables/functions whose names do not reveal intent.
   - *Duplicated Code:* Same logic repeated across hunks.
   - *Feature Envy:* A function reaching into another object's data more than its own.
   - *Primitive Obsession:* Using raw strings/numbers instead of proper domain models.
   - *Shotgun Surgery:* One small change forcing edits scattered across too many files.

## Axis 2: Spec & Requirements Fidelity
Evaluate alignment against the originating user prompt, spec, or ticket:
1. **Missing Requirements:** Are there features, validations, or edge cases asked for that were missed?
2. **Scope Creep:** Was code or complexity added that was NOT requested? (Speculative generality)
3. **Fidelity:** Did the implementation match the expected user behavior?

## Return Format

Format findings cleanly by priority:

```markdown
## 🔍 Two-Axis Code Review Report

### 📐 Axis 1: Standards & Code Health
- **P0 Critical:** <Immediate bugs, security leaks, severe violations or "None">
- **P1 Important:** <Code smells, responsiveness flaws, or maintainability issues>
- **P2 Nice to have:** <Minor style polish, naming improvements>

### 🎯 Axis 2: Spec & Requirements Fidelity
- **P0 Missing Requirements:** <Items from the brief that were omitted or "None">
- **P1 Scope Creep / Deviations:** <Unnecessary additions or behavioral mismatch>
- **P2 Edge Case Enhancements:** <Recommended edge cases to cover>

### 📊 Final Verdict
- **Status:** [Approved / Needs Changes]
- **Summary:** One-line bottom-line recommendation.
```
