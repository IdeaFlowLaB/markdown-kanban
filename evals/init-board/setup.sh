#!/usr/bin/env bash
# A project with an existing CLAUDE.md and no board yet.
set -e
mkdir -p src
cat > CLAUDE.md <<'MD'
# Project notes

- Run tests with `npm test`.
- ORIGINAL-NOTES-KEEP
MD
echo "# Demo app" > README.md
echo "export {}" > src/index.ts
