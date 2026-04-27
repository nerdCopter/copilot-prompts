# Copilot Customization: Quick Reference

## Agents

| Name | Invocation | When to Use |
|------|-----------|-----------|
| **Research Agent** | `/research` | Planning, architecture analysis, investigating patterns, researching best practices |
| **Implementation Agent** | `/implementation` | Writing code, refactoring, bug fixes, feature implementation |

---

## Skills

| Name | Invocation | When to Use |
|------|-----------|-----------|
| **Commit Skill** | `/commit` | Staging changes and creating commits |

---

## Instructions (Auto-applied)

Auto-applied to matching files — **no invocation needed**:

| File Pattern | Rules Applied |
|--------------|---------------|
| `**/*.lua`, `**/*.luau` | Luau best practices, syntax standards |
| `**/*.rs`, `**/*.toml` | Rust conventions, error handling patterns |
| `**/*.ps1`, `**/*.psm1`, `**/*.psd1` | PowerShell scripting standards |
| `**/package.json` | Yarn/npm best practices |
| All files | Global standards (GLOBAL.instructions.md) |

---

## Commit Policy: No Auto-Commit by Default

**This codebase enforces strict no-auto-commit behavior.** Agents and instructions explicitly forbid staging or committing changes unless you explicitly request it via the `/commit` skill.

**Why?** Most AI agents auto-commit after tasks, bypassing user validation. This design inverts such. _You_ control when changes are staged and committed.

**How to commit:**
- Use `/commit` in chat to stage, analyze, and commit changes
- After you invoke `/commit` once, the agent returns to no-auto-commit mode
- For safer non-committal workflows, explicitly invoke the Implementation Agent
- See [COMMIT-POLICY.instructions.md](COMMIT-POLICY.instructions.md) for full policy details

⚠️  **Important:** This policy may not work consistently across all scenarios. The [Implementation Agent](implementation.agent.md) is specifically designed to reinforce no-auto-commit behavior when delegated tasks, but enforcement depends on proper agent invocation and instruction adherence. Consider using commands such as **"Enable Auto-Commit mode"** or **"Disable auto-commit mode"** to temporarily override the default behavior

---

## How to Use

**Agents:**
- Type `/research` or `/implementation` in chat to switch modes
- Agents change Copilot's behavior, prompt depth, and available tools
- Each agent has specific "when to use" triggers and handoff protocols

**Skills:**
- Type `/commit` in chat to enter commit workflow

**Instructions:**
- Applied automatically when editing matching file types
- No action needed; Copilot automatically follows these standards

---

## Recommended Locations

| Platform | VS Code Path | Claude Code Path* |
|---|---|---|
| Linux | `~/.config/Code/User/prompts/` | `~/.claude/` |
| Windows | `%APPDATA%\Code\User\prompts\` | `%LOCALAPPDATA%\Claude\` |
| macOS | `~/Library/Application Support/Code/User/prompts/` | `~/Library/Application Support/Claude/` |

*Use the `claude-link-*` scripts to create symlinks in Claude Code directories.

---

## Installation

### Quick Setup (Recommended)

When you clone this repository, use these scripts to install the files to their proper locations:

#### Linux
```bash
./scripts/install-linux.sh
```
Copies files to: `~/.config/Code/User/prompts/`

#### macOS
```bash
./scripts/install-macos.sh
```
Copies files to: `~/Library/Application Support/Code/User/prompts/`

#### Windows
**PowerShell (Recommended):**
```powershell
.\scripts\install-windows.ps1
```

**Batch:**
```cmd
scripts\install-windows.bat
```
Copies files to: `%APPDATA%\Code\User\prompts\`

---

## Claude Code Integration

For Claude Code integration, use the claude-link scripts to create symlinks:

#### Linux
```bash
./scripts/claude-link-linux.sh
```
Creates symlinks in: `~/.claude/`

#### macOS
```bash
./scripts/claude-link-macos.sh
```
Creates symlinks in: `~/Library/Application Support/Claude/`

#### Windows
```powershell
.\scripts\claude-link-windows.ps1
```
Creates symlinks in: `%LOCALAPPDATA%\Claude\`
