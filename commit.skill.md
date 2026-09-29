---
name: commit
kind: skill
category: git
summary: "Stage, diff, and commit changes with strict policy enforcement."
description: |
  Use `/commit` to stage modified/new files, analyze diffs, and commit with proper message format. Follows strict commit policy and workflow rules.
---

# /commit Skill

**Purpose:** Stage git-tracked modified files and new files, analyze `git diff HEAD` thoroughly, and commit with proper message format.

**Workflow:**
0. **Announce:** Upon invocation, announce: "/commit skill activated: staging, diff analysis, and commit with strict policy enforcement."
1. Run `git status --porcelain` to identify modified tracked files and untracked files (respects `.gitignore`)
2. Stage tracked changes with `git add -u`; for new files, ask user or auto-stage if explicitly listed — **never use `git add .` or `git add -A`**
3. Run `git diff HEAD` and analyze the full changeset (not just recent edits)
4. Generate concise subject (~50 chars, imperative, clear) and a body describing the codebase
   change only — never build/test status, verification-check results, or process history (that
   belongs in a PR body, not the commit)
5. Execute the commit via a HEREDOC (per global `~/.claude/CLAUDE.md` § Committing changes with
   git), not separate `-m` flags — a multi-line body with quotes/special characters is fragile
   with `-m "..." -m "..."`:
   ```bash
   git commit -m "$(cat <<'EOF'
   type: subject

   body
   EOF
   )"
   ```
   - **Types:** `feat`, `fix`, `docs`, `refactor`, `style`, `perf`, `test`, `chore`, `build`, `ci`
6. After commit succeeds, output: "Commit successful." followed by the current branch name and worktree/working directory path (e.g. via `git rev-parse --abbrev-ref HEAD` and `git rev-parse --show-toplevel`), so the user always knows where to review/test.
7. Revert to default no-auto-commit behavior per COMMIT-POLICY.

**Key Rules:**
- Analyze the entire diff, not just agent-performed changes
- Never rely solely on chat history for commit context
- Subject: imperative mood, clear, actionable
- Description: explain _why_ and _what_ changed in the code — not test/build/verification status or process history
- Respect COMMIT-POLICY: never proactively stage/commit outside explicit `/commit` invocation

**Restricted Tools:** None — use terminal, git, file inspection as needed.

**Proceed only when:**
- The user explicitly invoked `/commit`
- The working directory has changes to commit
