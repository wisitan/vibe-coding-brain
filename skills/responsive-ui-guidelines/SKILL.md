---
name: responsive-ui-guidelines
description: Architectural guidelines and patterns for building dual-layout Web Apps with distinct UI/UX for PC Desktop vs Mobile Devices.
---

# Responsive UI Guidelines (Mobile Device vs PC Desktop)

When building rich Single-Page Web Applications (SPAs) or web tools, PC Web and Mobile Web serve fundamentally different user contexts. Follow these architectural standards to ensure a premium experience on both desktop and mobile.

---

## 1. Core Principles

- **PC Desktop View**: Optimized for data density, keyboard/mouse interaction, wide screen space (Sidebar + Topbar + Multi-column Data Tables + 7-Column Calendar Grids).
- **Mobile View**: Optimized for thumb-zone ergonomics, touch targets (minimum 44x44px), vertical scrolling, stacked clean cards, bottom-sheet overlays, and bottom navigation.

---

## 2. Device Detection Strategy

Combine UserAgent testing with Window Media Queries for robust rendering control:

```javascript
export function isMobileDevice() {
  if (typeof window === 'undefined') return false;
  const userAgentCheck = /Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
  const screenCheck = window.innerWidth <= 768;
  return userAgentCheck || screenCheck;
}
```

---

## 3. Navigation Design Patterns

### PC Desktop:
- **Left Sidebar**: Permanent vertical sidebar showing logo, primary navigation links, user profile, and version string (`sidebar-footer`).
- **Topbar**: Search, notifications, primary action buttons (Export, Import, Sync).

### Mobile Device:
- **Hamburger Drawer Menu (3-Line Icon)**: Slide-out drawer menu for secondary links/settings that don't fit into the primary bar.
- **Bottom Navigation Bar**: Fixed bottom bar with 4-5 core items. If there are > 5 items, enable horizontal touch-scrolling (`overflow-x: auto; flex-wrap: nowrap;`).
- **Floating Action Button (FAB)**: Bottom right floating `+` button for quick record creation.

---

## 4. Component Adaptation (PC vs Mobile)

### A. Data Tables vs Mobile Cards
- **PC**: Render interactive `<table>` with fixed/sticky headers, drag-and-drop column ordering, inline editable cells, and multi-column sorting.
- **Mobile**: Hide `<table>` (`display: none !important`) and render vertical `.mobile-card-list`. 
  - **Clean Cards Rule:** Do NOT place delete or edit buttons on the outer face of mobile cards. Keep outer cards clean and uncluttered.
  - **Tap to Drill-Down:** Tapping any card opens a Vertical Detail Modal (Pop-up).
  - **Modal Action Buttons:** Place prominent action buttons (e.g. 🗑️ Delete Record, 💾 Save Changes) at the top or bottom inside the Vertical Detail Modal.

### B. Calendar Views & Quick Edit Pop-up
- **PC**: Default to **Month View** (`cal-grid` 7-column layout) showing days of the month with truncated single-line item pills.
- **Mobile**: Support both Month View and Day View (`cal-day-view-container`).
- **Quick Edit Pop-up:** Tapping any calendar item opens a Quick Edit Modal containing only essential fields (Title, Status, Date, Content Type, Product, Channel, Pillar, Hook, Script). Non-essential fields should be managed in the main table view.
- **Script Textarea Height:** Provide generous height for script/outline fields (`rows="9"`, `min-height: 200px`, `line-height: 1.6`).
- **Teleprompter Integration:** Include a prominent `🎬 Teleprompter` button inside the pop-up to launch a full-screen overlay for script reading.

---

## 5. Pure Single-Language Dynamic i18n Rule
- Never hardcode dual-language slash strings in UI labels (e.g., avoid `Title / หัวข้อคอนเทนต์` or `Delete Record / ลบ`).
- Keep dictionaries in `i18n.js` strictly single-language (`en` = English only, `th` = Thai only).
- Wrap all UI labels with dynamic `t('key')` helper calls so the interface switches languages cleanly based on user settings.

---

## 6. CSS Scoping & Isolation

Use strict CSS class separation to avoid layout bleeding:

```css
/* Hide mobile-only elements on Desktop */
@media (min-width: 769px) {
  .mobile-card-list,
  .mobile-bottom-nav,
  .hamburger-menu-btn {
    display: none !important;
  }
}

/* Hide desktop-only elements on Mobile */
@media (max-width: 768px) {
  .sidebar,
  .desktop-table-wrapper {
    display: none !important;
  }
}
```

---

## 7. Modal & Overlay Behavior

- **PC**: Centered popup dialog with max-width (e.g. 600px - 900px), glassmorphism backdrop blur.
- **Mobile**: Bottom sheet overlay sliding up from the bottom (`border-top-left-radius: 16px; border-top-right-radius: 16px;`), full-width, with fixed bottom action buttons for easy thumb tapping.
