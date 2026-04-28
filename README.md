# BookForge

An AI-powered slash command plugin for Claude Code and OpenCode that generates professional, beautifully formatted PDF books on any topic using Nix, Pandoc, and XeLaTeX.

## Features

- **Automated Research**: Gathers sources and builds an Obsidian-style markdown knowledge graph.
- **Interactive Pipeline**: Explicit stops to review the outline and the final draft before compilation.
- **Robust Typesetting**: Leverages LaTeX (with standard high-quality fonts) and Mermaid diagrams.
- **Zero-Friction Build**: Uses a fully isolated Nix shell environment for reproducibility.

## Installation

Run this one-liner in the root of your project:

```bash
curl -sL https://raw.githubusercontent.com/pranavsambyal/BookForge/main/install.sh | bash
```

## Requirements

- [Nix package manager](https://nixos.org/download) installed on your system.
- Claude Code or OpenCode.

## Usage

Start Claude Code or OpenCode in your project, then simply type:

```
/generate-book "Quantum Computing" --chapters 5 --depth advanced
```

The plugin will walk you through the 5-phase pipeline, pausing for your approval at critical steps before finally compiling your book!
