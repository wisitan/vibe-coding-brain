# Global Vibe Coding Workflow

This rule applies across all Vibe Coding projects.

## Pair Development Model (Coding Agent + Senior QA Subagent)
- **Coding Agent (Sunday):** Responsible for understanding requirements, planning, and implementing features.
- **Senior QA Subagent:** Dedicated subagent (Model: `flash` / Gemini 3.8 Flash) providing neutral, high-speed code quality reviews.

## Sweet Spot Triage Policy
To maximize delivery speed and prevent unnecessary token consumption, follow this risk-based triage:

1. 🟢 **Low Risk (Auto-Pass - Skip QA 100%):**
   - UI styling, CSS tweaks, color palette, spacing, margins, padding, layout alignment.
   - Copywriting, i18n/localization, toast messages, tooltips, comments, Markdown docs, README.
   - Minor constant configuration changes.
   - *Action:* Sunday self-verifies, runs `npm test` or build, and commits directly.

2. 🟡 **Medium Risk (Self-Check):**
   - Isolated UI components without global state side-effects.
   - Small helper/utility functions with unit test coverage.
   - General UI bug fixes not touching network APIs, databases, or cloud storage.
   - *Action:* Sunday self-checks logic, runs tests, and completes task.

3. 🔴 **High Risk (Must-Review - Mandatory Senior QA):**
   - **Billing & Quota:** Payment gateways (Stripe), credit/token calculation, database RPCs.
   - **Core AI Engine:** STT/TTS prompts, transcription pipelines, FFmpeg/media processing, fallback engines.
   - **Storage & Lifecycle:** Cloudflare R2 / S3 uploads, presigned URLs, cron cleanup jobs, data deletion.
   - **Security & Auth:** External API route handlers, auth flows, token verification, PIN/password verification.
   - **Architecture Refactor:** Global state store refactoring, breaking frontend-backend contract changes.
   - *Action:* Sunday spawns Senior QA Subagent (`model: 'flash'`) with a targeted Git diff and specific review scope before commit.

## Git Workflow
- Always perform a Git commit after completing a feature, bug fix, or UI change (unless the user specifies otherwise).
- Use clear, Conventional Commit messages (e.g., `feat:`, `fix:`, `style:`, `refactor:`).

