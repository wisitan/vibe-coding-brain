# Smart Sync Specification

## Overview
The Smart Sync system provides offline-first, conflict-free synchronization between `localStorage` and a JSON file stored on the user's Google Drive. 
It uses a **Directional Tombstone** algorithm to ensure items deleted on one device propagate to others, without erroneously deleting newly created or updated items.

## Google Drive OAuth2 Flow
The integration lives in `src/google-drive.js` and uses the modern Google Identity Services script (`https://accounts.google.com/gsi/client`).
- Relies on the `https://www.googleapis.com/auth/drive.file` scope, giving the app access *only* to files it creates.
- `authenticateDrive()` requests an access token without forcing a prompt if the session is active.
- Backups are written to a specific file, located using `findBackupFileId()`.

## Backup / Restore Mechanism
- **Backup**: Serializes the `store._data` to JSON and patches/uploads it to Drive (`backupToDrive`).
- **Restore**: Fetches the JSON media from Drive and returns it (`syncFromDrive`).
- **Smart Sync**: Fetches remote data, performs a directional merge algorithm with local data, saves the merged result locally, and patches the merged result back to Drive (`smartSyncWithDrive`).

## Directional Tombstone Sync Algorithm (Critical Pattern)
To safely merge records across devices, we must handle the case where a record is modified on Device A, but deleted on Device B. Standard merging would resurrect the deleted item. Tombstones solve this.

### What is a Tombstone?
When a record is deleted locally, an entry is added to `store._data.deletedItems`:
```json
{ "id": "C001", "type": "content", "deletedAt": "2024-01-01T12:00:00.000Z" }
```
Tombstones are garbage collected (e.g., > 30 days old) to prevent unlimited growth.

### Why Directional?
Instead of a single global pool of tombstones that indiscriminately destroys data, the algorithm applies tombstones *directionally*:
1. **Apply DRIVE tombstones to LOCAL items**: If a Drive tombstone is newer than the local item's `updatedAt`, it means the item was deleted from another device *after* this local device last touched it. Delete it locally.
2. **Apply LOCAL tombstones to DRIVE items**: If a Local tombstone is newer than the Drive item's `updatedAt`, it means the user deleted it here, and the Drive hasn't been updated yet. Ignore the Drive item (effectively keeping it deleted).

### Timestamp Comparison (`updatedAt` vs `deletedAt`)
Every record in a collection MUST have an `updatedAt` ISO string.
- If `deletedAt > updatedAt`: The deletion wins.
- If `updatedAt > deletedAt`: The update wins (the item was resurrected/modified after being deleted).

### Legacy Record Protection
If a record lacks an `updatedAt` timestamp (older data schema), the merge algorithm handles it gracefully by keeping it safe. A tombstone will *not* auto-delete a legacy item unless it specifically gains an `updatedAt` field upon modification.

### ID Renaming Edge Case
If a user changes a record's ID (e.g., `P001` -> `PROD-A`), the app must:
1. Update the record's ID.
2. Generate a tombstone for the old ID (`P001`).
Without this, `P001` would remain on Drive and sync back down as a "ghost" duplicate record.

## mergeCollection Logic Step-by-Step
1. Build Maps for local and remote deleted items.
2. Process Local Items: Filter out any items killed by a newer remote tombstone. Put survivors in an `itemMap`.
3. Process Drive Items: Filter out any items killed by a newer local tombstone. 
   - If not in `itemMap`, add it.
   - If in `itemMap`, compare `updatedAt`. Keep whichever version is newer.
4. Return `Array.from(itemMap.values())`.

## Lessons Learned
- Ensure all new records default with `updatedAt: new Date().toISOString()`.
- Ensure all edits run `item.updatedAt = new Date().toISOString()`.
- Image data and long strings should only be merged cautiously. If one side is missing a large payload (like a Base64 image) but the other has it, merge rules should preserve the image.
