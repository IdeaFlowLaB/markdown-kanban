#!/usr/bin/env bash
# A storm ticket was settled and split; sub-ticket APP-12a is in progress.
# The user starts APP-12c, which does not depend on 12a. The agent should start
# it alongside 12a, not insist on one sub-ticket at a time.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 2 — Offline

### [APP-12] 🌩️ Offline editing with sync (parent — split into 12a–12c)
- **Status**: ready
- **Goal**: notes can be edited offline and sync when the device is back online.
- **Sub-tickets** (in order): [APP-12a] local note cache → [APP-12b] sync queue → [APP-12c] offline banner.
- **Integration**: 12a and 12b share the cached note shape `{id, title, body, updatedAt}`; 12c only reads the online/offline state. End-to-end check: go offline → edit a note (banner shows) → go online → the edit reaches the server and the banner hides.
- 📌 Annotation (2026-03-10): conflicts — last edit wins per note; the losing version is kept as a "conflict copy" note.
- 📌 Annotation (2026-03-12): server may add an `updatedAt` column; attachments stay online-only.

### [APP-12b] Sync queue
- **Goal**: queue offline edits and send them when back online.
- **Acceptance**: edits made offline reach the server after reconnecting; conflicts produce a conflict copy.
- **Depends on**: [APP-12a].

### [APP-12c] Offline banner
- **Goal**: show "Offline — changes will sync later" at the top of the app while the device is offline.
- **Acceptance**: banner appears when offline and hides when back online.
- **Depends on**: none.
- **Size**: S
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

### [APP-12a] Local note cache
- **Goal**: keep every note in a local cache so it can be read and edited offline.
- **Acceptance**: notes open and save with the network turned off.
- **Depends on**: none.
- Plan approved 2026-03-14: cache in IndexedDB, keyed by note id; write-through on save. Implementation under way.
MD
cat > kanban/done.md <<'MD'
# Done
MD
cat > src/app.ts <<'TS'
// App shell
export function renderApp(root: HTMLElement) {
  root.innerHTML = '<main id="notes"></main>';
}
TS
