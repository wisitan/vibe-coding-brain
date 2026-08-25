# UI Patterns Specification — Creator App Template

This document specifies the standard UI components, layout patterns, and user experience rules for apps built with this template.

---

## ⚙️ 1. Dynamic Settings View Specification

The Settings Page MUST follow the official Content Planner layout while remaining **100% dynamic**:

1. **Header Action Bar**:
   - Title & Subtitle on the left.
   - Danger Action (`Clear All Data`) on the right with a strict confirmation alert (`confirm()`).

2. **Top Controls Grid (Side-by-Side Cards)**:
   - **Card 1: 🌙 Dark Theme Switcher**: Toggle switch (`theme-toggle-switch`) with `DARK MODE` / `LIGHT MODE` indicator.
   - **Card 2: 🌐 Language Selector**: Dropdown select (`🇺🇸 English (US)` / `🇹🇭 ภาษาไทย (TH)`).

3. **Auto-Detected Settings Grid (Dynamic Array Settings Cards)**:
   - `settings.js` MUST NOT hardcode domain-specific list keys.
   - Automatically detect all array properties from `store.getSettings()` using `Object.keys(store.getSettings()).filter(k => Array.isArray(store.getSettings()[k]))`.
   - Each settings array renders as a `.setting-list` card.
   - **Header**: `.setting-list-header` styled with dark background (`--c-dark`) and white text.
   - **Body**: List of `.setting-item` with inline text inputs and a hoverable remove button (`✕`).
   - **Add Item**: `+ Add item` button at the bottom of each list.

4. **Data Management Section**:
   - `📥 Export Backup (JSON)` and `📤 Import Backup (JSON)` buttons.

---

## 🔍 2. Year Select & 12-Month Quick Filter Bar Specification

All primary data table views (e.g. Content Planner, Transactions, Channels, Sponsors, Debts, Savings) **MUST enable `enableYearMonthFilter: true`**:

1. **Year Select Dropdown**:
   - Auto-detects available years from date fields in the dataset + rolling window.
   - Displays `🗓️ All Years` by default.

2. **12-Month Toggle Buttons (`JAN` - `DEC`)**:
   - Renders 12 quick-toggle month buttons (`JAN`, `FEB`, `MAR`, `APR`, `MAY`, `JUN`, `JUL`, `AUG`, `SEP`, `OCT`, `NOV`, `DEC`).
   - Clicking a month button toggles that month filter. Active months display highlighted blue/indigo styling (`.btn-month-toggle.active`).
   - Includes a `✕ Reset Months` button when any month is selected.

---

## 📱 3. Row Details Modal Form Popup (Mobile-Friendly & Safe)

When a user clicks on an ID pill or clicks the Edit button (✏️):

1. **Modal Popup Render**:
   - Renders a vertical form modal (`.modal-card-solid`) with `.modal-overlay` (z-index: 99999).
   - Header: `📱 Row Details (${rowId}) — รายละเอียดแนวตั้ง`.
   - Subtitle: `(สามารถพิมพ์แก้ไขหรือไถหน้าจอขึ้นลงเพื่อดูข้อมูลทุกคอลัมน์ในแนวตั้งได้อย่างสะดวก)`.
   - Labels: Indigo (`color: var(--c-primary)`), bold `font-weight: 700`, UPPERCASE.
   - Inputs: Rounded corners (`border-radius: 10px`), `padding: 10px 14px`, background `#F8FAFC`, no raw black border box.

2. **🔒 LOCKET POPUP Rule (`closeOnOutsideClick = false`)**:
   - Clicking outside the modal backdrop **MUST NOT** close the modal.
   - `closeOnOutsideClick = false` prevents accidental data loss during long text entry.
   - Confirm button: `💾 Save & Close / บันทึก` (Primary Indigo button).
   - Cancel button: `❌ Close / ปิด` (Secondary Gray button).

---

## 📅 4. Calendar Grid & Item Detail Modal

1. **Monthly Grid & View Toggles**:
   - View mode toggle buttons: `Month View`, `Week View`, `Day View`.
   - Year Select dropdown & 12 Month toggle buttons.

2. **Item Click → Detail Popup**:
   - Clicking any item (`.cal-item`) on the calendar opens a Detail Modal Popup (`.modal-card-solid`) displaying all attributes with a Close button.
