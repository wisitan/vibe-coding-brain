# Data Model Specification

## Store Structure
The single source of truth is maintained in `store._data` as an object containing arrays for collections, and objects for settings.

```json
{
  "settings": {
    "theme": "light",
    "language": "en",
    "googleClientId": "...",
    "contentTypes": ["Affiliate", "Knowledge"]
  },
  "brand": {
    "creatorName": "...",
    "colors": []
  },
  "products": [
    {
      "id": "P001",
      "name": "Product A",
      "updatedAt": "2024-01-01T00:00:00.000Z"
    }
  ],
  "deletedItems": [
    {
      "id": "P002",
      "type": "product",
      "deletedAt": "2024-01-02T00:00:00.000Z"
    }
  ]
}
```

## Collection Structure
Every entity collection is an array of objects.

### Required Fields
1. `id`: String. Unique identifier.
2. `updatedAt`: ISO String (`new Date().toISOString()`). Critical for Smart Sync.

## CRUD Pattern in Store
For any collection, the store exposes standard methods.

### Add
```javascript
addProduct(data = {}) {
  const nextId = (data && data.id) || getNextId('P', this._data.products, 4);
  const p = {
    id: nextId,
    name: '',
    status: 'Active',
    ...data,
  };
  p.updatedAt = new Date().toISOString();
  this._data.products.push(p);
  this._changed('products');
  return p;
}
```

### Update (Field-Level)
Updates should happen at the field level, taking `id`, `field`, and `value`. Special handling is required when `field === 'id'` (to prevent duplicates and track tombstones).
```javascript
updateProduct(id, field, value) {
  // If editing ID, ensure uniqueness and track tombstone for old ID
  // ...
  const p = this.getProduct(id);
  if (p) {
    p[field] = value;
    p.updatedAt = new Date().toISOString();
    this._changed('products');
  }
}
```

### Delete (Tombstoning)
```javascript
deleteProduct(id) {
  this._trackDelete(id, 'product'); // Adds to deletedItems with deletedAt
  this._data.products = this._data.products.filter(p => p.id !== id);
  this._changed('products');
}
```

## Settings as Configurable Dropdown Lists
Many text fields in the collections derive their autocomplete or select options from arrays stored in `settings`.
- E.g., `contentTypes`, `channels`.
- The user can add/remove these in the `Settings` view.
- The UI binds these via `store.getSettingList('channels')`.

## Migration Pattern for Schema Changes
If the structure changes in a future update, `store.js` implements a migration step during `_load()`.
For example, retroactively adding `updatedAt` to older records:
```javascript
_migrateTimestamps(data) {
  const now = new Date().toISOString();
  // loop over collections and set item.updatedAt = now if missing
}
```

## Export / Import Format
Exports dump the entire `store._data` as a pretty-printed JSON file.
Imports parse the JSON and override `store._data`. During import, image strings (Base64) can be massive, so the import logic verifies missing images against the current local state to preserve them if the imported file truncated them.
