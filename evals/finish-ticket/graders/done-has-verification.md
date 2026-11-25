---
type: regex
pattern: 'APP-2[\s\S]*Verification[\s\S]*APP-1'
match: contains
target: {source: file, path: kanban/done.md}
---
