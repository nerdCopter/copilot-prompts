---
name: POWERSHELL scripts
applyTo: "**/*.ps1,**/*.psm1,**/*.psd1"
---

# PowerShell Project Guidelines

# CmdletBinding and Parameter Block Structure

**Correct pattern:**
```powershell
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$RequiredParam,
    
    [Parameter(Mandatory=$false)]
    [string]$OptionalParam
)
```

**NEVER nest parameters inside CmdletBinding() closing:**
```powershell
# WRONG - causes "Missing closing parenthesis" parse errors
[CmdletBinding(
    [Parameter(Mandatory=$false)]
    [string]$ClusterName = ""
)]
param([Parameter(Mandatory=$true)][string]$VMName)
```

**Why:** `[CmdletBinding()]` is a script-level attribute (usually empty). Parameter definitions belong in a **separate `param()` block** that comes after.

# Interactive Prompts (Y/N Best Practice)
- For any interactive confirmation, use a (Y/N) prompt with a default value that matches the safest or most common action for the function.
- Accept Y, y, Yes, yes, or Enter (defaults to the specified default).
- Example:
      ```powershell
      $confirm = Read-Host "Proceed with destructive operation? (Y/N) [N]"
      if (-not $confirm -or $confirm.Trim() -eq "") {
          # Set Default
          $confirm = "N"
      }
      $confirm = $confirm.Trim().ToLower()
      if ($confirm -in @("y", "yes")) {
          # Proceed with operation
      } else {
          Write-Host "Operation cancelled."
          return
      }
      ```
- Always document the default action in the prompt string.

- **NEVER** use emojis, icons, or non-ASCII characters (✓✗⚠❌✅) in code, comments, or output. Use text alternatives like [OK], [ERROR], [WARN], [PASS], [FAIL] instead.
- **NEVER** use `exit` commands in scripts (causes issues when copy/pasting code). Use `return` instead.
- Avoid try/catch/finally blocks unless absolutely required. Prefer simple error handling with `$?`, `if/else`, or `$ErrorActionPreference`.
- Do not use the `-Force` parameter in commands where it is not required. If the use of `-Force` is questionable, make it an optional parameter with a clear prompt or warning.
- Use descriptive variable names and `Verb-Noun` convention for functions.
- Indent with 4 spaces, no tabs.
- Favor outputting objects rather than formatted text, unless explicitly needed.
- Ensure compatibility with PowerShell 5.1 and 7+.

# Variable Interpolation in Strings

When interpolating variables inside double-quoted strings, always use `${var}` if the variable is immediately followed by a colon, period, or other character that could be misinterpreted by PowerShell (e.g., `${i}:` instead of `$i:`). This avoids parser errors and ensures correct output.

**Example:**
```powershell
Write-Host "Index: ${i}: Value is $value"
```

This is required because `$i:` is interpreted as a drive reference, not a variable, and will cause a parse error.



## PowerShell Syntax and Analyzer Validation

All scripts must pass **both**:
- Basic syntax validation (using `[System.Management.Automation.PSParser]::Tokenize()`)
- PSScriptAnalyzer validation (all rules except PSAvoidUsingWriteHost)

### Validation Workflow: Windows and Linux

- **On Windows:** Use `validate-ps1.ps1` (PowerShell script)
- **On Linux:** Use `validate-ps1.sh` (Bash wrapper for PowerShell Core)

#### Windows: validate-ps1.ps1
Run from PowerShell:
```powershell
./validate-ps1.ps1 <script.ps1>
```

#### Linux: validate-ps1.sh
Run from Bash:
```bash
./validate-ps1.sh <script.ps1>
```

Both scripts perform:
- Syntax validation with `[System.Management.Automation.PSParser]::Tokenize()`
- PSScriptAnalyzer validation (excluding PSAvoidUsingWriteHost)

If not present, create the validation script for your OS as described below.

##### validate-ps1.ps1 (Windows)
```powershell
param($ScriptPath)
try {
    $content = Get-Content $ScriptPath -Raw -ErrorAction Stop
    $null = [System.Management.Automation.PSParser]::Tokenize($content, [ref]$null)
    Write-Host "[PASS] $ScriptPath : BASIC SYNTAX VALID" -ForegroundColor Green
    if (Get-Module -ListAvailable -Name PSScriptAnalyzer) {
        Write-Host "Running PSScriptAnalyzer..." -ForegroundColor Cyan
        $analyzerResults = Invoke-ScriptAnalyzer -Path $ScriptPath -Severity Error,Warning -ExcludeRule PSAvoidUsingWriteHost
        if ($analyzerResults) {
            Write-Host "[WARN] $ScriptPath : PSSCRIPTANALYZER ISSUES" -ForegroundColor Yellow
            $analyzerResults | ForEach-Object {
                Write-Host "  Line $($_.Line): $($_.RuleName) - $($_.Message)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "[PASS] $ScriptPath : PSSCRIPTANALYZER CLEAN" -ForegroundColor Green
        }
    } else {
        Write-Host "[INFO] PSScriptAnalyzer not installed. Install with: Install-Module PSScriptAnalyzer" -ForegroundColor Gray
    }
}
catch {
    Write-Host "[FAIL] $ScriptPath : ERROR - $($_.Exception.Message)" -ForegroundColor Red
    return
}
```

##### validate-ps1.sh (Linux)
```bash
#!/bin/bash
# Usage: ./validate-ps1.sh <script.ps1>
SCRIPT="$1"
if [ -z "$SCRIPT" ]; then
    echo "Usage: $0 <script.ps1>"
    exit 1
fi
TEMP_PS1=$(mktemp /tmp/validate-XXXXXX.ps1)
cat > "$TEMP_PS1" << 'EOF'
param($ScriptPath)
try {
    $content = Get-Content $ScriptPath -Raw -ErrorAction Stop
    $null = [System.Management.Automation.PSParser]::Tokenize($content, [ref]$null)
    Write-Host "[PASS] $ScriptPath : BASIC SYNTAX VALID" -ForegroundColor Green
    if (Get-Module -ListAvailable -Name PSScriptAnalyzer) {
        Write-Host "Running PSScriptAnalyzer..." -ForegroundColor Cyan
        $analyzerResults = Invoke-ScriptAnalyzer -Path $ScriptPath -Severity Error,Warning -ExcludeRule PSAvoidUsingWriteHost
        if ($analyzerResults) {
            Write-Host "[WARN] $ScriptPath : PSSCRIPTANALYZER ISSUES" -ForegroundColor Yellow
            $analyzerResults | ForEach-Object {
                Write-Host "  Line $($_.Line): $($_.RuleName) - $($_.Message)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "[PASS] $ScriptPath : PSSCRIPTANALYZER CLEAN" -ForegroundColor Green
        }
    } else {
        Write-Host "[INFO] PSScriptAnalyzer not installed. Install with: Install-Module PSScriptAnalyzer" -ForegroundColor Gray
    }
}
catch {
    Write-Host "[FAIL] $ScriptPath : ERROR - $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
EOF
pwsh -NoProfile -File "$TEMP_PS1" "$SCRIPT"
EXIT_CODE=$?
rm "$TEMP_PS1"
exit $EXIT_CODE
```

### Validation Method Details
- **Tools:** `[System.Management.Automation.PSParser]::Tokenize()` and `Invoke-ScriptAnalyzer`
- **Platform:** Windows (PowerShell 5.1/7+) or Linux (PowerShell Core)
- **Scope:** Syntax and analyzer validation (not runtime testing)
- **Compatibility:** Works with PowerShell 5.1+ scripts
- **Purpose:** Ensures scripts are syntactically and stylistically correct before deployment

### PSScriptAnalyzer Rules Compliance

All scripts must comply with PSScriptAnalyzer rules. Key rules to follow:

- **PSAvoidUsingWriteHost**: Avoid `Write-Host` for non-interactive output. Use `Write-Output`, `Write-Error`, `Write-Warning`, `Write-Verbose`, or `Write-Information` instead.
- **PSPossibleIncorrectComparisonWithNull**: Always place `$null` on the left side of equality comparisons to avoid potential issues. Use `$null -eq $variable` or `$null -ne $variable` instead of `$variable -eq $null`.

Example:
```powershell
# Correct
if ($null -ne $myVariable) { ... }

# Incorrect (will trigger warning)
if ($myVariable -ne $null) { ... }
```

Make it executable: `chmod +x validate-ps1.sh`

### Usage

#### Single Script Validation
```bash
./validate-ps1.sh <script.ps1>
```

#### Multiple Scripts Validation
```bash
find . -name "*.ps1" -type f | while read script; do ./validate-ps1.sh "$script"; done
```

### Validation Method Details
- **Tools:** `[System.Management.Automation.PSParser]::Tokenize()` and `Invoke-ScriptAnalyzer`
- **Platform:** Linux workstation with PowerShell Core
- **Scope:** Syntax and analyzer validation (not runtime testing)
- **Compatibility:** Works with PowerShell 5.1+ scripts
- **Purpose:** Ensures scripts are syntactically and stylistically correct before deployment

### Microsoft Documentation

- You have access to MCP tools called `microsoft_docs_search` and `microsoft_docs_fetch`. Use them to retrieve up-to-date documentation based on user queries relating to Microsoft technologies.
