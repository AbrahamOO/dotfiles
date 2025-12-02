#!/usr/bin/env zsh

# ============================================
# GitHub Repository Security Aliases
# ============================================

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"

# Secure an existing repository
alias secure-repo="$DOTFILES_DIR/secure-repo-setup.sh"

# Create a new secure repository
alias new-secure-repo="$DOTFILES_DIR/create-secure-repo.sh"

# Quick help
alias repo-help='cat << "HELP"
GitHub Repository Security Commands:
=====================================

Create new secure repo:
  new-secure-repo <repo-name> [description]
  Example: new-secure-repo my-project "My awesome project"

Secure existing repo:
  secure-repo [owner/repo]
  Example: secure-repo AbrahamOO/my-project
  (or run from within repo directory)

Features:
  ✓ Branch protection on main
  ✓ Pull request reviews required
  ✓ Admin bypass enabled (you can push directly)
  ✓ Auto-delete branches after merge
  ✓ Force push protection

HELP
'
