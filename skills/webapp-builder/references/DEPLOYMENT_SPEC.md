# Git & Vercel Auto-Deployment Specification

This document specifies the workflow for version control, GitHub repository management, and zero-downtime Vercel automatic deployment for web applications built with the Creator App Template.

---

## 🚀 1. The Deployment Workflow Overview

The architecture uses a **Git-driven Continuous Deployment (CD)** pipeline:

```
[ Local Development ] ──(npm run build)──> [ Git Commit & Push ] ──> [ GitHub (main branch) ] ──(Webhook Trigger)──> [ Vercel Auto-Deploy ] ──> [ Live Production URL ]
```

Because the project uses `vite-plugin-singlefile`, Vite compiles the entire web app into a single, optimized `dist/index.html`. This ensures lightning-fast builds (< 1 second) and eliminates routing errors (404 on refresh) on static hosting platforms like Vercel.

---

## 📁 2. Git Repository Initialization & Configuration

### `.gitignore` Setup
Every project MUST include a `.gitignore` file to prevent committing build artifacts or dependencies:

```gitignore
node_modules
dist
.DS_Store
*.local
```

### Git Command Checklist
When creating or updating a project:

```bash
# 1. Initialize local repository (if not already initialized)
git init

# 2. Configure local user identity if needed
git config user.name "Your Name"
git config user.email "your.email@example.com"

# 3. Add remote GitHub repository
git remote add origin https://github.com/username/repository-name.git

# 4. Stage and commit
git add .
git commit -m "feat: Initial commit for My App v1.0.0"

# 5. Push to main branch
git branch -M main
git push -u origin main
```

---

## ⚡ 3. Vercel Project Setup (One-Time Linkage)

1. **Connect GitHub Account to Vercel**:
   - Go to [Vercel Dashboard](https://vercel.com/dashboard).
   - Click **"Add New..."** → **"Project"**.
   - Import the GitHub repository (e.g., `creator-content-planner` or `munnong-money`).

2. **Configure Build Settings**:
   - **Framework Preset**: Vite (or Other)
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

3. **Deploy**:
   - Click **"Deploy"**. Vercel will assign a production URL (e.g., `https://your-app-name.vercel.app`).

---

## 🏷️ 4. Version Release & Auto-Deploy Checklist (Crucial for AI Agent)

When fixing bugs, adding features, or making updates requested by the user, ALWAYS follow this 5-step release checklist:

1. **Increment Version Number**:
   - Update `version` in `package.json` (e.g., `"version": "2.0.7"`).
   - Update `APP_VERSION` in `src/main.js` (e.g., `const APP_VERSION = 'v2.0.7';`).

2. **Verify Production Build Locally**:
   - Run `npm run build`.
   - Ensure the build completes with 0 errors and generates `dist/index.html`.

3. **Git Commit & Push**:
   - Run:
     ```bash
     git add .
     git commit -m "fix: Release v2.0.7 - [Clear description of what was changed]"
     git push origin main
     ```

4. **Vercel Automatic Deployment**:
   - Vercel automatically detects the push to `main`, runs `npm run build` in the cloud, and updates the live production site within seconds.

5. **Inform the User**:
   - Inform the user of the new version number (`v2.0.7`).
   - Provide the Vercel Production URL.
   - Remind the user to hard-refresh (`Ctrl + F5` or `Cmd + Shift + R`) to clear browser cache and load the latest version.

---

## 🔑 5. Benefits of this Workflow

1. **Zero Manual FTP/SSH Uploads**: Everything is automated via Git push.
2. **Instant Rollback**: If a bug occurs, previous commits can be redeployed on Vercel with one click.
3. **Traceability**: Every version is tagged with a clear git commit log.
4. **Offline First**: Users get a single bundle that works fast everywhere.
