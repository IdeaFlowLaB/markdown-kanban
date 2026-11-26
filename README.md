# markdown-kanban

[繁體中文](README.zh-TW.md)

A kanban board for coding agents that is just three Markdown files in your repo — `kanban/backlog.md`, `kanban/doing.md`, `kanban/done.md` — versioned in the same commits as the work they describe.

It comes with the hygiene rules that keep such a board honest, because left alone agents (and people) drift: tickets get struck through instead of moved, "✅ moved to done.md" notes pile up, started tickets stay in the backlog, and the next session copies the mess as if it were the convention.

## Install

**Claude Code** (plugin marketplace):

```
/plugin marketplace add IdeaFlowLaB/markdown-kanban
/plugin install markdown-kanban@markdown-kanban
```

**Other agents** (Cursor, Codex, … via [skills](https://github.com/vercel-labs/skills)):

```
npx skills add IdeaFlowLaB/markdown-kanban
```

**Manual**: copy `skills/markdown-kanban/` into `~/.claude/skills/` (or your project's `.claude/skills/`).

## Use

In any project, say:

> Set up a kanban board for this project.

This creates `kanban/{backlog,doing,done}.md` and appends a short Kanban section to `CLAUDE.md`, so every future session reads `doing.md` before starting work. From then on, talk normally:

- "Add a ticket for PDF export." → a ticket in `backlog.md`, under the phase it belongs to
- "We need note sharing with links, permissions and a revoke screen." → a parent ticket split into shippable sub-tickets `[APP-7a]`, `[APP-7b]`, …, plus an **Integration** check that proves the pieces work together
- "Notes should work offline, but I don't know how conflicts should work." → one 🌩️ storm ticket with the open questions, which are settled with you before anything is split
- "Start APP-7a." → cut into `doing.md`, then the start ritual: verify → plan → (approval) → build
- "APP-7a is done, tests pass." → cut into `done.md` (newest first) with what shipped and how it was verified

The board's language follows your project — write tickets in any language.

## What the board looks like

Every board file starts with its own rules, so anyone who opens it — a person, or an agent that never loaded this skill — sees how the board works.

- **`backlog.md`** — grouped into **phases** (with a table of exit conditions), then *Waiting on others*, *Next wave* (agreed, not yet split) and *Parked* (with the trigger that would bring it back). The header also holds your **common acceptance** criteria that every ticket must meet.
- **`doing.md`** — the **start ritual** for every ticket: move → verify the code still matches the ticket → plan → approval → build. Which tickets need your approval before coding is one line you can edit:

  ```
  > **Approval before coding**: medium, large, storm
  > (options: `all` | `medium, large, storm` | `storm only`)
  ```

  Small, obvious tickets (a typo, a one-line fix) go straight to building under the default.
- **`done.md`** — newest first, one entry per ticket: **Shape / Why / Decisions / Log / Verification**. It keeps everything, but agents read only its header and newest entries and search the rest by ticket ID, so a long history does not eat the context window.

## Rules in one screen

- **Every ticket lives in exactly one file, in full.** Moving = cutting the whole entry, never copying or striking through.
- `doing.md` holds only what is truly in progress; empty means `(no ticket in progress)`.
- `backlog.md` holds only unstarted tickets.
- `done.md` is the decision history: **Shape / Why / Decisions / Log / Verification**, newest on top.
- A parent ticket closes only when its **Integration** check passes, not just because every sub-ticket did.
- `done.md` is never read whole by default, and old entries are never rewritten or re-summarized.
- Leftovers already on the board are violations to clean up, not a convention to copy.

Advanced conventions (see [`references/conventions.md`](skills/markdown-kanban/references/conventions.md)):

- 🌩️ **Storm tickets** — work whose right answer is not known when it is written: a structural problem that built up across many tickets, or a large request whose requirements or approach are not settled. A normal ticket is executed as written; a storm ticket is *thought through* as written: capture the open questions → settle them with the owner → re-review drift, root cause, better fixes and new landmines → split into normal tickets.
- ⛔ **Blocked** — stays in `doing.md`, says who or what it waits on.
- 📌 **Annotations** — splits and rescopes are added as dated notes instead of rewriting the original ticket.

## Evals

The skill ships with a [`claude plugin eval`](evals/) suite that runs each scenario with and without the skill (scores across several runs; the no-skill baseline varies run to run):

| Case | Without skill | With skill |
|---|---|---|
| finish-ticket | 0.60–0.80 | 1.00 |
| mark-done-messy (board already has leftovers) | 0.17–0.33 | 1.00 |
| init-board (files, rules headers, phases, approval line) | 0.11–0.20 | 1.00 |
| split-large-request (sub-tickets + integration field) | 0.20 | 1.00 |
| finish-last-subticket (parent waits for its integration check) | 0.00 | 1.00 |
| storm-uncertain-request (unclear request → storm ticket + questions) | 0.33–0.67 | 1.00 |
| finish-long-history (2,800-line `done.md`: read only the top) | 0.67 | 1.00 |
| start-medium-ticket (verify, plan, stop for approval) | 0.40 | 1.00 |
| start-small-ticket (just fix it) | 1.00 | 1.00 |
| approval-all-policy (edited policy is obeyed) | 1.00 | 1.00 |
| start-storm-ticket | 0.60–1.00 | 1.00 |
| new-request | 1.00 | 1.00 |
| new-request-phase | 1.00 | 1.00 |

Run it yourself:

```
claude plugin eval . --scaffold --allow-tools Write Edit
```

## License

[MIT](LICENSE) © IdeaFlowLaB
