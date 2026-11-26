# markdown-kanban

給 coding agent 用的看板，本體就是 repo 裡的三個 Markdown 檔：`kanban/backlog.md`、`kanban/doing.md`、`kanban/done.md`，跟著工作一起 commit 進版。

A kanban board for coding agents that is just three Markdown files in your repo — `kanban/backlog.md`, `kanban/doing.md`, `kanban/done.md` — versioned in the same commits as the work they describe.

同時附上讓看板保持誠實的衛生規則。不管的話，agent（和人）都會讓看板慢慢走樣：完工的票被劃刪除線而不是移走、「✅ 已移入 done.md」的註記越積越多、開工的票還留在 backlog，下一個 session 還會把這些殘留當成慣例照抄。

It comes with the hygiene rules that keep such a board honest, because left alone agents (and people) drift: tickets get struck through instead of moved, "✅ moved to done.md" notes pile up, started tickets stay in the backlog, and the next session copies the mess as if it were the convention.

## 安裝 · Install

**Claude Code**（plugin marketplace）：

```
/plugin marketplace add IdeaFlowLaB/markdown-kanban
/plugin install markdown-kanban@markdown-kanban
```

**其他 agent**（Cursor、Codex 等，透過 [skills](https://github.com/vercel-labs/skills)）：

**Other agents** (Cursor, Codex, … via [skills](https://github.com/vercel-labs/skills)):

```
npx skills add IdeaFlowLaB/markdown-kanban
```

**手動安裝**：把 `skills/markdown-kanban/` 複製到 `~/.claude/skills/`（或專案內的 `.claude/skills/`）。

**Manual**: copy `skills/markdown-kanban/` into `~/.claude/skills/` (or your project's `.claude/skills/`).

## 使用 · Use

在任何專案裡說：

In any project, say:

> 幫這個專案建一個看板。
>
> Set up a kanban board for this project.

會建好 `kanban/{backlog,doing,done}.md`，並在 agent 的指令檔加一小段看板掛鉤：Claude Code 是 `CLAUDE.md`，Codex、Cursor 等會讀 `AGENTS.md` 的 agent 是 `AGENTS.md`，兩個都有就兩個都加。這樣之後每個 session 開工前都會先讀 `doing.md`。如果你的 agent 兩個檔都不讀，請自己把[這段掛鉤](skills/markdown-kanban/templates/claude-md-snippet.md)貼進它的專案規則，不然只有在觸發 skill 時才會用到看板。

This creates `kanban/{backlog,doing,done}.md` and appends a short Kanban section to your agent instruction file — `CLAUDE.md` for Claude Code, `AGENTS.md` for Codex, Cursor and other agents that read it (both, if both exist) — so every future session reads `doing.md` before starting work. If your agent reads neither file, paste [the snippet](skills/markdown-kanban/templates/claude-md-snippet.md) into its project rules yourself; otherwise it only uses the board when the skill is triggered.

之後照平常講話就好：

From then on, talk normally:

- 「開一張票：PDF 匯出。」→ 在 `backlog.md` 對應的階段底下開票
- 「我們要做筆記分享：分享連結、權限、撤銷畫面。」→ 一張母票，拆成可以各自實作、驗證的子票 `[APP-7a]`、`[APP-7b]`……，母票另外寫一條**整合**檢查，確認各子票合起來能用
- 「筆記要能離線編輯，但我還不知道衝突要怎麼處理。」→ 先開一張 🌩️ 風暴單，列出待決問題，跟你談定之後才拆票
- 「開始做 APP-7a。」→ 開工：剪到 `doing.md`，接著走開工儀式：查證 → 計畫 →（核准）→ 實作
- 「APP-7a 做完了，測試全過。」→ 剪到 `done.md` 最上方，寫明做了什麼、怎麼驗證

<!-- -->

- "Add a ticket for PDF export." → a ticket in `backlog.md`, under the phase it belongs to
- "We need note sharing with links, permissions and a revoke screen." → a parent ticket split into sub-tickets `[APP-7a]`, `[APP-7b]`, … that can each be built and verified on their own, plus an **Integration** check that proves the pieces work together
- "Notes should work offline, but I don't know how conflicts should work." → one 🌩️ storm ticket with the open questions, which are settled with you before anything is split
- "Start APP-7a." → the ticket is started: cut into `doing.md`, then the start ritual: verify → plan → (approval) → build
- "APP-7a is done, tests pass." → cut into `done.md` (newest first) with what shipped and how it was verified

看板語言跟著你的專案走，票用什麼語言寫都可以。

The board's language follows your project — write tickets in any language.

## 看板長什麼樣子 · What the board looks like

每個看板檔最上方都帶著自己的規則，所以不管誰打開，不論是人，還是沒載入這個 skill 的 agent，都看得懂這個看板怎麼運作。

Every board file starts with its own rules, so anyone who opens it — a person, or an agent that never loaded this skill — sees how the board works.

**`backlog.md`**：依**階段**分區（最上面有一張階段出口條件表），之後是「等外部」、「下一波」（已表態要做、還沒拆票）、「後備」（附上重新排程的觸發條件）。提醒區還有**共同驗收**，也就是每張票都要過的條件，由你自己填。

**`backlog.md`** — grouped into **phases** (with a table of exit conditions), then *Waiting on others*, *Next wave* (agreed, not yet split) and *Parked* (with the trigger that would bring it back). The header also holds your **common acceptance** criteria that every ticket must meet.

**`doing.md`**：每張票的**開工儀式**：移入 → 查證程式碼跟票文還對得上 → 寫計畫 → 核准 → 實作。哪些票在實作前要你核准，是一行可以直接改的設定：

**`doing.md`** — the **start ritual** for every ticket: move → verify the code still matches the ticket → plan → approval → build. Which tickets need your approval before coding is one line you can edit:

```
> **Approval before coding**: medium, large, storm
> (options: `all` | `medium, large, storm` | `storm only`)
```

預設下，小而明確的票（錯字、一行修正）會直接動手做。

Small, obvious tickets (a typo, a one-line fix) go straight to building under the default.

**`done.md`**：新的放最上面，一張票一條：**形狀／為何／裁決／執行紀錄／驗證**。歷史全部保留，但 agent 只讀檔頭和最新幾筆，其餘用票號搜尋，歷史再長也不會吃光 context。

**`done.md`** — newest first, one entry per ticket: **Shape / Why / Decisions / Log / Verification**. It keeps everything, but agents read only its header and newest entries and search the rest by ticket ID, so a long history does not eat the context window.

## 一頁看完規則 · Rules in one screen

- **每張票只存在一個檔裡，而且是完整的一整條。** 移動就是整條剪走，不複製、不劃刪除線。
- `doing.md` 只放真正在做的票；沒有就寫「（目前無進行中票）」。
- `backlog.md` 只放還沒開工的票。
- `done.md` 是決策史：**形狀／為何／裁決／執行紀錄／驗證**，新的放最上面。
- 母票要等**整合**檢查通過才結案，不是子票全過就算完成。
- `done.md` 預設不整份讀，舊紀錄不改寫、不重新摘要。省 context 只省在讀取，記錄時不省。
- 看板上已經存在的殘留是要清掉的違規，不是可以照抄的慣例。

<!-- -->

- **Every ticket lives in exactly one file, in full.** Moving = cutting the whole entry, never copying or striking through.
- `doing.md` holds only what is truly in progress; empty means `(no ticket in progress)`.
- `backlog.md` holds only unstarted tickets.
- `done.md` is the decision history: **Shape / Why / Decisions / Log / Verification**, newest on top.
- A parent ticket closes only when its **Integration** check passes, not just because every sub-ticket did.
- `done.md` is never read whole by default, and old entries are never rewritten or re-summarized. Saving context applies to reading, never to what gets recorded.
- Leftovers already on the board are violations to clean up, not a convention to copy.

## 進階慣例 · Advanced conventions

詳見 [`references/conventions.md`](skills/markdown-kanban/references/conventions.md)。

See [`references/conventions.md`](skills/markdown-kanban/references/conventions.md).

🌩️ **風暴單**：寫票當下還不知道正解的工作，包括跨越多張票累積出來的結構性問題，以及需求或做法還沒定案的大需求。一般票是「照票文做」，風暴單是「照票文想」：列出待決問題 → 跟負責人談定 → 重新審查現況有沒有漂移、根因判斷是否仍成立（新需求則改問背後真正的需求與前提假設）、有沒有更好的解法、有沒有新的地雷 → 拆成一般票。這些都在 `backlog.md` 進行，用**狀態**欄位標示 `discovery`（探索中）→ `ready`（可拆票）。你說「開始做」才算開工，這時才移進 `doing.md`。

🌩️ **Storm tickets** — work whose right answer is not known when it is written: a structural problem that built up across many tickets, or a large request whose requirements or approach are not settled. A normal ticket is executed as written; a storm ticket is *thought through* as written: capture the open questions → settle them with the owner → re-review drift, root cause (or the underlying need and assumptions, for a new request), better fixes and new landmines → split into normal tickets. All of this happens in `backlog.md`, tracked by a **Status** of `discovery` → `ready`. It moves into `doing.md` only when you start it.

⛔ **停工**：票留在 `doing.md`，寫明在等誰、等什麼決定。

⛔ **Blocked** — stays in `doing.md`, says who or what it waits on.

📌 **加註**：拆票、升格、改範圍時加上日期註記，不改寫原文。

📌 **Annotations** — splits and rescopes are added as dated notes instead of rewriting the original ticket.

## 測試 · Evals

skill 附一套 [`claude plugin eval`](evals/) 測試，每個情境都分「有 skill」和「沒 skill」兩組跑（多輪測試的分數；沒 skill 那組每次會浮動）。

The skill ships with a [`claude plugin eval`](evals/) suite that runs each scenario with and without the skill (scores across several runs; the no-skill baseline varies run to run).

| 案例 · Case | 沒 skill · Without | 有 skill · With |
|---|---|---|
| finish-ticket（完工剪票 · finish a ticket） | 0.60–0.80 | 1.00 |
| mark-done-messy（看板本來就有殘留 · board already has leftovers） | 0.17–0.33 | 1.00 |
| init-board（建看板：三檔、提醒區、階段、核准設定 · files, rules headers, phases, approval line） | 0.11–0.20 | 1.00 |
| init-board-agents-md（掛鉤也寫進 AGENTS.md · hook also lands in `AGENTS.md`） | 0.33 | 1.00 |
| split-large-request（大需求拆子票＋整合欄位 · sub-tickets + integration field） | 0.20 | 1.00 |
| finish-last-subticket（母票等整合檢查才結案 · parent waits for its integration check） | 0.00 | 1.00 |
| storm-uncertain-request（需求不明 → 風暴單＋提問 · unclear request → storm ticket + questions） | 0.33–0.67 | 1.00 |
| storm-resume-discovery（新 session 接手：只問還沒答的 · new session asks only what is still open） | 1.00 | 1.00 |
| storm-ready-to-split（在 backlog 拆票＋整合欄位 · split in backlog, with integration） | 0.40 | 1.00 |
| start-storm-ticket（開工風暴單 · start a storm ticket） | 0.60–1.00 | 1.00 |
| start-medium-ticket（中型票：查證、計畫、停下等核准 · verify, plan, stop for approval） | 0.40 | 1.00 |
| start-small-ticket（小票直接修 · just fix it） | 1.00 | 1.00 |
| approval-all-policy（改過的核准設定有被遵守 · edited policy is obeyed） | 1.00 | 1.00 |
| finish-long-history（2,800 行的 done.md：只讀開頭 · read only the top of a 2,800-line `done.md`） | 0.67 | 1.00 |
| finish-rich-record（done 保留決策脈絡 · decision context kept in `done.md`） | 0.00 | 1.00 |
| new-request（新需求開票 · new request） | 1.00 | 1.00 |
| new-request-phase（新需求放進對的階段 · new request lands in the right phase） | 1.00 | 1.00 |

自己跑：

Run it yourself:

```
claude plugin eval . --scaffold --allow-tools Write Edit
```

## 授權 · License

[MIT](LICENSE) © IdeaFlowLaB
