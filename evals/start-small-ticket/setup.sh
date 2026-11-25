#!/usr/bin/env bash
# A small, obvious ticket under the default approval policy: just do it.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 1 — Core notes

### [APP-10] Fix typo in settings page title
- **Goal**: the settings page title reads "Seting"; it should read "Settings".
- **Acceptance**: title shows "Settings".
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
cat > src/settings.ts <<'TS'
export const title = "Seting";
TS
