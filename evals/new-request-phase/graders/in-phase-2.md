---
type: regex
pattern: '## Phase 2[\s\S]*?revok[\s\S]*?## Waiting on others'
flags: i
match: contains
target: {source: file, path: kanban/backlog.md}
---
