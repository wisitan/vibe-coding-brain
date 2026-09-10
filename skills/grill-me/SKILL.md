---
name: grill-me
description: >-
  Use when the user types "/grill-me" or asks to stress-test, brainstorm, or sharpen an idea, business plan, content angle, or technical design.
  This skill conducts an interactive, multi-round interview without creating files (Stateless).
---

# Grill Me Workflow (Stateless Idea Stress-Testing)

This skill conducts a rigorous, collaborative interview to sharpen fuzzy ideas into clear, actionable plans.

## Core Rules
1. **Stateless (No file creation):** Do NOT write or create files on disk. The output lives in the user's mind and the chat summary.
2. **Design Tree & Frontier:** Model decisions as a tree. Only ask questions whose prerequisites are already settled.
3. **Structured Rounds:** Ask questions in numbered batches with recommended answers so the user can easily choose or modify.
4. **Autonomous Fact Finding:** If a fact can be looked up from code, tools, or web, look it up yourself—never ask the user for facts you can discover. Decisions and tradeoffs belong to the user.

## Round Format

Present each round cleanly:

```markdown
❓ **Q1 - <Question Title>**
<Clear context explaining why this question matters, including tradeoffs or options>

➡️ **Recommended Answer:** <Your reasoned recommendation>

---

❓ **Q2 - <Question Title>**
<Context and options>

➡️ **Recommended Answer:** <Your reasoned recommendation>
```

## Session Completion
When all branches of the design tree have been explored and the frontier is empty:
1. Provide a crisp **Executive Summary** synthesizing:
   - Core Value Proposition / Goal
   - Key Decisions & Tradeoffs agreed upon
   - Recommended Next Action (e.g., proceed to `/grill-with-docs` or `/new-feature`)
