#!/usr/bin/env bash
# A phased backlog; a new request clearly belongs to Phase 2 (sharing).
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 1 — Core notes

### [APP-3] Bulk delete notes
- **Goal**: let users delete many notes at once.
- **Acceptance**: select-all + delete removes the rows; undo within 5 s.
- **Depends on**: none.

## Phase 2 — Sharing

### [APP-11] Share a note by link
- **Goal**: a note owner can create a read-only link to one note.
- **Acceptance**: anyone with the link can read the note; nobody can edit through it.
- **Depends on**: none.

## Waiting on others

(nothing)

## Parked

### [APP-20] Offline mode
- **Goal**: read notes without a connection.
- **Trigger to schedule**: more than 10 users ask for it.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done
MD
echo "export {}" > src/index.ts
