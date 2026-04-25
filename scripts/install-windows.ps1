# Installation script for Windows (PowerShell)
# Copies tracked files to $env:APPDATA\Code\User\prompts\

param(
    [switch]$Admin
)

# Check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges to create the directory. Re-running with elevation..." -ForegroundColor Yellow
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Admin" -Verb RunAs
    exit
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$targetDir = Join-Path $env:APPDATA "Code\User\prompts"

Write-Host "Installing Copilot customizations to $targetDir..." -ForegroundColor Green

# Create target directory if it doesn't exist
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# Get all files except in scripts, .git, and __pycache__
$trackedFiles = @(Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | 
    Where-Object { $_.FullName -notmatch "\\scripts\\" -and $_.FullName -notmatch "\.git\\" -and $_.FullName -notmatch "__pycache__" } |
    ForEach-Object { $_.FullName.Substring($repoRoot.Length + 1) })

foreach ($file in $trackedFiles) {
    # Skip scripts directory and empty lines
    if ([string]::IsNullOrWhiteSpace($file) -or $file -like "scripts\*") {
        continue
    }
    
    $source = Join-Path $repoRoot $file
    $dest = Join-Path $targetDir $file
    
    # Skip if source and dest are the same (already in target location)
    if ($source -eq $dest) {
        continue
    }
    
    # Create subdirectory if needed
    $destDir = Split-Path -Parent $dest
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    # Copy file
    Copy-Item -Path $source -Destination $dest -Force
    Write-Host "✓ $file"
}

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Files installed to: $targetDir"
