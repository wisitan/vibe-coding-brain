# 🧠 Vibe Coding Master Brain

Master repository for Sunday (Coding Agent) & พี่เอ (Wisit) — Centralizing rules, skills, personas, and workflows across Mac and Windows PC.

---

## 📂 Repository Structure

* `GEMINI.md`: Persona of Sunday, Thai language communication rules, Sweet Spot QA Triage, and Wisit's personal context.
* `AGENTS.md`: Pair programming guidelines & QA Subagent operational rules.
* `rules/`: Global coding standards applied across all projects (`global-coding-standards.md`).
* `skills/`: Reusable procedural runbooks (`new-feature`, `bug-fix`, `code-review`, `webapp-builder`, `responsive-ui-guidelines`, `project-bootstrap`).
* `templates/`: Templates for project-level `AGENTS.md` and `ADR.md`.
* `setup-mac.sh`: 1-Click setup script for macOS.
* `setup-pc.bat`: 1-Click setup script for Windows.

---

## 🚀 Setup Instructions

### On macOS
1. Clone to Documents:
   ```bash
   git clone https://github.com/wisitan/vibe-coding-brain.git ~/Documents/vibe-coding-brain
   ```
2. Run setup script:
   ```bash
   cd ~/Documents/vibe-coding-brain && ./setup-mac.sh
   ```

### On Windows PC
1. Clone to Local SSD:
   ```cmd
   git clone https://github.com/wisitan/vibe-coding-brain.git C:\vibe-coding-brain
   ```
2. Double-click `setup-pc.bat` (or run in Command Prompt).

---

## 🔄 Daily Sync Workflow

* **When updating rules/skills:**
  * Run `git add . && git commit -m "update message" && git push`
* **On other devices:**
  * Run `git pull` in the `vibe-coding-brain` folder.
