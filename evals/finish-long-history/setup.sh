#!/usr/bin/env bash
# A project with a long history: done.md holds 400 entries (~2,800 lines).
# Finishing a ticket should not mean reading or rewriting the whole history.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

## Phase 9 — Polish
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

### [APP-401] Remember the last opened note
- **Goal**: reopening the app shows the note the user had open.
- **Acceptance**: last note id survives a restart; a deleted note falls back to the list.
- **Depends on**: none.
MD
{
  printf '# Done\n'
  for i in $(seq 400 -1 1); do
    d=$(( (i % 28) + 1 ))
    printf '\n## 2025-%02d-%02d — [APP-%d] Historical change number %d\n' $(( (i % 12) + 1 )) "$d" "$i" "$i"
    printf -- '- **Shape**: changed module m%d so that feature f%d handles case c%d.\n' "$i" "$i" "$i"
    printf -- '- **Why**: users reported issue r%d; option o%d was rejected as too slow.\n' "$i" "$i"
    printf -- '- **Log**: tried approach a%d first, reverted, then shipped approach b%d.\n' "$i" "$i"
    printf -- '- **Verification**: unit tests %d/%d.\n' "$i" "$i"
  done
} > kanban/done.md
echo "export {}" > src/index.ts
