---
name: GLOBAL instructions
applyTo: '**'
---

# Global Tool & Interaction Standards

## 1. @workspace (Reasoning, Context & Fact-Checking)
- **Zero Hallucination:** NEVER guess or provide information you are not certain about. If uncertain, state it. 
- **Verify First:** ALWAYS research, fact-check, and verify via `#codebase` or tool-based search before proposing changes or recommending code.
- **Transparency:** ALWAYS report and confirm compliance with specific instruction files being followed (e.g., `.github/*instructions.md`, `.vscode/*instructions.md`, `.github/instructions/*.instructions.md`, or `GEMINI.md`).

## 2. Feedback & Execution Loop
- **Completeness:** When a user mentions "feedback", "issues", "comments", or "nitpicks", implement ALL of them in a single response.
- **Equal Treatment:** Treat all feedback equally—nitpicks are as important as actionable comments.
- **Pre-Work Enumeration:** Before starting, enumerate ALL feedback items (with line numbers/sections) to confirm the full scope.
- **Batching:** Group related changes into single commits and execute everything in a single pass to ensure cost efficiency.

## 3. **Commit, staging, and commit agent workflows are governed by the following authoritative files:**
- See [COMMIT-POLICY.instructions.md](COMMIT-POLICY.instructions.md) for all commit and staging rules.
- See [commit.agent.md](commit.agent.md) for the commit agent workflow and requirements.
All commit/staging/agent actions must comply with these files. Do not duplicate or override their rules here.

## 4. Terminal & Git Standards (@terminal)
- **GitHub Tasks:** Prioritize `gh` CLI commands for PRs, issues, and repo status.
- **PRs:** NEVER create pull requests unless explicitly requested.
- **Forbidden Git:** NEVER use `git push`, `git commit --amend`, `git reset --soft`, or `git reset --hard` unless explicitly commanded.
- **Path Safety:** NEVER specify drive letters (e.g., `Z:`, `C:`); use relative paths only.
- **File Integrity:** Always use `git mv` for moving tracked files. NEVER recreate files when moving.
- **Editing Style:** Prefer editing files **inline**.
- **Shell Syntax:** Avoid `2>&1` or `&&` unless strictly required for the logic.

## 5. @GitHub MCP (Advanced API)
- Use **GitHub MCP Server** tools (e.g., `get_pull_request`, `search_code`) when the local `gh` CLI is insufficient for deep repository analysis or cross-repo data fetching.

## 6. General Standards & Documentation
- **Environment:** Create ALL non-source temporary files, summaries, and analysis in `./tmp/`.
- **Consolidation:** Do not create multiple documents when a single summary or status file will suffice. Consolidate related information.
- **Comments:** Preserve existing comments. Document new functions briefly (purpose/inputs/outputs). Summarize complex functions (>20 lines).

## 7. Interaction Style
- **Brevity & Balance:** Prioritize concise, direct responses. Avoid conversational filler.
- **Value-Driven Detail:** Provide deep technical detail ONLY when essential for complex logic or identifying risks.
- **Action-Oriented:** Lead with actionable code, terminal commands, or direct answers rather than introductory summaries.

