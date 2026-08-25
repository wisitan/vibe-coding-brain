# Architecture Specification

## Project Structure & File Roles
The web app is structured as a lightweight SPA without frameworks like React or Vue, maximizing performance and ease of offline usage.

- `index.html`: The main entry point, loading only `#app` and the `main.js` script.
- `package.json` & `vite.config.js`: Configuration for building a single-file artifact using Vite and `vite-plugin-singlefile`.
- `src/main.js`: The application shell, initializing Google Drive, applying themes/languages, rendering the top bar/sidebar, and handling hash-based routing.
- `src/store.js`: The central data store using a Singleton pattern. It handles `localStorage` read/writes, backup snapshots, merges, and exposes CRUD methods. It extends a custom `Emitter` class for reactivity.
- `src/google-drive.js`: Handles Google Drive OAuth2 and the Smart Two-Way Sync logic.
- `src/i18n.js`: The internationalization dictionary containing both English and Thai keys. Provides the `t(key)` helper.
- `src/utils.js`: Reusable utilities like `debounce`, `getNextId`, `fmtDate`, `fmtNum`, and the `Emitter` base class.
- `src/style.css`: The central stylesheet containing CSS variables for theming, base resets, layout definitions (sidebar/topbar/cards), and custom UI components (modals, badges, tables).
- `src/views/*`: Domain-specific view logic (e.g., `dashboard.js`, `settings.js`, `calendar.js`). Each exports a `render(container, store)` function that mounts UI onto the `#main-content` container.

## SPA Routing Pattern
Routing is built purely on `#hash` changes:
1. `getRoutes()` in `main.js` defines an array of route objects: `{ id, icon, label, render }`.
2. Listening to the `hashchange` window event triggers `navigate(routeId)`.
3. The `navigate` function clears the `#main-content` container, updates sidebar active states, and invokes the specific `render` function of the matched route, passing in the container and the store.

## Data Flow (Unidirectional)
1. **Store**: Holds the single source of truth in `this._data`.
2. **Views**: Read from the store (e.g., `store.getContent()`) and map data to DOM nodes.
3. **UI Events**: User interacts (e.g., clicks "Save" or edits a cell).
4. **Actions**: Views call mutator methods on the store (e.g., `store.updateContent(id, field, value)`).
5. **Reactivity**: Store modifies data, updates `updatedAt`, calls `this._persist()`, and emits a `change` event. Views re-render upon receiving the event (if they listen to it) or simply re-fetch on navigation.

## Event Emitter Pattern
A simple `Emitter` class is exported from `utils.js` providing `.on()`, `.off()`, and `.emit()` methods. The `Store` extends this class.
- When saving to localStorage, it calls `this.emit('saved')`.
- When errors happen, it calls `this.emit('error', msg)`.
- When data mutations occur, it calls `this.emit('change', collectionName)`.

## Theme Switching Mechanism
Handled natively via CSS custom properties (variables) defined in `:root`.
- Light mode is default.
- Dark mode overrides are defined under `[data-theme="dark"]` and `.dark-theme`.
- `applyTheme(theme)` in `main.js` sets the `data-theme` attribute on `document.documentElement` and class on `document.body`. The current theme is persisted in `store.settings.theme`.

## i18n Pattern
`i18n.js` maintains a `DICTIONARY` object with `en` and `th` keys.
- `currentLanguage` defaults to `localStorage.getItem('ccp_lang')` or `en`.
- The `t(key)` function retrieves the localized string, falling back to English, then to the key itself.
- Setting language reloads the UI to apply string changes.

## Build System
The app utilizes Vite combined with `vite-plugin-singlefile`.
This configuration outputs a single `index.html` containing all inlined CSS and JS, making it extremely portable and perfect for distributing as a downloadable offline web app.
