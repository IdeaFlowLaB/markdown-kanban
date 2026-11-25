#!/usr/bin/env bash
# A storm ticket whose text was written months ago; the code has since drifted
# (a third config loader appeared). The agent should re-review before implementing.
set -e
mkdir -p kanban src/config
cat > kanban/backlog.md <<'MD'
# Backlog

### [APP-7] 🌩️ Unify the two config loaders
- **Goal**: replace `src/config/env.ts` and `src/config/file.ts` with one `src/config/loader.ts`.
- **Acceptance**: one code path loads config; env.ts and file.ts deleted; existing config tests pass.
- **Depends on**: none.
- Written 2025-11-02.

### [APP-8] Settings page
- **Goal**: users can change display name.
- **Acceptance**: name persists after reload.
- **Depends on**: none.
MD
cat > kanban/doing.md <<'MD'
# Doing

## In progress

(no ticket in progress)
MD
cat > kanban/done.md <<'MD'
# Done
MD
cat > src/config/env.ts <<'TS'
// ORIGINAL-ENV: reads config from environment variables
export function fromEnv() {}
TS
cat > src/config/file.ts <<'TS'
// ORIGINAL-FILE: reads config from config.json
export function fromFile() {}
TS
cat > src/config/remote.ts <<'TS'
// Added 2026-02: fetches remote config at startup, bypasses env/file entirely
export function fromRemote() {}
TS
