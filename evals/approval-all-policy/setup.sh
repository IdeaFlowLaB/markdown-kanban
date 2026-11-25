#!/usr/bin/env bash
# Same small ticket, but the board's approval policy is set to "all":
# even a typo fix needs a plan and the owner's approval before code.
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

> **Approval before coding**: all
> (options: `all` | `medium, large, storm` | `storm only` — edit this line to change the policy)

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done
MD
cat > src/settings.ts <<'TS'
export const title = "Seting";
TS
