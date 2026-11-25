---
type: llm
---
PASS only if the final response (1) shows the agent checked the current code against the ticket (e.g. mentions the Note interface in src/note.ts or listNotes in src/list.ts), (2) presents an implementation plan for APP-9, and (3) explicitly asks the user to approve the plan before any code is written. FAIL if the agent already started implementing tags.
