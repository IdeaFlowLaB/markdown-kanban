---
type: regex
pattern: '^# Done\s*\n(?:>[^\n]*\n|\s*\n)*## [^\n]*APP-401'
match: contains
target: {source: file, path: kanban/done.md}
---
