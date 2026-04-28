#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "   Installing BookForge AI Plugin        "
echo "========================================="

# The URL where the prompt file will be hosted
# The URL where the prompt file will be hosted
PROMPT_URL="https://raw.githubusercontent.com/pranavsambyal/BookForge/main/generate-book.md"

INSTALLED=false

install_prompt() {
    local target_dir="$1"
    mkdir -p "$target_dir"
    echo "Downloading BookForge to $target_dir/generate-book.md..."
    curl -sL "$PROMPT_URL" -o "$target_dir/generate-book.md"
    echo "✔ Installed successfully in $target_dir"
    INSTALLED=true
}

# Check if we are inside a directory with .claude or .opencode
if [ -d ".claude" ]; then
    install_prompt ".claude/commands"
fi

if [ -d ".opencode" ]; then
    install_prompt ".opencode/commands"
fi

if [ "$INSTALLED" = false ]; then
    echo "Neither .claude nor .opencode directories found in the current directory."
    echo "Creating .claude/commands and .opencode/commands by default..."
    install_prompt ".claude/commands"
    install_prompt ".opencode/commands"
fi

echo ""
echo "========================================="
echo "BookForge is ready!"
echo "Make sure you have Nix installed (https://nixos.org/download)."
echo "Run '/generate-book <topic>' in Claude Code or OpenCode to get started."
echo "========================================="
