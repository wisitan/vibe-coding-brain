---
name: webapp-builder
description: Build new single-page web apps from the Creator App Template. Use this skill when the user wants to create a new web application with CRUD data management, Google Drive sync, calendar view, dashboard, and editable tables. Trigger on mentions of 'new web app', 'create app from template', 'webapp-builder', 'boilerplate', or 'new project from template'.
---

# WebApp Builder Skill

This skill guides the AI on how to create a new Single Page Application (SPA) using the Creator App Template architecture with automatic Git & Vercel deployment workflows.

## Overview of the Technology Stack & Architecture
The template is a lightweight, zero-framework Single Page Application (SPA) designed for offline-first usage with Smart Google Drive Sync.

### 🛠️ Technology Stack:
- **Programming Language**: Vanilla JavaScript (Modern ES6+ Modules) — No heavy frameworks (No React, Vue, Angular, or Next.js) for ultra-fast performance (~220kB bundle).
- **Markup & Layout**: HTML5 Semantic Elements.
- **Styling**: Pure Vanilla CSS3 with CSS Variables for Theme Management (Light/Dark Mode) and Glassmorphism design system.
- **State Management**: A singleton `Store` extending a custom `Emitter` (`store.js`).
- **Routing**: A simple hash-based SPA router in `main.js`.
- **Data Persistence & Database**: Browser `localStorage` (Offline-First) + Google Drive REST API v3 (App Data folder as serverless JSON storage).
- **Build Tooling & Bundling**: Vite v6 with `vite-plugin-singlefile` to bundle the entire app into a single `dist/index.html`.

## Step-by-Step Guide for Creating & Deploying a New App

1. **Clone Template Structure**: Recreate base files from `creator-app-template` (`package.json`, `vite.config.js`, `index.html`, `src/main.js`, `src/store.js`, `src/utils.js`, `src/styles.css`, and `src/i18n.js`).
2. **Define Data Model**: Define collections, fields, and default settings in `app.config.js`.
3. **Customize Views**: Create or update views in `src/views/` (dashboard, editable data tables, calendar, settings).
4. **Update Router & i18n**: Add new routes in `main.js` and update dictionary keys in `i18n.js`.
5. **Build Locally**: Run `npm install` and `npm run build` to generate the single-file output in `dist/`.
6. **Git Release & Vercel Deployment**:
   - Increment version in `package.json` and `main.js` (e.g. `v1.0.0` → `v1.0.1`).
   - Run `git add .`, `git commit -m "fix: Release v1.0.1 - [Changes]"` and `git push origin main`.
   - Vercel automatically detects the push, builds in the cloud, and updates production instantly!

## What to Modify vs What to Keep As-Is

### 🟢 Modify:
- **`app.config.js`**: Data models, collections, fields, settings lists, dashboard stats.
- **`src/views/*`**: UI rendering logic for specific pages.
- **`src/i18n.js`**: Dictionary keys and translations.
- **`src/styles.css` (Domain styles)**: Custom colors and component tweaks.

### 🔴 Keep As-Is (Core Infrastructure):
- **`src/core/google-drive.js`**: Smart Sync and directional tombstone algorithm.
- **`src/core/utils.js`**: Core utilities and event emitter.
- **`vite.config.js`**: Required for single-file bundling.
- **`src/main.js` (Shell & Router Logic)**: Base logic for `#hash` routing.

## Common Pitfalls to Avoid
1. **Missing `updatedAt`**: Every record modification in `store.js` MUST update the `updatedAt` timestamp.
2. **Improper ID Renaming**: When editing IDs, you MUST create a tombstone for the old ID via `_trackDelete`.
3. **Forgetting to Emit Events**: After modifying data, always call `this._changed('collectionName')`.
4. **Pop-up Closing on Outside Click**: Ensure `closeOnOutsideClick = false` on modals so user inputs are never lost.

## References
- [Architecture Specification](references/ARCHITECTURE.md)
- [Sync Specification](references/SYNC_SPEC.md)
- [Data Model Specification](references/DATA_MODEL_SPEC.md)
- [UI Patterns Specification](references/UI_PATTERNS.md)
- [Git & Vercel Deployment Specification](references/DEPLOYMENT_SPEC.md)
- [Creator App Best Practices (Critical Logic & UX)](references/CREATOR_APP_BEST_PRACTICES.md)
