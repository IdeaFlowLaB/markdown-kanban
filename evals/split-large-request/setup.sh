#!/usr/bin/env bash
# A board with one phase; the request is too big for a single shippable ticket.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 1 — Core notes

### [APP-3] Bulk delete notes
- **Goal**: let users delete many notes at once.
- **Acceptance**: select-all + delete removes the rows; undo within 5 s.
- **Depends on**: none.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-01 — [APP-2] Export notes as CSV
- **Shape**: CSV export button on the note list.
- **Verification**: unit tests 12/12.
MD
echo "export {}" > src/index.ts
