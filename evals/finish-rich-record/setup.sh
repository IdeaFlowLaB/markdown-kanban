#!/usr/bin/env bash
# Finishing an architectural change. The done entry must keep the decision
# context (rejected option, data change, known limitation), not just a summary.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 2 — Storage
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

### [APP-20] Move note storage off localStorage
- **Goal**: users with many notes can keep saving.
- **Acceptance**: 20k notes save and load; existing data survives the upgrade.
- **Depends on**: none.
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-01 — [APP-2] Export notes as CSV
- **Shape**: CSV export button on the note list.
- **Verification**: unit tests 12/12.
MD
echo "export {}" > src/index.ts
