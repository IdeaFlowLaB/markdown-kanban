#!/usr/bin/env bash
# A medium ticket (new data field + UI + filter). Default approval policy:
# the agent should verify, plan, and ask for approval before writing code.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 1 — Core notes

### [APP-9] Tags on notes
- **Goal**: users can add tags to a note and filter the list by tag.
- **Acceptance**: tags persist after reload; filtering by a tag shows only matching notes; existing notes without tags still load.
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
cat > src/note.ts <<'TS'
// ORIGINAL-NOTE
export interface Note { id: string; title: string; body: string }
TS
cat > src/list.ts <<'TS'
// ORIGINAL-LIST
export function listNotes() { return []; }
TS
