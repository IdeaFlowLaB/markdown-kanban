# markdown-kanban — contributor notes

This repo is a Claude Code plugin **and** its own marketplace (`.claude-plugin/marketplace.json` lists one plugin with `source: "./"`). The only component is the skill in `skills/markdown-kanban/`.

## Layout

- `skills/markdown-kanban/SKILL.md` — always-loaded part; keep it short. Details go in `references/`.
- `skills/markdown-kanban/templates/` — files copied into a user's project on "set up a kanban board".
- `evals/<case>/` — `claude plugin eval` cases: `case.yaml` (prompt + `scaffold_script`), `setup.sh` (fixture), `graders/*.md`.

## Commands

```
claude plugin validate .
claude plugin eval . --scaffold --allow-tools Write Edit --no-publish            # with vs. without skill
claude plugin eval . --case mark-done-messy --runs 1 --scaffold --allow-tools Write Edit --no-publish
```

## Rules for changing the skill

- Test first: add or adjust an eval case that fails without the change, then edit the skill and confirm the `with` arm passes. Do not edit `SKILL.md` without a run.
- `description` in `SKILL.md` frontmatter states **when** to use the skill only — never a summary of the workflow.
- Examples and fixtures use neutral, made-up domains (notes app, config loaders, reminder emails). Never copy text from a real project's board.
- Bump `version` in both `.claude-plugin/plugin.json` and `marketplace.json` together.
