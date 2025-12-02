#!/usr/bin/env bash

#######################################
# Dotfiles Installation Script
# Installs GitHub repository security automation
#######################################

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "=========================================="
echo "  Dotfiles Installation"
echo "=========================================="
echo ""

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Installing from:${NC} $DOTFILES_DIR"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}GitHub CLI (gh) is not installed${NC}"
    echo "Installing GitHub CLI..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install gh
        else
            echo -e "${RED}Error: Homebrew not found. Please install it first.${NC}"
            echo "Visit: https://brew.sh"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Please install GitHub CLI manually:"
        echo "Visit: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
        exit 1
    else
        echo -e "${RED}Unsupported operating system${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✓${NC} GitHub CLI installed"

# Make scripts executable
chmod +x "$DOTFILES_DIR/secure-repo-setup.sh"
chmod +x "$DOTFILES_DIR/create-secure-repo.sh"
echo -e "${GREEN}✓${NC} Scripts made executable"

# Determine shell config file
if [ -n "${ZSH_VERSION:-}" ] || [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
else
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo -e "${BLUE}Shell config:${NC} $SHELL_CONFIG"

# Check if already sourced
if grep -q "dotfiles/aliases.zsh" "$SHELL_CONFIG" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Aliases already configured"
else
    echo "" >> "$SHELL_CONFIG"
    echo "# GitHub Repository Security Automation" >> "$SHELL_CONFIG"
    echo "[ -f \"$DOTFILES_DIR/aliases.zsh\" ] && source \"$DOTFILES_DIR/aliases.zsh\"" >> "$SHELL_CONFIG"
    echo -e "${GREEN}✓${NC} Aliases added to $SHELL_CONFIG"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}✓ Installation Complete!${NC}"
echo "=========================================="
echo ""
echo "To activate the commands:"
echo "  source $SHELL_CONFIG"
echo ""
echo "Or open a new terminal window."
echo ""
echo "Available commands:"
echo "  new-secure-repo <name> [desc]  - Create new secure repository"
echo "  secure-repo [owner/repo]       - Secure existing repository"
echo "  repo-help                      - Display help"
echo ""
echo "Next steps:"
echo "  1. Authenticate with GitHub: gh auth login"
echo "  2. Test the setup: new-secure-repo test-repo 'Test repository'"
echo ""
