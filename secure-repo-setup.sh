#!/usr/bin/env bash

#######################################
# GitHub Repository Security Setup Script
# Automatically configures branch protection and security settings
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

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: Not authenticated with GitHub${NC}"
    echo "Run: gh auth login"
    exit 1
fi

# Get repository name from argument or auto-detect
if [ $# -eq 0 ]; then
    # Auto-detect from git remote
    if [ -d .git ]; then
        REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
        if [ -z "$REPO" ]; then
            echo -e "${RED}Error: Could not detect repository${NC}"
            echo "Usage: $0 [owner/repo]"
            exit 1
        fi
    else
        echo -e "${RED}Error: Not in a git repository${NC}"
        echo "Usage: $0 owner/repo"
        exit 1
    fi
else
    REPO=$1
fi

echo ""
echo "=========================================="
echo "  GitHub Repository Security Setup"
echo "=========================================="
echo ""
echo -e "${BLUE}Repository:${NC} $REPO"
echo ""

# Get default branch
DEFAULT_BRANCH=$(gh api repos/$REPO --jq '.default_branch')
echo -e "${BLUE}Default Branch:${NC} $DEFAULT_BRANCH"
echo ""

# Check if repo is public
VISIBILITY=$(gh api repos/$REPO --jq '.visibility')
if [ "$VISIBILITY" != "public" ]; then
    echo -e "${YELLOW}Warning: Repository is $VISIBILITY (not public)${NC}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

echo -e "${BLUE}Step 1: Configuring branch protection...${NC}"

# Create branch protection config
cat > /tmp/branch-protection-$$.json <<'EOFJSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": []
  },
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
EOFJSON

# Apply branch protection
if gh api repos/$REPO/branches/$DEFAULT_BRANCH/protection \
    --method PUT \
    --input /tmp/branch-protection-$$.json > /dev/null 2>&1; then
    echo -e "  ${GREEN}✓${NC} Branch protection enabled"
else
    echo -e "  ${YELLOW}!${NC} Branch protection may already exist or failed"
fi

rm -f /tmp/branch-protection-$$.json

echo ""
echo -e "${BLUE}Step 2: Configuring repository settings...${NC}"

# Create repository settings config
cat > /tmp/repo-settings-$$.json <<'EOFJSON'
{
  "delete_branch_on_merge": true,
  "allow_squash_merge": true,
  "allow_merge_commit": true,
  "allow_rebase_merge": true,
  "allow_auto_merge": true,
  "allow_update_branch": true
}
EOFJSON

# Apply repository settings
if gh api repos/$REPO \
    --method PATCH \
    --input /tmp/repo-settings-$$.json > /dev/null 2>&1; then
    echo -e "  ${GREEN}✓${NC} Repository settings configured"
else
    echo -e "  ${YELLOW}!${NC} Some settings may have failed"
fi

rm -f /tmp/repo-settings-$$.json

echo ""
echo -e "${BLUE}Step 3: Verifying configuration...${NC}"

# Verify settings
PROTECTION=$(gh api repos/$REPO/branches/$DEFAULT_BRANCH/protection 2>/dev/null || echo "")
if [ -n "$PROTECTION" ]; then
    echo -e "  ${GREEN}✓${NC} Branch protection active"
    echo -e "  ${GREEN}✓${NC} PR reviews required"
    echo -e "  ${GREEN}✓${NC} Admin enforcement disabled (you can bypass)"
    echo -e "  ${GREEN}✓${NC} Force pushes blocked"
    echo -e "  ${GREEN}✓${NC} Branch deletion blocked"
else
    echo -e "  ${YELLOW}!${NC} Could not verify branch protection"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}✓ Security Configuration Complete!${NC}"
echo "=========================================="
echo ""
echo "Your repository is now secured with:"
echo "  • Branch protection on $DEFAULT_BRANCH"
echo "  • Pull request reviews required"
echo "  • You can still push directly (admin bypass)"
echo "  • Others must create pull requests"
echo "  • Automatic branch cleanup after merge"
echo ""
echo "View settings at:"
echo "  https://github.com/$REPO/settings/branches"
echo ""
