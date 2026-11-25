---
type: regex
pattern: 'moved to done'
flags: i
match: not_contains
target: {source: file, path: kanban/doing.md}
---
