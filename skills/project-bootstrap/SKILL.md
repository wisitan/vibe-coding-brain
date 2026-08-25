---
name: project-bootstrap
description: >-
  Use this skill when the user types "/project-bootstrap" to initialize a new AI-assisted project.
  This skill sets up the foundational folders and files (.agents/, docs/decisions/) and copies the AGENTS.md template into the root.
---

# Project Bootstrap Workflow

When the user triggers this skill (e.g., `/project-bootstrap`), you MUST execute the following steps to initialize the Project Brain.

## Steps

### 1. Setup Folder Structure
Create the following directories in the current project root if they do not exist:
*   `.agents/rules/`
*   `docs/architecture/`
*   `docs/decisions/`

### 2. Scaffold Initial Files
*   Read the global template `AGENTS_TEMPLATE.md` from your config (`~/.gemini/config/templates/` or `C:\Users\conta\.gemini\config\templates\`).
*   Create `AGENTS.md` in the project root using the template, instructing the user to fill in the project-specific details.
*   (Optional) If requested, create an initial `architecture.md` file.

### 3. Summary
*   Report that the Project Brain structure has been initialized.
*   Instruct the user to start filling out `AGENTS.md` and adding project-specific rules in `.agents/rules/`.
