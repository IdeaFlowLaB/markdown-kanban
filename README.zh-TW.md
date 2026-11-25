# markdown-kanban

[English](README.md)

給 coding agent 用的看板，本體就是 repo 裡的三個 Markdown 檔：`kanban/backlog.md`、`kanban/doing.md`、`kanban/done.md`，跟著工作一起 commit 進版。

同時附上讓看板保持誠實的衛生規則。不管的話，agent（和人）都會讓看板慢慢走樣：完工的票被劃刪除線而不是移走、「✅ 已移入 done.md」的註記越積越多、開工的票還留在 backlog，下一個 session 還會把這些殘留當成慣例照抄。

## 安裝

**Claude Code**（plugin marketplace）：

```
/plugin marketplace add IdeaFlowLaB/markdown-kanban
/plugin install markdown-kanban@markdown-kanban
```

**其他 agent**（Cursor、Codex 等，透過 [skills](https://github.com/vercel-labs/skills)）：

```
npx skills add IdeaFlowLaB/markdown-kanban
```

**手動安裝**：把 `skills/markdown-kanban/` 複製到 `~/.claude/skills/`（或專案內的 `.claude/skills/`）。

## 使用

在任何專案裡說：

> 幫這個專案建一個看板。

會建好 `kanban/{backlog,doing,done}.md`，並在 `CLAUDE.md` 加一小段看板掛鉤，讓之後每個 session 開工前先讀 `doing.md`。之後照平常講話就好：

- 「開一張票：PDF 匯出。」→ 在 `backlog.md` 對應的階段底下開票
- 「我們要做筆記分享：分享連結、權限、撤銷畫面。」→ 一張母票，拆成可以各自出貨的子票 `[APP-7a]`、`[APP-7b]`……
- 「開始做 APP-7a。」→ 剪到 `doing.md`，接著走開工儀式：查證 → 計畫 →（核准）→ 實作
- 「APP-7a 做完了，測試全過。」→ 剪到 `done.md` 最上方，寫明做了什麼、怎麼驗證

看板語言跟著你的專案走，票用什麼語言寫都可以。

## 看板長什麼樣子

每個看板檔最上方都帶著自己的規則，所以不管誰打開，不論是人，還是沒載入這個 skill 的 agent，都看得懂這個看板怎麼運作。

- **`backlog.md`**：依**階段**分區（最上面有一張階段出口條件表），之後是「等外部」、「下一波」（已表態要做、還沒拆票）、「後備」（附上重新排程的觸發條件）。提醒區還有**共同驗收**，也就是每張票都要過的條件，由你自己填。
- **`doing.md`**：每張票的**開工儀式**：移入 → 查證程式碼跟票文還對得上 → 寫計畫 → 核准 → 實作。哪些票開工前要你核准，是一行可以直接改的設定：

  ```
  > **Approval before coding**: medium, large, storm
  > (options: `all` | `medium, large, storm` | `storm only`)
  ```

  預設下，小而明確的票（錯字、一行修正）會直接動手做。
- **`done.md`**：新的放最上面，一張票一條：**形狀／為何／裁決／執行紀錄／驗證**。

## 一頁看完規則

- **每張票只存在一個檔裡，而且是完整的一整條。** 移動就是整條剪走，不複製、不劃刪除線。
- `doing.md` 只放真正在做的票；沒有就寫「（目前無進行中票）」。
- `backlog.md` 只放還沒開工的票。
- `done.md` 是決策史：**形狀／為何／裁決／執行紀錄／驗證**，新的放最上面。
- 看板上已經存在的殘留是要清掉的違規，不是可以照抄的慣例。

進階慣例（見 [`references/conventions.md`](skills/markdown-kanban/references/conventions.md)）：

- 🌩️ **風暴單**：跨越多張票累積出來的結構性問題。一般票是「照票文做」，風暴單是「照票文想」：寫程式之前，先重新審查現況有沒有漂移、根因判斷是否仍成立、有沒有更好的解法、有沒有新的地雷。
- ⛔ **停工**：票留在 `doing.md`，寫明在等誰、等什麼決定。
- 📌 **加註**：拆票、升格、改範圍時加上日期註記，不改寫原文。

## 測試（Evals）

skill 附一套 [`claude plugin eval`](evals/) 測試，每個情境都分「有 skill」和「沒 skill」兩組跑（多輪測試的分數；沒 skill 那組每次會浮動）：

| 案例 | 沒 skill | 有 skill |
|---|---|---|
| finish-ticket（完工剪票） | 0.60–0.80 | 1.00 |
| mark-done-messy（看板本來就有殘留） | 0.17–0.33 | 1.00 |
| init-board（建看板：三檔、提醒區、階段、核准設定） | 0.11–0.20 | 1.00 |
| split-large-request（大需求拆子票） | 0.25 | 1.00 |
| start-medium-ticket（中型票：查證、計畫、停下等核准） | 0.40 | 1.00 |
| start-small-ticket（小票直接修） | 1.00 | 1.00 |
| approval-all-policy（改過的核准設定有被遵守） | 1.00 | 1.00 |
| start-storm-ticket（開工風暴單） | 0.60–1.00 | 1.00 |
| new-request（新需求開票） | 1.00 | 1.00 |
| new-request-phase（新需求放進對的階段） | 1.00 | 1.00 |

自己跑：

```
claude plugin eval . --scaffold --allow-tools Write Edit
```

## 授權

[MIT](LICENSE) © IdeaFlowLaB
