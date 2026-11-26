---
type: regex
pattern: '###\s*\[APP-\d+\][^\n]*🌩'
match: contains
target: {source: file, path: kanban/backlog.md}
---
