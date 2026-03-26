---
name: YARN Best Practices
applyTo: "**/package.json"
---

# YARN Script Documentation & Discoverability

## Problem
- Project-specific scripts are often undiscoverable 
- `yarn help` shows Yarn CLI help, not project help
- After install, developers don't know what commands are available

## Solution: `commands` Script

Add a `commands` script that lists all available yarn commands.

### 1. Add Script to package.json

```json
"scripts": {
  "commands": "echo '\\nAvailable Commands:\\n\\n  yarn dev       - Description...\\n  yarn build     - Description...\\n'"
}
```

### 2. Direct Users to Run It
Document in README: "Run `yarn commands` to see all available build commands"

**How it works:**
```bash
$ yarn commands

Available Commands:

  yarn dev       - Live dev with webpack + auto-open devtools
  yarn make      - Production binaries (no devtools)
  ...
```

Users run `yarn commands` anytime to see available options. Clean output, no verbose noise.

### 2. Keep Descriptions Concise
Each command: max 1 line, ~60 chars, clear purpose

**Bad:**
```json
"commands": "echo 'yarn start does several things including config and maybe other stuff'"
```

**Good:**
```json
"commands": "echo '  yarn dev  - Live dev server with hot-reload'"
```

### 3. Update README with Quick Start
Add a "Commands" or "Getting Started" section pointing users to `yarn commands`:

```markdown
## Commands

Run `yarn commands` to see all available build commands, or:

- `yarn dev` — Live development mode  
- `yarn make` — Production build
```

## Applied in This Project

From rethink-WM/package.json:
- `yarn commands` — Lists dev, make, make:debug, package, package:debug, test, lint
- README updated with Quick Start directing to `yarn commands`
- Clean output, no postinstall verbosity
