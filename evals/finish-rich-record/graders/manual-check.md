---
type: regex
pattern: '20k|20,000'
flags: i
match: contains
target: {source: file, path: kanban/done.md}
---
