---
name: markdown-kanban
description: Use when a project has a kanban/ directory (backlog.md, doing.md, done.md), or the user asks to set up a kanban or board, add or open a ticket, start or pick up a ticket, mark a ticket done or finished, report a ticket blocked, or tidy the backlog.
---

# Markdown Kanban

## Overview

The board is three Markdown files in the repo, committed together with the work they describe:

- `kanban/backlog.md` — unstarted tickets only
- `kanban/doing.md` — tickets actually being worked on right now
- `kanban/done.md` — finished tickets, newest first: the project's decision history

**Core principle: every ticket lives in exactly one file, in full.** A ticket is *moved* by cutting the whole entry out of one file and pasting it into the next. Nothing is left behind.

## Ticket format

```markdown
### [APP-12] Short imperative title
- **Goal**: outcome and why.
- **Acceptance**: observable checks that prove it is done.
- **Depends on**: ticket IDs, decisions, or "none".
```

Optional: **Red lines** (what must not happen). Reuse the project's ID prefix and take the next free number across all three files. Write in the board's existing language (field names included); for a new board, use the user's language.

## Workflows

**Set up** (no `kanban/` yet): copy `templates/backlog.md`, `doing.md`, `done.md` from this skill into `kanban/`, translating the template text if the user writes in another language. Append `templates/claude-md-snippet.md` to the project's `CLAUDE.md` (create it if missing; never overwrite existing content; skip if a Kanban section already exists).

**New request**: add a ticket to `backlog.md`. Do not start implementing unless asked.

**Start a ticket**: read `doing.md` first. Cut the ticket from `backlog.md` into `doing.md` under "In progress", replacing the "(no ticket in progress)" placeholder. If the ticket is marked 🌩️ (storm ticket), read `references/conventions.md` and re-review the design with the user **before** writing any code.

**Finish a ticket**: cut the entry out of `doing.md` (and out of `backlog.md` if a copy is there) and write a `done.md` entry at the **top**, under the header:

```markdown
## YYYY-MM-DD — [APP-12] Title
- **Shape**: what was actually built.
- **Verification**: how it was proven to work.
```

Add **Why / Decisions / Log** when there is something to say. If `doing.md` is now empty, write `(no ticket in progress)` (or the board language's equivalent, e.g. `（目前無進行中票）`).

**Blocked, split, rescoped, or storm ticket**: see `references/conventions.md`.

## Hygiene check (after every board edit)

- [ ] No strikethrough (`~~`), ✅-in-place, or "moved to done.md" pointer lines anywhere
- [ ] `doing.md` holds only tickets truly in progress (or the placeholder)
- [ ] `backlog.md` holds only unstarted tickets
- [ ] Each ticket ID appears in exactly one file
- [ ] Remind the user to commit the board with the work

**Leftovers already on the board are violations to clean up, not a convention to copy.** If you see an old strikethrough line or recap pointer, remove it while you are there.

## Common mistakes

| Mistake | Fix |
|---|---|
| Striking through or ticking the ticket in `doing.md` | Cut it; the record goes in `done.md` |
| "✅ moved to done.md" line left in `doing.md` | Delete it; `done.md` already says so |
| Appending to the bottom of `done.md` | Newest entry goes at the top |
| Starting a ticket but leaving it in `backlog.md` | Cut, don't copy |
| One `KANBAN.md` or `TODO.md` file | Three files under `kanban/` |
| Executing a 🌩️ ticket as written | Re-review first (`references/conventions.md`) |

See `references/examples.md` for before/after examples.
