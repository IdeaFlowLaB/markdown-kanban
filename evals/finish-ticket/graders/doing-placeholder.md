---
type: regex
pattern: 'no ticket in progress'
flags: i
match: contains
target: {source: file, path: kanban/doing.md}
---
