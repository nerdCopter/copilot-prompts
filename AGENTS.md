## AGENTS.md

**Current active agents, skills, and instructions for this workspace:**

### Agents
Invoke with `/agent-name` in chat:
- `/research` — Comprehensive research, analysis, planning, and recommendations
- `/implementation` — Safe, best-practices implementation specialist for all code tasks

### Skills
Invoke with `/skill-name` in chat:
- `/commit` — Git commit workflow with staging and message management

### Instructions (Auto-applied)
Applied automatically based on file type matching (`applyTo` pattern):
- `GLOBAL.instructions.md` — Universal standards (all files)
- `LUAU.instructions.md` — Roblox Luau scripting standards (`**/*.lua`, `**/*.luau`)
- `RUST.instructions.md` — Rust conventions and best practices (`**/*.rs`, `**/*.toml`)
- `POWERSHELL.instructions.md` — PowerShell scripting standards (`**/*.ps1`, `**/*.psm1`, `**/*.psd1`)
- `YARN.instructions.md` — Yarn/npm best practices (`**/package.json`)
- `MARKDOWN.instructions.md` — Documentation and TOC standards (`**/*.md`)
- `VEEAM.instructions.md` — Veeam PowerShell scripting (Veeam-PowerShell/**/*.ps{1,m1})

### Prompts (Referenced by agents)
Not directly invoked; used as discipline/philosophy context:
- `implementation-specialist.prompt.md` — Implementation discipline and scope creep warnings
- `msdocs-assistant.prompt.md` — Microsoft Docs search and PowerShell validation

---

**See [README.md](README.md) for quick reference on agents, skills, and auto-applied instructions.**
