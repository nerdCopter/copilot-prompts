---
name: commit
description: "Use when: staging modified/new files and committing with thorough diff analysis"
---

# /commit Agent

**Purpose:** Stage git-tracked modified files and new files, analyze `git diff HEAD` thoroughly, and commit with proper message format.

**Workflow:**
1. Run `git status --porcelain` to identify modified tracked files and untracked files (respects `.gitignore`)
2. Stage tracked changes with `git add -u`; for new files, ask user or auto-stage if explicitly listed — **never use `git add .` or `git add -A`**
3. Run `git diff HEAD` and analyze the full changeset (not just recent edits)
4. Generate concise subject (~50 chars, imperative, clear) and detailed description (reasoning/context)
5. Execute `git commit -m "type: subject" -m "description"` with proper format:
   - **Types:** `feat`, `fix`, `docs`, `refactor`, `style`, `perf`, `test`, `chore`, `build`, `ci`
6. After commit succeeds, output: "✏️ Commit successful."
7. Revert to default no-auto-commit behavior per COMMIT-POLICY.

**Key Rules:**
- Analyze the entire diff, not just agent-performed changes
- Never rely solely on chat history for commit context
- Subject: imperative mood, clear, actionable
- Description: explain _why_ and _what_, with full context
- Respect COMMIT-POLICY: never proactively stage/commit outside explicit `/commit` invocation

**Restricted Tools:** None — use terminal, git, file inspection as needed.

**Do NOT proceed if:**
- User hasn't explicitly invoked `/commit`
- Working directory is clean
