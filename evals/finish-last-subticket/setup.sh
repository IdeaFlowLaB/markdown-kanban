#!/usr/bin/env bash
# The last sub-ticket of a parent is finished. Each sub-ticket passed alone,
# but the parent's end-to-end integration check has never been run.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 1 — Sharing

### [APP-7] Note sharing (parent — split into 7a–7c)
- **Goal**: users can share notes with others.
- **Sub-tickets** (in order): [APP-7a] share link → [APP-7b] permissions → [APP-7c] revoke view.
- **Integration**: all three use the share record `{noteId, role, revokedAt}` from 7a. End-to-end check: create a can-edit link → open it as another user and edit → revoke it in the admin view → the link returns 404.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

### [APP-7c] Admin view to revoke shares
- **Goal**: admins can revoke any share.
- **Acceptance**: revoked links stop working immediately.
- **Depends on**: [APP-7b].
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-04 — [APP-7b] Read-only vs. can-edit permissions
- **Shape**: `role` on the share record; editor checks it.
- **Verification**: unit tests 10/10.

## 2026-03-02 — [APP-7a] Read-only share link
- **Shape**: share record `{noteId, role, revokedAt}` and `/s/:id` route.
- **Verification**: unit tests 6/6.
MD
echo "export {}" > src/index.ts
