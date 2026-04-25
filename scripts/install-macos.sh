#!/bin/bash
set -e

# Installation script for macOS
# Copies tracked files to ~/Library/Application Support/Code/User/prompts/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="$HOME/Library/Application Support/Code/User/prompts"

echo "This will copy files to: $TARGET_DIR"
echo "WARNING: Existing files with the same name will be overwritten."
echo ""
read -r -p "Continue? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi
echo ""

echo "Installing Copilot customizations to $TARGET_DIR..."

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Find all files except in scripts directory
FILES=$(find "$REPO_ROOT" -type f \
  -not -path "*/scripts/*" \
  -not -path "*/.git/*" \
  -not -path "*/__pycache__/*" \
  | sed "s|^$REPO_ROOT/||")

# Copy all files (except scripts directory)
while IFS= read -r file; do
  # Skip scripts directory and empty lines
  if [[ -z "$file" ]] || [[ "$file" == scripts/* ]]; then
    continue
  fi
  
  SOURCE="$REPO_ROOT/$file"
  DEST="$TARGET_DIR/$file"
  
  # Skip if source and dest are the same (already in target location)
  if [[ "$SOURCE" == "$DEST" ]]; then
    continue
  fi
  
  # Create directory if needed
  mkdir -p "$(dirname "$DEST")"
  
  # Copy file
  cp "$SOURCE" "$DEST"
  echo "✓ $file"
done <<< "$FILES"

echo ""
echo "Installation complete!"
echo "Files installed to: $TARGET_DIR"
