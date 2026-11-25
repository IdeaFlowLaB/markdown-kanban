## Kanban (markdown-kanban)

- Board: `kanban/{backlog,doing,done}.md` — commit board changes together with the work they describe.
- Before starting work, read `kanban/doing.md`. New requests go into `kanban/backlog.md` as tickets first.
- Every finished ticket: cut the whole entry into `done.md` (no strikethrough, no leftover markers); `doing.md` keeps only tickets truly in progress — no "moved to done.md" recap lines; `backlog.md` keeps only unstarted tickets.
