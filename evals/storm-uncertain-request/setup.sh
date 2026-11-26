#!/usr/bin/env bash
# A big request whose right solution is not known yet. It should become one
# storm ticket that records the open questions, not a premature split.
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
MD
echo "export {}" > src/index.ts
