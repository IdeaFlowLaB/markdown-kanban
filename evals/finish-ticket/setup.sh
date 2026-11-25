#!/usr/bin/env bash
set -e
mkdir -p kanban src/export
cat > kanban/backlog.md <<'MD'
# Backlog

### [APP-3] Bulk delete notes
- **Goal**: let users delete many notes at once.
- **Acceptance**: select-all + delete removes the rows; undo within 5 s.
- **Depends on**: none.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

### [APP-2] Export notes as CSV
- **Goal**: users can download their notes as CSV.
- **Acceptance**: file opens in Excel with correct columns; unit tests cover escaping.
- **Depends on**: none.
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-01 — [APP-1] Note list page
- **Shape**: src/pages/notes.tsx with sortable table.
- **Verification**: manual check on staging.
MD
echo "export function toCsv() {}" > src/export/csv.ts
