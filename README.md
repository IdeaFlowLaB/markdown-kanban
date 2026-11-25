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

- "Add a ticket for PDF export." → a ticket in `backlog.md`
- "Start APP-7." → cut from backlog into `doing.md`
- "APP-7 is done, tests pass." → cut into `done.md` (newest first) with what shipped and how it was verified

The board's language follows your project — write tickets in any language.

## Rules in one screen

- **Every ticket lives in exactly one file, in full.** Moving = cutting the whole entry, never copying or striking through.
- `doing.md` holds only what is truly in progress; empty means `(no ticket in progress)`.
- `backlog.md` holds only unstarted tickets.
- `done.md` is the decision history: **Shape / Why / Decisions / Log / Verification**, newest on top.
- Leftovers already on the board are violations to clean up, not a convention to copy.

Advanced conventions (see [`references/conventions.md`](skills/markdown-kanban/references/conventions.md)):

- 🌩️ **Storm tickets** — structural problems that built up across many tickets. A normal ticket is executed as written; a storm ticket is *thought through* as written: re-review drift, root cause, better fixes and new landmines before writing code.
- ⛔ **Blocked** — stays in `doing.md`, says who or what it waits on.
- 📌 **Annotations** — splits and rescopes are added as dated notes instead of rewriting the original ticket.

## Evals

The skill ships with a [`claude plugin eval`](evals/) suite that runs each scenario with and without the skill (scores across several runs; the no-skill baseline varies run to run):

| Case | Without skill | With skill |
|---|---|---|
| finish-ticket | 0.60–0.80 | 1.00 |
| mark-done-messy (board already has leftovers) | 0.17–0.33 | 1.00 |
| init-board | 0.20 | 1.00 |
| start-storm-ticket | 0.60–1.00 | 1.00 |
| new-request | 1.00 | 1.00 |

Run it yourself:

```
claude plugin eval . --scaffold --allow-tools Write Edit
```

## License

[MIT](LICENSE) © IdeaFlowLaB
