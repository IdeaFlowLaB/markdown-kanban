#!/usr/bin/env bash
# A project whose agent instructions live in AGENTS.md (shared with other
# agents) and that has no CLAUDE.md. The board hook must reach both.
set -e
mkdir -p src
cat > AGENTS.md <<'MD'
# Agent instructions

- Run tests with `npm test`.
- ORIGINAL-AGENTS-KEEP
MD
echo "export {}" > src/index.ts
