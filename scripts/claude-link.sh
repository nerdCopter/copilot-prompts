#!/bin/bash
set -e

PROMPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Array of symlinks: (link_path source_file)
declare -a SYMLINKS=(
  "CLAUDE.md:GLOBAL.instructions.md"
  "commands/implementation.md:implementation.agent.md"
  "commands/commit.md:commit.skill.md"
  "commands/research.md:research.agent.md"
)

if [ ! -d "$CLAUDE_DIR" ]; then
  echo "Error: $CLAUDE_DIR does not exist"
  exit 1
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

  if [ -e "$LINK_PATH" ] || [ -L "$LINK_PATH" ]; then
    rm "$LINK_PATH"
  fi

  ln -s "$PROMPT_PATH" "$LINK_PATH"
  echo "✓ $LINK_NAME -> $PROMPT_FILE"
done

echo ""
echo "All symlinks created successfully"
