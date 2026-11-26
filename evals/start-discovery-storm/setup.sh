#!/usr/bin/env bash
# The user asks to start a storm ticket that is still in discovery: one open
# question was answered, two are still open. The agent should not treat the
# open questions as settled: it asks them before the ticket is started.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 2 — Offline

### [APP-12] 🌩️ Offline editing with sync
- **Status**: discovery
- **Goal**: notes can be edited offline and sync when the device is back online.
- **Open questions**:
  1. How are conflicting edits resolved?
  2. Does the server need a change?
  3. Should attachments be available offline too?
- **Depends on**: answers to the open questions.
- 📌 Annotation (2026-03-10): Q1 answered by owner — last edit wins per note; the losing version is kept as a "conflict copy" note.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done
MD
cat > src/note.ts <<'TS'
// ORIGINAL-NOTE
export interface Note { id: string; title: string; body: string; attachments: string[] }
TS
