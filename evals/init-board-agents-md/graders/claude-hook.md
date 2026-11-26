---
type: regex
pattern: 'kanban/doing\.md|@AGENTS\.md'
match: contains
target: {source: file, path: CLAUDE.md}
---
