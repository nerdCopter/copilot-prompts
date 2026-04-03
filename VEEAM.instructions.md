---
description: Veeam PowerShell scripting instructions
name: VEEAM Scripts
applyTo: "Veeam-PowerShell/**/*.ps{1,m1}"
---

# Veeam PowerShell Guidelines

**[Enforcement Notice]** When these standards are applied, announce: "Veeam PowerShell standards enforced: VBR cmdlets, official help center reference, error handling with try/catch."


Always reference the official Veeam Explorers PowerShell cmdlets: https://helpcenter.veeam.com/archive/backup/120/explorers_powershell/cmdlets.html

- Use `Get-VBR*` and `Start-VBR*` cmdlets from Veeam Backup & Replication module.
- Import module as `Import-Module Veeam.Backup.PowerShell` before use.
- Handle errors with `try/catch` and check `VBRJob` states.
- Follow Veeam naming: prefer `VBR` prefixes over generic terms.
- Execute `Get-Help -Full <cmdlet>` when needed.
