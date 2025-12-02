#!/usr/bin/env bash

#######################################
# Create a New GitHub Repository with Security Setup
# Combines repo creation + automatic security configuration
#######################################

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed${NC}"
    echo "Install with: brew install gh"
    exit 1
fi

# Get repository name
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Repository name required${NC}"
    echo "Usage: $0 <repo-name> [description]"
    exit 1
fi

REPO_NAME=$1
DESCRIPTION=${2:-"A secure, production-ready repository"}

echo ""
echo "=========================================="
echo "  Create Secure GitHub Repository"
echo "=========================================="
echo ""
echo -e "${BLUE}Repository:${NC} $REPO_NAME"
echo -e "${BLUE}Description:${NC} $DESCRIPTION"
echo -e "${BLUE}Visibility:${NC} Public"
echo ""

read -p "Create this repository? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
fi

echo ""
echo -e "${BLUE}Step 1: Creating GitHub repository...${NC}"

# Create repository
if gh repo create "$REPO_NAME" \
    --public \
    --description "$DESCRIPTION" \
    --clone; then
    echo -e "  ${GREEN}✓${NC} Repository created and cloned"
else
    echo -e "  ${RED}✗${NC} Failed to create repository"
    exit 1
fi

cd "$REPO_NAME"

echo ""
echo -e "${BLUE}Step 2: Initializing repository structure...${NC}"

# Create README
cat > README.md <<EOFREADME
# $REPO_NAME

$DESCRIPTION

## Getting Started

[Add your getting started instructions here]

## Prerequisites

[List prerequisites here]

## Installation

\`\`\`bash
# Add installation commands
\`\`\`

## Usage

\`\`\`bash
# Add usage examples
\`\`\`

## Contributing

Pull requests are welcome. For major changes, please open an issue first.

## License

[Add license information]
EOFREADME

# Create .gitignore
cat > .gitignore <<'EOFGITIGNORE'
# OS
.DS_Store
*~
*.swp
*.swo

# IDEs
.vscode/
.idea/
*.code-workspace

# Environment
.env
.env.local
.env.*.local

# Dependencies
node_modules/
vendor/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
.venv/

# Build outputs
dist/
build/
*.egg-info/

# Logs
*.log
logs/

# Testing
.pytest_cache/
.coverage
htmlcov/

# Temporary files
*.tmp
*.bak
EOFGITIGNORE

echo -e "  ${GREEN}✓${NC} README.md created"
echo -e "  ${GREEN}✓${NC} .gitignore created"

echo ""
echo -e "${BLUE}Step 3: Making initial commit...${NC}"

git add .
git commit -m "Initial commit: Repository setup

Created with automated secure repository setup script.
Includes README and comprehensive .gitignore."

git push -u origin main

echo -e "  ${GREEN}✓${NC} Initial commit pushed"

echo ""
echo -e "${BLUE}Step 4: Applying security configuration...${NC}"

# Wait a moment for GitHub to process
sleep 2

# Get current username
CURRENT_USER=$(gh api user -q .login)
REPO_FULL="$CURRENT_USER/$REPO_NAME"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Apply security settings
"$SCRIPT_DIR/secure-repo-setup.sh" "$REPO_FULL"

echo ""
echo "=========================================="
echo -e "${GREEN}✓ Repository Ready!${NC}"
echo "=========================================="
echo ""
echo "Repository URL:"
echo "  https://github.com/$REPO_FULL"
echo ""
echo "Local path:"
echo "  $(pwd)"
echo ""
echo "Next steps:"
echo "  1. cd $REPO_NAME"
echo "  2. Start developing!"
echo "  3. git add . && git commit -m 'Your changes'"
echo "  4. git push"
echo ""
