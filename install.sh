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

# 1. Project-Local Installations
if [ -d ".claude" ]; then
    install_skill ".claude/skills/generate-book"
fi
# OpenCode natively uses the `skill/` directory at the project root
install_skill "skill/generate-book"

# 2. Global Installations (User-wide)
install_skill "$HOME/.claude/skills/generate-book"
install_skill "$HOME/.config/opencode/skill/generate-book"

# 3. OpenCode and Claude Slash Commands directory
mkdir -p "$HOME/.claude/commands" "$HOME/.config/opencode/commands" ".opencode/commands"
if [ -f "generate-book.md" ]; then
    cp generate-book.md "$HOME/.claude/commands/generate-book.md"
    cp generate-book.md "$HOME/.config/opencode/commands/generate-book.md"
    cp generate-book.md ".opencode/commands/generate-book.md"
else
    curl -sL "$PROMPT_URL" -o "$HOME/.claude/commands/generate-book.md"
    curl -sL "$PROMPT_URL" -o "$HOME/.config/opencode/commands/generate-book.md"
    curl -sL "$PROMPT_URL" -o ".opencode/commands/generate-book.md"
fi

echo ""
echo "========================================="
echo "BookForge is ready!"
echo "Make sure you have Nix installed (https://nixos.org/download)."
echo "Run '/generate-book <topic>' in Claude Code or OpenCode to get started."
echo "Note: OpenCode auto-discovers skills from ~/.config/opencode/skill/ and your local ./skill/ directory."
echo "You may need to restart your terminal or AI agent session to load new skills."
echo "========================================="
