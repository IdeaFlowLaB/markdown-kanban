# Before / after examples

## Finishing a ticket

❌ Before (`doing.md`):

```markdown
## In progress

~~### [APP-4] Login page~~ ✅ moved to done.md

### [APP-6] Password reset email ✅ DONE
- **Goal**: users can reset their password by email.
```

✅ After (`doing.md`):

```markdown
## In progress

(no ticket in progress)
```

✅ After (`done.md`, new entry on top):

```markdown
# Done

## 2026-03-05 — [APP-6] Password reset email
- **Shape**: email template, single-use token table, link handler in src/reset.ts.
- **Verification**: tests green; link expires after 1 h (checked manually).

## 2026-03-01 — [APP-4] Login page
- …
```

## Starting a ticket

❌ The ticket is copied into `doing.md` but its entry is still in `backlog.md` → the same ID now lives in two files.

✅ The entry is cut from `backlog.md` and pasted under `## In progress` in `doing.md`, replacing the placeholder.

## Setting up

❌ A single `KANBAN.md` with `## Todo / ## Doing / ## Done` sections.

✅ `kanban/backlog.md`, `kanban/doing.md`, `kanban/done.md` from the templates, plus the Kanban section appended to `CLAUDE.md` so every future session reads `doing.md` before starting work.
