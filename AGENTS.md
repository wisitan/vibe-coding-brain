# Global Vibe Coding Workflow

This rule applies to all Vibe Coding projects.

## Auto Code Review with Gemini 3.1 Pro
- The main agent (Gemini 3.7 Flash or equivalent) is responsible for writing the code and implementing features.
- **MANDATORY**: After completing the code for a specific feature, phase, or logical chunk of work, the main agent MUST NOT proceed to the next feature.
- Instead, the main agent MUST spawn a subagent using the `invoke_subagent` tool with the argument `Model: "pro"` (representing Gemini 3.1 Pro or the most capable reasoning model).
- The prompt for the subagent should be to act as a "Senior QA Reviewer" and review the recent Git diffs or modified files for bugs, security issues, performance problems, and best practices.
- The main agent MUST wait for the subagent's review, fix any identified issues, and obtain approval from the subagent before continuing the workflow.
