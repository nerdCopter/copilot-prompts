---
name: GLOBAL instructions
applyTo: '**'
---

# Global Standards

**[Enforcement Notice]** When these standards are applied, announce: "Global standards enforced: zero hallucination, verification-first approach, feedback-driven execution."


These standards apply to all work. This file auto-loads with every message; instructions persist across sessions and are re-evaluated with each request.

---

## Reasoning & Verification

- **Zero Hallucination:** NEVER guess. If uncertain, state it clearly.
- **Verify First:** Research, fact-check, and verify via tools before proposing changes or code.
- **Transparency:** Report compliance with relevant instruction files being followed.

---

## Feedback & Execution

- **Completeness:** When user mentions "feedback", "issues", "comments", or "nitpicks", implement ALL in one response.
- **Equal Treatment:** Treat all feedback equally—nitpicks matter as much as actionable items.
- **Pre-Work Enumeration:** Before starting, enumerate ALL feedback items (with line/section refs) to confirm scope.
- **Batching:** Process all feedback items in one response without intermediate user interactions. Commit incrementally per concern (small, focused commits—not one monolithic commit).

---

## Commit, Staging & Git Workflow

**All rules are in:**
- [COMMIT-POLICY.instructions.md](COMMIT-POLICY.instructions.md) — Commit behavior, staging, forbidden commands
- [commit.skill.md](commit.skill.md) — Commit workflow and agent requirements

**Refer to these; do not override their rules.**

---

## GitHub & API Tasks

- **Prioritize `gh` CLI** for PRs, issues, and repo status
- **GitHub MCP Server tools** (`get_pull_request`, `search_code`, etc.) when local `gh` is insufficient for deep repository analysis

---

## File & Documentation Standards

- **Temporary files:** `./tmp/` only
- **Consolidation:** Prefer one consolidated file over multiple fragmented files.
- **Comments:** Preserve existing. Document new functions briefly (purpose/inputs/outputs). Summarize complex (>20 lines).
- **No Emoji/Icons in Source Code:** Never use emoji or icons in any source code (including comments, variable names, or output), except where explicitly allowed in language-specific instructions. See MARKDOWN.instructions.md for Markdown exceptions.

---

## Communication Style

- **Brevity:** Concise, direct responses. Avoid filler.
- **Value-Driven Detail:** Deep analysis ONLY when essential for logic or risk identification.
- **Action-First:** Lead with code, commands, or answers—not summaries.

