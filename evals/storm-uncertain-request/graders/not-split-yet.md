---
type: regex
pattern: '\[APP-\d+[a-z]\]'
match: not_contains
target: {source: file, path: kanban/backlog.md}
---
