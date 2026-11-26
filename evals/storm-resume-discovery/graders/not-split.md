---
type: regex
pattern: '\[APP-12[a-z]\]'
match: not_contains
target: {source: file, path: kanban/backlog.md}
---
