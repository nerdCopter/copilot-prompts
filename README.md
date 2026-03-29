# Copilot Customization Files Reference

## File Types & Invocation

| File Type | Filename Pattern | Invocation | Purpose |
|-----------|-----------------|-----------|---------|
| **Agent** | `*.agent.md` | `/agent-name` | Defines a callable agent with persona, capabilities, and tool restrictions. Orchestrates how Copilot behaves for a task type. |
| **Prompt** | `*.prompt.md` | Referenced by agents/docs | Defines discipline, philosophy, or behavioral rules. Used as context for agents, not directly invoked. |
| **Skill** | `*.skill.md` | `/skill skill-name` | Defines a reusable skill/capability. Narrower scope than agents; can be chained or composed. |
| **Instructions** | `*.instructions.md` | Auto-applied | Language/framework/domain-specific rules. Applied to matching file types via `applyTo` front-matter. |

---

## Detailed Breakdown

### `.agent.md` — Callable Agent
**Example:** `research.agent.md`, `implementation.agent.md`

**Invocation:** `/research` or `/implementation` in chat

**Contains:**
- Front-matter: `name`, `description`
- Purpose & scope
- Core principles & capabilities
- When/when-not to use
- Handoff protocol

**Effect:** Changes Copilot's persona and tool access for the conversation.

---

### `.prompt.md` — Discipline/Philosophy Document
**Example:** `implementation-specialist.prompt.md`

**Invocation:** Referenced by agents/instructions (not a chat command)

**Contains:**
- Behavioral rules and discipline
- Examples (good/bad patterns)
- Scope creep warnings
- Core principles

**Effect:** Shapes how AI tools reason about a task. Used as reference context in agents.

---

### `.skill.md` — Reusable Skill
**Example:** `commit.skill.md` (currently named `commit.skill.md`)

**Invocation:** `/skill skill-name` in chat

**Contains:**
- Front-matter: `name`, `kind: skill`, `category`, `summary`
- Purpose & workflow
- Key rules
- Restricted tools
- Do-not-proceed conditions

**Effect:** Provides a focused, chainable capability for specific workflows.

---

### `.instructions.md` — Domain-Specific Rules
**Example:** `LUAU.instructions.md`, `RUST.instructions.md`, `POWERSHELL.instructions.md`

**Invocation:** Auto-applied based on `applyTo` pattern (no chat command)

**Front-matter:**
```yaml
---
name: LUAU instructions
applyTo: "**/*.lua,**/*.luau"
description: "..."
---
```

**Contains:**
- Language/framework standards
- Best practices
- Naming conventions
- Formatting rules
- Architecture patterns

**Effect:** Automatically applied when editing files matching `applyTo` pattern.

---

## Quick Reference: What to Create?

| Need | Create | Invocation |
|------|--------|-----------|
| Chat task persona (research, implement, debug, etc.) | `.agent.md` | `/agent-name` |
| Behavioral discipline/philosophy | `.prompt.md` | Referenced in agents |
| Single-purpose workflow | `.skill.md` | `/skill skill-name` |
| Language/framework standards | `.instructions.md` | Auto-applied |
| Global rules (all files) | `GLOBAL.instructions.md` | Auto-applied |

---

## Example Structure

```
prompts/
├── GLOBAL.instructions.md          # Global standards
├── LUAU.instructions.md            # Luau-specific rules
├── RUST.instructions.md            # Rust-specific rules
├── research.agent.md               # Research agent (/research)
├── implementation.agent.md         # Implementation agent (/implementation)
├── implementation-specialist.prompt.md  # Philosophy for implementation
├── commit.skill.md                 # Commit skill (/skill commit)
└── AGENT-MODEL-BACKUP.md          # Backup data (not tracked)
```

---

## File Metadata

All files support YAML front-matter:
```yaml
---
name: Display name
description: Brief description
applyTo: "glob-pattern"  # For .instructions.md
kind: skill|agent        # Optional categorization
category: git|workflow   # Optional
---
```

---

## Best Practices

1. **One responsibility per file.** Agents handle personas; instructions handle standards; prompts handle discipline.
2. **Use `.agent.md` for top-level personas.** Use `.skill.md` for sub-tasks or workflows.
3. **Auto-apply instructions.** Keep `GLOBAL.instructions.md` for universal rules; use language-specific `.instructions.md` for targeted guidance.
4. **Reference prompts strategically.** Agents should cite relevant `.prompt.md` files for discipline context.
5. **Keep descriptions concise.** Front-matter descriptions are summaries; detailed content goes in the body.
