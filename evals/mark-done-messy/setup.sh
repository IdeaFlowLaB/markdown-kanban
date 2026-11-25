#!/usr/bin/env bash
# A realistic, slightly messy board: a leftover strikethrough line from an earlier
# ticket, a started ticket still duplicated in backlog, and a terse user request.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

### [APP-5] Dark mode
- **Goal**: support system dark mode.
- **Acceptance**: all pages readable in dark mode.
- **Depends on**: none.

### [APP-6] Password reset email
- **Goal**: users can reset their password by email.
- **Acceptance**: reset link works once and expires after 1 h.
- **Depends on**: none.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

~~### [APP-4] Login page~~ ✅ moved to done.md

### [APP-6] Password reset email
- **Goal**: users can reset their password by email.
- **Acceptance**: reset link works once and expires after 1 h.
- **Depends on**: none.
- Progress: email template done, token table done, link handler done, tests green.
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-01 — [APP-4] Login page
- **Shape**: src/login.ts with email + password form.
- **Verification**: e2e login test passes.
MD
echo "export const reset = true;" > src/reset.ts
