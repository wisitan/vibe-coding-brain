---
description: "Global AI coding standards applied across all projects."
---

# Global Coding Standards

These rules apply to all projects in this environment:

## Workflow & Communication
*   **DO** thoroughly read existing code before proposing or implementing changes.
*   **DO** ask for clarification if a requirement is ambiguous or risky.
*   **DON'T** rewrite or refactor unrelated code when fixing a bug or adding a feature.

## Minimal & Safe Changes
*   **DO** isolate edits to the specific component or function involved.
*   **DO** preserve existing behavior unless explicitly requested by the user. If an edge case works a certain way, leave it alone.

## Git Workflow
*   **DO** remind the user to commit after significant milestones, or execute the commit if permitted.
*   **DO** write descriptive, conventional commit messages.

## Project Context & Bootstrapping
*   **DO** ensure every project has an `AGENTS.md` at its root. When starting in a new or uninitialized project directory without `AGENTS.md`, automatically create it with project goals, tech stack, and dev commands.

## Security Baseline
*   **NEVER** expose API keys, secrets, or OAuth credentials in source code.
*   **DO** ensure user inputs are sanitized before rendering into the DOM to prevent XSS.

