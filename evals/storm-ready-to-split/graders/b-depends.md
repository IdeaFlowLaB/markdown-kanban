---
type: regex
pattern: '\[APP-12b\][\s\S]*?Depends on[^\n]*APP-12a'
match: contains
target: {source: file, path: kanban/backlog.md}
---
