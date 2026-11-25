# Advanced conventions

Read this when a ticket is a 🌩️ storm ticket, gets blocked, changes scope, is split, or is being written up in `done.md`, or when organizing the backlog into phases.

## Phases (backlog layout)

`backlog.md` is grouped into sections, top to bottom:

| Section | Holds |
|---|---|
| `## Phases` table | one row per phase: name + exit condition (what must be true to call it done) |
| `## Phase N — name` | tickets planned for that phase, in rough order |
| `## Waiting on others` | not started; depends on people or events outside the project |
| `## Next wave` | agreed to do, not yet split into tickets — split before starting |
| `## Parked` | not scheduled; each item names the trigger that would bring it back |

When a phase's exit condition is met and its tickets are all in `done.md`, delete the phase section and mark the row in the table as done (with date).

## Splitting a big ticket

```markdown
### [APP-7] Note sharing (parent — split into 7a–7c)
- **Goal**: users can share notes with others.
- **Sub-tickets** (in order): [APP-7a] share link → [APP-7b] permissions → [APP-7c] revoke view.

### [APP-7a] Read-only share link
- **Goal**: …
- **Acceptance**: …
- **Depends on**: none.

### [APP-7b] Read-only vs. can-edit permissions
- **Goal**: …
- **Acceptance**: …
- **Depends on**: [APP-7a].
```

Each sub-ticket must be shippable on its own. Split by what can be verified independently (data first, then the layers that use it), not by job title. If a split happens after a ticket was written, annotate the original (see 📌 below).

## 🌩️ Storm tickets

A storm ticket touches a structural problem that built up across many tickets (tangled ownership, two competing implementations, a data model that no longer fits). Its text was written with what was known *then*.

**Rule: a normal ticket is executed as written; a storm ticket is *thought through* as written.**

Before starting a 🌩️ ticket, re-review the design and write the answers into the ticket (or a plan the user approves) *before* any implementation:

1. **Drift** — does the current code/data still match what the ticket assumes?
2. **Root cause** — is the diagnosis in the ticket still correct?
3. **Better fix** — is there a simpler or more complete approach now?
4. **New landmines** — what has changed that the ticket does not mention?

Only then start implementing. Executing a storm ticket verbatim freezes the blind spots of the moment it was written.

Mark storm tickets with 🌩️ right after the ID: `### [APP-7] 🌩️ Unify the two config loaders`.

## ⛔ Blocked tickets

A ticket that cannot proceed stays in `doing.md` and is marked, not silently left there:

```markdown
### [APP-8] Send reminder emails — ⛔ blocked 2026-03-02: waiting on owner's decision (upgrade the email plan vs. switch service)
- Blocker: the current email service's free plan no longer allows a custom sender domain; options and analysis below.
- Work paused: …
- Resume when: …
```

State **who** or **what** it waits on and **what would unblock it**. Do not move it back to backlog to make `doing.md` look clean, and do not keep working around the blocker without saying so.

## 📌 Annotations (split / promote / rescope)

When a ticket's scope changes after it was written, add a dated annotation instead of rewriting the original text, so the history of decisions stays readable:

```markdown
- 📌 Annotation ([APP-3], 2026-02-10): split — CSV export stays here; PDF export moved to [APP-9].
- 📌 Annotation (2026-02-14): promoted — owner asked to cover the admin view too.
```

- **Split**: create the new ticket in `backlog.md`, annotate both tickets with each other's IDs.
- **Promote / rescope**: annotate with what changed and who decided.
- Never silently edit the Goal or Acceptance of a ticket someone already agreed to.

## `done.md` entries

Newest entry at the top, directly under the file's header. One entry per finished ticket:

```markdown
## 2026-03-05 — [APP-2] Export notes as CSV
- **Shape**: what was actually built (files, endpoints, commands) — the final form, not the plan.
- **Why**: the reason behind non-obvious choices.
- **Decisions**: what the owner/user decided, with date, if anything was decided.
- **Log**: notable steps, surprises, dead ends.
- **Verification**: how it was proven to work (tests, manual checks, numbers).
```

Fields with nothing to say may be omitted, but **Shape** and **Verification** are always present. `done.md` is the project's auditable decision history — write it so someone reading it in a year understands what shipped and why.
