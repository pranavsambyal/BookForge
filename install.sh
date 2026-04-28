#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "   Installing BookForge AI Plugin        "
echo "========================================="

# The URL where the prompt file will be hosted
# The URL where the prompt file will be hosted
PROMPT_URL="https://raw.githubusercontent.com/pranavsambyal/BookForge/main/generate-book.md"

INSTALLED=false

install_skill() {
    local target_dir="$1"
    mkdir -p "$target_dir"
    if [ -f "generate-book.md" ]; then
        echo "Copying local BookForge to $target_dir/SKILL.md..."
        cp generate-book.md "$target_dir/SKILL.md"
    else
        echo "Downloading BookForge to $target_dir/SKILL.md..."
        curl -sL "$PROMPT_URL" -o "$target_dir/SKILL.md"
    fi
    echo "✔ Installed successfully in $target_dir"
    INSTALLED=true
}

# Check if we are inside a directory with .claude or .opencode
if [ -d ".claude" ]; then
    install_skill ".claude/skills/generate-book"
fi

if [ -d ".opencode" ]; then
    install_skill ".opencode/skills/generate-book"
fi

if [ "$INSTALLED" = false ]; then
    echo "Neither .claude nor .opencode directories found in the current directory."
    echo "Creating .claude/skills/generate-book and .opencode/skills/generate-book by default..."
    install_skill ".claude/skills/generate-book"
    install_skill ".opencode/skills/generate-book"
fi

echo ""
echo "========================================="
echo "BookForge is ready!"
echo "Make sure you have Nix installed (https://nixos.org/download)."
echo "Run '/generate-book <topic>' in Claude Code or OpenCode to get started."
echo "========================================="
