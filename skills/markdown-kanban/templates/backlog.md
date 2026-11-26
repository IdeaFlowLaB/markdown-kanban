# Backlog

> **What lives here**: unstarted tickets only, grouped by phase. The ticket being worked on is in `doing.md`; finished tickets are in `done.md`. A ticket ID never appears in two files.
> **Ticket format**: `### [ID] Title` + **Goal / Acceptance / Depends on** (optional: **Red lines**, **Size** S/M/L).
> **New request**: put it under the phase it belongs to. If no phase fits, ask before creating one.
> **Too big to ship in one go?** Split it into sub-tickets `[ID]a`, `[ID]b`, … (e.g. `[APP-7a]`, `[APP-7b]`). Each sub-ticket ships on its own and names what it depends on. The parent stays here as the overview, with an **Integration** field: what the sub-tickets must agree on (data, interfaces, errors) and one end-to-end check of the combined result. It closes only when that check passes.
> **Not sure yet what to build or how?** Don't split. Write one 🌩️ ticket with an **Open questions** list and settle them with the owner first.
> **Starting a ticket**: cut it into `doing.md`, then follow the start ritual written at the top of that file.
> 🌩️ **Storm ticket**: a structural problem that built up across many tickets, or a large request whose requirements or approach are not settled. A normal ticket is executed as written; a storm ticket is *thought through* as written: settle the open questions, then re-review drift, root cause, better fixes and new landmines before splitting or planning.
>
> **Common acceptance** (applies to every ticket; edit for your project):
> - Tests pass.
> - Board changes are committed together with the work.

## Phases

| Phase | Exit condition |
|---|---|
| Phase 1 — (name) | (what must be true to call this phase done) |

---

## Phase 1 — (name)

(no tickets yet)

## Waiting on others

> Not started because it depends on people or events outside this project. (A ticket blocked *mid-work* stays in `doing.md` marked ⛔.)

(nothing)

## Next wave

> Agreed to do, not yet split into tickets. Split before starting.

(nothing)

## Parked

> Not scheduled. Each item states the trigger that would bring it back.

(nothing)
