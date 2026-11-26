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

Optional: **Red lines** (what must not happen), **Size** (S/M/L). Reuse the project's ID prefix and take the next free number across all three files. Write in the board's existing language (field names included); for a new board, use the user's language.

**Each file starts with a `>` rules header. Read it before editing the file, follow it, and never delete it.** The board's own rules (approval policy, common acceptance, phases) override the defaults below.

## Reading the board (save context)

`done.md` only grows. **Never read it whole by default**: read its header and the newest few entries (`Read` with a small limit, ~60 lines), and search it (Grep) for the ticket IDs or terms the current task needs. Read further only when tracing a past decision requires it. `doing.md` is read in full; `backlog.md` only the sections you need.

Don't rewrite, re-summarize or reorder existing entries, and don't copy history into new tickets — cite the ID. Write `done.md` entries as short field bullets, not narrative. **This saves context when reading, never by recording less**: keep the decisions, rejected options, data/API changes, tests and known limitations.

## Workflows

**Set up** (no `kanban/` yet): copy `templates/backlog.md`, `doing.md`, `done.md` from this skill into `kanban/` with their headers intact, translating all template text if the user writes in another language. Fill in phase names if the user has described the plan; otherwise leave the placeholders (do not block setup on it). Append `templates/claude-md-snippet.md` to the project's agent instruction files so every future session reads the board: `CLAUDE.md` (Claude Code) and `AGENTS.md` (Codex, Cursor and most other agents). Add it to each of these that exists, and create the one for the agent you are running in if it is missing. Never overwrite existing content; skip a file that already has a Kanban section.

**New request**: add a ticket to `backlog.md` under the phase it belongs to (ask if none fits). Do not start implementing unless asked.

**Unclear request → 🌩️ storm ticket, not a split.** If the requirements or the right approach are not settled yet (the user says they don't know, or there are open design questions), write ONE ticket marked 🌩️ with an **Open questions** list, ask the user those questions, and split only after they are answered (see `references/conventions.md`). A storm ticket stays in `backlog.md` through discovery and splitting, with **Status** `discovery` (questions open) → `ready` (all answered); it, or a sub-ticket, moves to `doing.md` only when the user starts it, through the normal start ritual. Asked to start one still in `discovery`? Ask its open questions first; never answer them yourself in a plan. When resuming one, read its annotations and ask only what is still open.

**Big request → split first.** If one ticket could not ship on its own (several features, several layers, or several independently testable pieces), write a parent ticket plus sub-tickets `[APP-7a]`, `[APP-7b]`, … Each sub-ticket is a slice that can be implemented and verified on its own, and its **Depends on** names the sub-tickets it needs. The parent lists the sub-tickets in order, has an **Integration** field (the data/interfaces the sub-tickets must agree on, and one end-to-end check of the combined result), and stays in backlog until all are done.

**Start a ticket** — follow the start ritual in the header of `doing.md`:

1. **Move**: cut the ticket from `backlog.md` into "In progress", replacing the placeholder.
2. **Verify**: compare the current code/data with the ticket. Mismatch → stop and report.
3. **Plan**.
4. **Approve**: read the **Approval before coding** line in `doing.md` (default `medium, large, storm`). If it covers this ticket, reply with what you verified, the plan, and an explicit question asking the user to approve it — then **stop**; write no code until they do.
5. **Build.**

Sizing: **small** = one obvious change, a few lines, no design choice, no data/API/schema change. Anything else is **medium** or **large**. A **Size** field on the ticket wins. When unsure, treat it as medium.

🌩️ storm ticket (a structural problem built up across tickets, or a request whose right approach was unclear): before planning, read `references/conventions.md` and do the full re-review.

**Finish a ticket**: cut the entry out of `doing.md` (and out of `backlog.md` if a copy is there) and write a `done.md` entry at the **top**, under the header:

```markdown
## YYYY-MM-DD — [APP-12] Title
- **Shape**: what was actually built.
- **Verification**: how it was proven to work.
```

Add **Why / Decisions / Log** when there is something to say. If `doing.md` is now empty, write `(no ticket in progress)` (or the board language's equivalent, e.g. `（目前無進行中票）`). When the last sub-ticket of a parent is done, the parent's **Integration** check must still pass: run it (or ask the user to) and move the parent to `done.md` only then, with the result in its **Verification**. Passing sub-tickets alone do not close the parent.

**Blocked, rescoped, or storm ticket; phases**: see `references/conventions.md`.

**Older board without rules headers**: offer to add them from `templates/`.

## Hygiene check (after every board edit)

- [ ] No strikethrough (`~~`), ✅-in-place, or "moved to done.md" pointer lines anywhere
- [ ] `doing.md` holds only tickets truly in progress (or the placeholder)
- [ ] `backlog.md` holds only unstarted tickets
- [ ] Each ticket's entry exists in exactly one file (other entries may mention its ID)
- [ ] Rules headers are still at the top of each file
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
| Kanban section only in `CLAUDE.md` when the project uses `AGENTS.md` | Add it to every agent instruction file that exists |
| Moving a 🌩️ ticket to `doing.md` to discuss or split it | It stays in `backlog.md` until the user starts it |
| Filling in a `discovery` ticket's open questions yourself when asked to start | Ask them; defaults only as user-accepted 📌 assumptions |
| Refusing to start a sub-ticket because another is in progress | Several may run at once; only **Depends on** makes one wait |
| Executing a 🌩️ ticket as written | Re-review first (`references/conventions.md`) |
| Coding a medium ticket right after moving it | Verify, plan, then stop for approval |
| One huge ticket for a multi-part feature | Parent + shippable sub-tickets `[ID]a`, `[ID]b` |
| Splitting a request whose approach is still unknown | One 🌩️ ticket with open questions; ask first |
| Closing a parent because every sub-ticket passed | Run the parent's **Integration** check first |
| Reading all of `done.md` to add one entry | Header + newest entries; Grep for the rest |
| Deleting or skipping a file's rules header | Keep it; read it first |

See `references/examples.md` for before/after examples.
