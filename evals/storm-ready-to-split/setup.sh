#!/usr/bin/env bash
# A storm ticket (a new feature) whose questions are all answered and whose
# notes still match the code. Splitting happens in the backlog: sub-tickets
# with dependencies plus a parent Integration field; nothing moves to doing.
set -e
mkdir -p kanban src/server
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 2 — Offline

### [APP-12] 🌩️ Offline editing with sync
- **Goal**: notes can be edited offline and sync when the device is back online.
- **Open questions**:
  1. How are conflicting edits resolved?
  2. Does the server need a change?
  3. Should attachments be available offline too?
- **Depends on**: answers to the open questions.
- 📌 Annotation (2026-03-10): Q1 answered by owner — last edit wins per note; the losing version is kept as a "conflict copy" note.
- 📌 Annotation (2026-03-12): Q2 answered by owner — the server has no change tracking today, so add an `updatedAt` column; no other server change.
- 📌 Annotation (2026-03-15): Q3 answered by owner — text only; attachments stay online-only.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done
MD
cat > src/server/notes.ts <<'TS'
// ORIGINAL-SERVER
// No change tracking yet: rows are overwritten in place.
export interface NoteRow { id: string; title: string; body: string }
TS
