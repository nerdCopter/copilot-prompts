#!/bin/bash
set -e

# Claude symlink setup for macOS
# Creates symlinks in ~/Library/Application Support/Claude

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/Library/Application Support/Claude"

# Array of symlinks: (link_path source_file)
declare -a SYMLINKS=(
  "AGENTS.md:GLOBAL.instructions.md"
  "commands/implementation.md:implementation.agent.md"
  "commands/commit.md:commit.skill.md"
  "commands/research.md:research.agent.md"
)

if [ ! -d "$CLAUDE_DIR" ]; then
  echo "Creating Claude config directory: $CLAUDE_DIR"
  mkdir -p "$CLAUDE_DIR"
fi

if [ ! -d "$PROMPTS_DIR" ]; then
  echo "Error: $PROMPTS_DIR does not exist"
  exit 1
fi

# Ensure commands directory exists
mkdir -p "$CLAUDE_DIR/commands"

for entry in "${SYMLINKS[@]}"; do
  LINK_NAME="${entry%:*}"
  PROMPT_FILE="${entry#*:}"

  LINK_PATH="$CLAUDE_DIR/$LINK_NAME"
  PROMPT_PATH="$PROMPTS_DIR/$PROMPT_FILE"

  if [ ! -f "$PROMPT_PATH" ]; then
    echo "⚠ Skipping $LINK_NAME: $PROMPT_PATH not found"
    continue
  fi

  if [ -L "$LINK_PATH" ]; then
    rm "$LINK_PATH"
  elif [ -e "$LINK_PATH" ]; then
    echo "⚠ Skipping $LINK_NAME: $LINK_PATH exists and is not a symlink (refusing to overwrite a real file)"
    continue
  fi

  ln -s "$PROMPT_PATH" "$LINK_PATH"
  echo "✓ $LINK_NAME -> $PROMPT_FILE"
done

echo ""
echo "All symlinks created successfully"
echo "Note: AGENTS.md links to the generic GLOBAL.instructions.md and won't overwrite an existing CLAUDE.md. Rename or copy it to CLAUDE.md yourself if you want to adopt it, or reference it directly from your CLAUDE.md instead."
