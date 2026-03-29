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
