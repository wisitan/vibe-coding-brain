# 📖 Project Domain Glossary (CONTEXT.md)

This document establishes the **Ubiquitous Language** for this project. Every term used in discussions, specifications, and code variables must adhere to these canonical definitions to prevent ambiguity and AI hallucinations.

---

## 🏛️ Domain Concepts & Terms

### [Term 1: e.g., Creator]
* **Canonical Name:** `Creator`
* **Definition:** A verified user who publishes content and manages affiliate campaigns.
* **Disambiguation (What it is NOT):** Not to be confused with `Admin` (system administrator) or `Subscriber` (viewer).
* **Key Attributes:** `creatorId`, `channelName`, `tier`.

---

### [Term 2: e.g., Campaign]
* **Canonical Name:** `Campaign`
* **Definition:** A marketing or affiliate activity tied to specific products and tracking links.
* **Disambiguation (What it is NOT):** A Campaign is not a `Post`. A single Campaign may contain multiple Posts.
* **Key Attributes:** `campaignId`, `startDate`, `targetGmv`.

---

## 🚫 Out of Scope / Anti-Definitions
* Explicitly state any terms or domain boundaries that this project intentionally does NOT support or handle.
