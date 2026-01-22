---
applyTo: '**'
---

# Global Tool & Interaction Standards

BEFORE ANYTHING ELSE: If, and only if, a `./beads` folder exists, then run `bd onboard` and follow the instructions.

## 1. @workspace (Reasoning, Context & Fact-Checking)
- **Zero Hallucination:** NEVER guess or provide information you are not certain about. If uncertain, state it. 
- **Verify First:** ALWAYS research, fact-check, and verify via `#codebase` or tool-based search before proposing changes or recommending code.
- **Transparency:** ALWAYS report and confirm compliance with specific instruction files being followed (e.g., `.github/*instructions.md`, `.vscode/*instructions.md`, `.github/instructions/*.instructions.md`, or `GEMINI.md`).

## 2. Feedback & Execution Loop
- **Completeness:** When a user mentions "feedback", "issues", "comments", or "nitpicks", implement ALL of them in a single response.
- **Equal Treatment:** Treat all feedback equally—nitpicks are as important as actionable comments.
- **Pre-Work Enumeration:** Before starting, enumerate ALL feedback items (with line numbers/sections) to confirm the full scope.
- **Batching:** Group related changes into single commits and execute everything in a single pass to ensure cost efficiency.

## 3. @terminal (Git, File Ops & GitHub CLI)
- **GitHub Tasks:** Prioritize `gh` CLI commands for PRs, issues, and repo status.
- **Forbidden Git:** NEVER use `git add .`, `git add -A`, `git push`, `git commit --amend`, `git reset --soft`, or `git reset --hard` unless explicitly commanded.
- **Staging Files:** Prefer `git add -u` or `git add <files>`. Only stage when commanded.
- **Path Safety:** NEVER specify drive letters (e.g., `Z:`, `C:`); use relative paths only.
- **File Integrity:** Always use `git mv` for moving tracked files. NEVER recreate files when moving.
- **Editing Style:** Edit files **inline**; NEVER use `cat` or redirection for modification or appending.
- **Shell Syntax:** Avoid `2>&1` or `&&` unless strictly required for the logic.
- **PRs:** NEVER create pull requests unless explicitly requested.

### Commit Standard (Required)
- **Workflow:** Analyze `git diff --cached` or `git diff HEAD` before generating messages.
- **Command:** `git commit -m "<type>: <subject>" -m "<description>"`
- **Constraints:** Subject-case, ~50 chars max, clear/actionable. Description on a separate line with context/reasoning.
- **Allowed Types:** `feat`, `fix`, `docs`, `refactor`, `style`, `perf`, `test`, `chore`, `build`, `ci`.

## 4. @GitHub MCP (Advanced API)
- Use **GitHub MCP Server** tools (e.g., `get_pull_request`, `search_code`) when the local `gh` CLI is insufficient for deep repository analysis or cross-repo data fetching.

## 5. General Standards & Documentation
- **Environment:** Create ALL non-source temporary files, summaries, and analysis in `./tmp/`.
- **Consolidation:** Do not create multiple documents when a single summary or status file will suffice. Consolidate related information.
- **Comments:** Preserve existing comments. Document new functions briefly (purpose/inputs/outputs). Summarize complex functions (>20 lines).

## 6. Numbering Convention (Documentation & GitHub References)
- **GitHub Issues Only:** Use `#XXXX` format EXCLUSIVELY for GitHub issue tracker references.
- **Local Documentation:** For local lists, documentation, problems, or comments, use `No. 1`, `Number 1`, `Issue A`, or `Item # 1` (with spacing).
- **Consistency:** Apply uniformly across documentation, commit messages, and code comments to avoid confusion with tracker references.

## 7. Interaction Style
- **Brevity & Balance:** Prioritize concise, direct responses. Avoid conversational filler.
- **Value-Driven Detail:** Provide deep technical detail ONLY when essential for complex logic or identifying risks.
- **Action-Oriented:** Lead with actionable code, terminal commands, or direct answers rather than introductory summaries.
