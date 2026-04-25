# Claude symlink setup for Windows (PowerShell)
# Creates symlinks in %LOCALAPPDATA%\Claude

param(
    [switch]$Admin
)

# Check if running as admin (required for symlinks)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges to create symbolic links. Re-running with elevation..." -ForegroundColor Yellow
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Admin" -Verb RunAs
    exit
}

$scriptsDir = Split-Path -Parent $PSCommandPath
$promptsDir = Split-Path -Parent $scriptsDir
$claudeDir = Join-Path $env:LOCALAPPDATA "Claude"

# Define symlinks: @{ linkPath = "sourceFile" }
$symlinks = @{
    "CLAUDE.md" = "GLOBAL.instructions.md"
    "commands\implementation.md" = "implementation.agent.md"
    "commands\commit.md" = "commit.skill.md"
    "commands\research.md" = "research.agent.md"
}

if (-not (Test-Path $claudeDir)) {
    Write-Host "Creating Claude config directory: $claudeDir"
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}

if (-not (Test-Path $promptsDir)) {
    Write-Host "Error: $promptsDir does not exist"
    exit 1
}

# Ensure commands directory exists
$commandsDir = Join-Path $claudeDir "commands"
if (-not (Test-Path $commandsDir)) {
    New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
}

foreach ($linkName in $symlinks.Keys) {
    $promptFile = $symlinks[$linkName]
    $linkPath = Join-Path $claudeDir $linkName
    $promptPath = Join-Path $promptsDir $promptFile
    
    if (-not (Test-Path $promptPath)) {
        Write-Host "⚠ Skipping $linkName : $promptPath not found" -ForegroundColor Yellow
        continue
    }
    
    if (Test-Path $linkPath) {
        Remove-Item -Path $linkPath -Force
    }
    
    # Create symbolic link
    New-Item -ItemType SymbolicLink -Path $linkPath -Target $promptPath -Force | Out-Null
    Write-Host "✓ $linkName -> $promptFile" -ForegroundColor Green
}

Write-Host ""
Write-Host "All symlinks created successfully" -ForegroundColor Green
