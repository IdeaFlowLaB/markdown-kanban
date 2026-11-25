#!/usr/bin/env bash
# An existing board in Traditional Chinese; a new request should become a
# backlog ticket in the board's language, not get implemented right away.
set -e
mkdir -p kanban src
cat > kanban/backlog.md <<'MD'
# Backlog

### [APP-3] 批次刪除筆記
- **目標**：使用者可一次刪除多則筆記。
- **驗收**：全選＋刪除即移除；5 秒內可復原。
- **依賴**：無。
MD
cat > kanban/doing.md <<'MD'
# Doing

## 進行中

（目前無進行中票）
MD
cat > kanban/done.md <<'MD'
# Done

## 2026-03-01 — [APP-2] 匯出 CSV
- **形狀**：src/export/csv.ts。
- **驗證**：單元測試 12/12。
MD
echo "export {}" > src/index.ts
