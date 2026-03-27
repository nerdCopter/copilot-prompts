## Git commit and staging policy

- NEVER run `git add` or `git commit` automatically or proactively.
- NEVER stage files or commit changes unless the user explicitly commands such.
- Do NOT commit after completing a task.
- Completing a task does NOT constitute permission to commit.
- **Staging Files:** Prefer `git add -u` or `git add <files>`, Only stage when commanded. Never use `git add .` nor `git add -A`.
- **Commit Behavior:** If the user instructs you to stage and commit, do so once; thereafter do not auto-stage or auto-commit unless explicitly asked again.
