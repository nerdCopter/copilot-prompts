---
name: GLOBAL instructions
applyTo: '**'
---

## Git commit and staging policy

### **[Enforcement Notice]**
- When this policy is enforced, determine the current commit mode from context and announce accordingly:
  - If no explicit commit instruction has been given this session: announce "Commit policy active: **no-auto-commit mode** — explicit user command required."
  - If the user has explicitly instructed staging/committing this session: announce "Commit policy active: **commit mode** — will stage and commit when tasks complete."

### Policy:

- NEVER run `git add` or `git commit` automatically or proactively.
- NEVER stage files or commit changes unless the user explicitly commands such.
- Do NOT commit after completing a task.
- Completing a task does NOT constitute permission to commit.
- **Staging Files:** Prefer `git add -u` or `git add <files>`. Only stage when commanded. Never use `git add .` nor `git add -A`.
- **Commit Behavior:** If the user instructs you to stage and commit, do so once; thereafter do not auto-stage or auto-commit unless explicitly asked again.
