## Kanban (markdown-kanban)

- Board: `kanban/{backlog,doing,done}.md` — commit board changes together with the work they describe. Each file starts with its own rules; read them. Don't read all of `done.md` by default: its header and newest entries, plus a search by ticket ID, are enough.
- Before starting work, read `kanban/doing.md` and follow its start ritual and approval policy. New requests go into `kanban/backlog.md` as tickets first (split big ones into sub-tickets).
- Every finished ticket: cut the whole entry into `done.md` (no strikethrough, no leftover markers); `doing.md` keeps only tickets truly in progress — no "moved to done.md" recap lines; `backlog.md` keeps only unstarted tickets.
