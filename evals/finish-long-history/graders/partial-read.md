---
type: llm
focus: trace
---
Look at the tool calls the agent made on kanban/done.md (a 2,800-line file). PASS only if the agent never read the whole file: every Read of kanban/done.md used a small limit (roughly 100 lines or fewer), or it used Grep/search instead of reading. FAIL if any Read of kanban/done.md had no limit or a limit above 200 lines.
