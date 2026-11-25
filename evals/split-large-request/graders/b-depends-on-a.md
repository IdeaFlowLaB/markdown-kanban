---
type: regex
pattern: '\[APP-\d+b\][\s\S]*?Depends on[^\n]*APP-\d+a'
match: contains
target: {source: file, path: kanban/backlog.md}
---
