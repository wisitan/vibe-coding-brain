# 🧠 Vibe Coding Master Brain

Master repository for Sunday (Coding Agent) & พี่เอ (Wisit) — Centralizing rules, skills, personas, and workflows across Mac and Windows PC.

---

## 📋 Daily Workflow Cheat Sheet

| สถานการณ์ | เรียกใช้คำสั่ง | สิ่งที่ระบบทำ |
| :--- | :--- | :--- |
| 💡 **ปรึกษาไอเดียธุรกิจ / คิดหัวข้อคอนเทนต์** | `/grill-me` | สัมภาษณ์เจาะลึกเพื่อตกผลึกไอเดีย ไม่สร้างไฟล์ (Stateless) |
| 📐 **เริ่มวางระบบใหม่ / ล็อกนิยามศัพท์** | `/grill-with-docs` | สัมภาษณ์สถาปัตยกรรม + บันทึก `CONTEXT.md` (Glossary) และ ADR ลงเครื่องทันที (Stateful) |
| 📄 **แปลงสิ่งที่คุยเป็นพิมพ์เขียว & User Stories** | `/to-spec` | สังเคราะห์สิ่งที่คุยเป็น Technical Spec เต็มรูปแบบลง `docs/specs/` (ทำหน้าที่แทน PRD) |
| 🧩 **โปรเจกต์ใหญ่ อยากซอยเป็นงานย่อย** | `/to-tickets` | ซอยระบบเป็น Tracer-Bullet Vertical Slices พอดี 1 Context Window พร้อมเช็ก Blocking |
| 🔨 **ลงมือสร้างฟังก์ชันใหม่ / ทำงานตามบรีฟ** | `/new-feature` | Pipeline 7 ขั้นตอน (วางแผน ➔ เช็กเสี่ยง ➔ เขียนโค้ด ➔ เทส ➔ Commit) รองรับทั้งบรีฟตรงและหยิบตั๋วงาน |
| 🔍 **ตรวจความเรียบร้อยก่อนส่งมอบ** | `/code-review` | ตรวจสอบ 2 แกนคู่ขนาน: Standards & Code Smells vs Spec & Requirements Fidelity |
| 🐛 **แก้บั๊กที่ไม่คาดคิด** | `/bug-fix` | ตรวจหาสาเหตุรากเหง้า ➔ แก้ไขเฉพาะจุด ➔ เทส ➔ Commit |

---

## 📂 Repository Structure

* `GEMINI.md`: Persona of Sunday, Thai language communication rules, Sweet Spot QA Triage, and Wisit's personal context.
* `AGENTS.md`: Pair programming guidelines & QA Subagent operational rules.
* `rules/`: Global coding standards applied across all projects (`global-coding-standards.md`).
* `skills/`: Reusable procedural runbooks (`grill-me`, `grill-with-docs`, `to-spec`, `to-tickets`, `new-feature`, `code-review`, `bug-fix`, `webapp-builder`, `responsive-ui-guidelines`, `project-bootstrap`).
* `templates/`: Templates for project-level `AGENTS.md`, `ADR_TEMPLATE.md`, and `CONTEXT_TEMPLATE.md`.
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
  * Auto-committed and pushed to GitHub automatically by Sunday.
* **On other devices:**
  * Run `git pull` in the `vibe-coding-brain` folder.
