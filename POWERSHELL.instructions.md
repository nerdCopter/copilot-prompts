---
applyTo: "**/*.{ps1,psm1}"
---

# PowerShell & Microsoft Standards

## 1. Tool Calling Logic (MCP & Validation)
- **Bootstrap Requirement:** If `validate-ps1.ps1` (Windows) or `validate-ps1.sh` (Linux) is missing from the workspace root, IMMEDIATELY notify the user and offer to "Initialize project validation scripts" based on the logic in Section 4.
- **Documentation:** For ALL Microsoft/Windows/PowerShell queries, ALWAYS use `microsoft_docs_search` (MCP server) first.
- **Search Focus:** Prioritize Windows Server 2025/2022. NEVER provide info for Windows 2008 or older.
- **Validation:** After every edit, run the validator in `@terminal`:
  - **Windows:** `./validate-ps1.ps1 <file>`
  - **Linux/Workstation:** `./validate-ps1.sh <file>`

## 2. Coding Rules & Compatibility
- **Version:** Ensure strict compatibility with **PowerShell 5.1**. Avoid PS 7+ exclusive syntax unless requested.
- **Output:** NEVER use `Write-Host`. Use `Write-Output` for data; `Write-Warning/Error/Verbose` for status.
- **Comparisons:** Always place `$null` on the left (e.g., `$null -eq $var`).
- **Interpolation:** Use `${var}:` if followed by a colon or period to avoid drive-reference errors.
- **Safety:** Use `return` instead of `exit`. Avoid `try/catch` if `$ErrorActionPreference = 'Stop'` suffices.

## 3. Microsoft-Specific Standards
- **APIs:** Prioritize **Microsoft Graph SDK** over legacy modules (AzureAD/MSOnline).
- **Encoding:** ASCII only. NO emojis. Use text tags: [OK], [WARN], [ERROR], [PASS], [FAIL].
- **Interactivity:** Use `(Y/N)` prompts with explicit defaults, e.g., `Proceed? (Y/N) [N]`.

## 4. Tool Reconstruction (Blueprint)
If triggered or missing, recreate the tools exactly as follows:
- **validate-ps1.ps1:** PowerShell script that uses `[PSParser]::Tokenize()` for syntax and `Invoke-ScriptAnalyzer` (excluding `PSAvoidUsingWriteHost`). Include logic to help the user install the `PSScriptAnalyzer` module if it is missing.
- **validate-ps1.sh:** A Bash wrapper for Linux that creates a temporary PS1 file, executes the validation logic via `pwsh`, and returns the result.