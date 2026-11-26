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
- **Integration**: all three use the share record `{noteId, role, revokedAt}` defined in 7a; errors are shown with the app's existing toast. End-to-end check: create a can-edit link → open it as another user and edit → revoke it → the link returns 404.

### [APP-7a] Read-only share link
- **Goal**: …
- **Acceptance**: …
- **Depends on**: none.

### [APP-7b] Read-only vs. can-edit permissions
- **Goal**: …
- **Acceptance**: …
- **Depends on**: [APP-7a].
```

Each sub-ticket must be a slice that can be implemented and verified on its own; what it needs from other sub-tickets is stated in **Depends on** (7b needs 7a, and says so). Don't over-split to make every piece independent. Split by what can be verified independently (data first, then the layers that use it), not by job title. If a split happens after a ticket was written, annotate the original (see 📌 below).

**Integration** is written when splitting, by looking at the sub-tickets together: which data shapes, interfaces and error states they must agree on; whether two of them would build the same thing; whether the order in **Depends on** works; and one end-to-end check of the combined result. Every sub-ticket can pass on its own while the whole still fails — so the parent closes only after that end-to-end check passes, recorded in its `done.md` **Verification**.

## 🌩️ Storm tickets

A storm ticket is work whose right answer is not known when it is written:

- a **structural problem** that built up across many tickets (tangled ownership, two competing implementations, a data model that no longer fits), or
- a **large request whose requirements or approach are not settled** (the user is unsure how it should behave, or there are several plausible designs).

Its text records what was known *then*. A plain bug with a known fix is not a storm ticket.

**Rule: a normal ticket is executed as written; a storm ticket is *thought through* as written.**

Storm flow — everything before the formal start happens in `backlog.md`; discussing or splitting a storm ticket is not starting it. Starting means the user asks to start it; then the normal start ritual applies (move, re-review, plan, approval):

1. **Capture** — one 🌩️ ticket with what is known, an **Open questions** list and **Status**: `discovery`. Do not split it yet.
2. **Settle** — research the code and ask the user until the open questions are answered; record each answer as a 📌 annotation, so a later session can resume without asking again. When all are answered, set **Status**: `ready`.
3. **Re-review** — before splitting (or before starting, if it needs no split), answer the four questions below.
4. **Split** — into normal sub-tickets with a parent **Integration** field (see above). The 🌩️ ticket stays in `backlog.md` as the parent; the sub-tickets move to `doing.md` one at a time through the normal start ritual.

```markdown
### [APP-12] 🌩️ Offline editing with sync
- **Status**: discovery
- **Goal**: notes can be edited offline and sync when back online.
- **Open questions**: how are conflicting edits resolved? does the server need a change? which data is cached?
- **Depends on**: answers to the open questions.
```

Before splitting or starting a 🌩️ ticket, re-review the design and write the answers into the ticket (or a plan the user approves) *before* any implementation:

1. **Drift** — does the current code/data still match what the ticket assumes?
2. **Root cause / underlying need** — for a structural problem: is the diagnosis in the ticket still correct? For a new request: what need is behind it, and which recorded assumptions still hold in the code? (Don't invent a root cause for a new feature.)
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

Fields with nothing to say may be omitted, but **Shape** and **Verification** are always present. `done.md` is the project's auditable decision history — write it so someone reading it in a year understands what shipped and why, in short bullets rather than narrative. Because it only grows, agents read its header and newest entries and search the rest by ticket ID; never re-summarize or rewrite old entries.

**Token efficiency applies to reading history, not to recording it.** For a significant change, the entry still keeps: the important modules touched, why this design, the options rejected and why, data/API changes, what was tested, and known limitations.
