---
name: GLOBAL instructions
applyTo: '**'
---

# Global Standards

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
- **Batching:** Group related changes into single commits; execute everything at once for cost efficiency.

---

## Commit, Staging & Git Workflow

**All rules are in:**
- [COMMIT-POLICY.instructions.md](COMMIT-POLICY.instructions.md) — Commit behavior, staging, forbidden commands
- [commit.agent.md](commit.agent.md) — Commit workflow and agent requirements

**Refer to these; do not override their rules.**

---

## GitHub & API Tasks

- **Prioritize `gh` CLI** for PRs, issues, and repo status
- **GitHub MCP Server tools** (`get_pull_request`, `search_code`, etc.) when local `gh` is insufficient for deep repository analysis

---

## File & Documentation Standards

- **Temporary files:** `./tmp/` only
- **Consolidation:** Single document > multiple redundant files
- **Comments:** Preserve existing. Document new functions briefly (purpose/inputs/outputs). Summarize complex (>20 lines).

---

## Communication Style

- **Brevity:** Concise, direct responses. Avoid filler.
- **Value-Driven Detail:** Deep analysis ONLY when essential for logic or risk identification.
- **Action-First:** Lead with code, commands, or answers—not summaries.

