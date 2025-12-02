# Dotfiles - GitHub Repository Security Automation

Automated security configuration for GitHub repositories. Never manually configure branch protection again!

## 🚀 Quick Start

### Installation on New Computers

Since this is a **private repository**, use manual installation:

```bash
# Clone the repository
git clone git@github.com:AbrahamOO/dotfiles.git ~/dotfiles

# Run the installer
cd ~/dotfiles
./install.sh

# Authenticate with GitHub
gh auth login
```

### Installation on Current Computer

Already installed at `~/dotfiles`. To activate:

```bash
source ~/.zshrc
```

## 📋 What's Included

### Scripts

- **`secure-repo-setup.sh`** - Apply security settings to existing repositories
- **`create-secure-repo.sh`** - Create new repositories with security pre-configured
- **`install.sh`** - Installation script for new machines

### Configuration

- **`aliases.zsh`** - Shell aliases for convenience
- **`.github-repo-defaults.yml`** - Default settings template

## 🔒 Security Features

All repositories configured with this tool get:

- ✅ Branch protection on main/master
- ✅ Pull request reviews required (1 approval)
- ✅ Admin bypass enabled (you can push directly)
- ✅ Contributors must create pull requests
- ✅ Force push protection
- ✅ Branch deletion protection
- ✅ Conversation resolution required
- ✅ Auto-delete branches after merge
- ✅ Multiple merge strategies allowed

## 💻 Usage

### Create a New Secure Repository

```bash
new-secure-repo my-project "My awesome project"
```

This will:
1. Create the GitHub repository (public)
2. Clone it locally
3. Add README and .gitignore
4. Make initial commit and push
5. Apply branch protection rules
6. Configure security settings

### Secure an Existing Repository

```bash
# From within the repository
cd my-repo
secure-repo

# Or specify the repository
secure-repo AbrahamOO/my-existing-repo
```

### Get Help

```bash
repo-help
```

## 🔐 Security & Privacy

### Repository Privacy

This dotfiles repository is **PRIVATE** because:
- Contains your personal automation preferences
- Only you need access to it
- Still contains NO credentials or secrets

### What's Safe

✅ All scripts contain **NO credentials**
✅ No API tokens, passwords, or secrets
✅ Only automation logic
✅ Authentication handled by GitHub CLI

### How Authentication Works

- GitHub CLI (`gh`) handles authentication separately
- Credentials stored encrypted by your system keychain
- Scripts use the authenticated session
- You must run `gh auth login` once per computer

### What's Never Included

- ❌ GitHub tokens or credentials
- ❌ SSH keys
- ❌ Environment variables with secrets
- ❌ Personal API keys
- ❌ Passwords

## 📦 Requirements

- **GitHub CLI** - Install with `brew install gh` (macOS) or [follow instructions](https://cli.github.com/)
- **Git** - Usually pre-installed
- **Bash/Zsh** - Standard on macOS/Linux
- **SSH access** to GitHub (for cloning private repo)

## 🎯 Who This Is For

### Repository Owner (You)
- ✓ Push directly to main (no PR needed)
- ✓ Fast development workflow
- ✓ Protected against accidental force pushes

### Contributors
- ✗ Cannot push to main directly
- ✓ Must create pull requests
- ✓ Need approval to merge

## 🛠️ Customization

Edit the scripts to change default behaviors:

```bash
# Edit security settings
nano ~/dotfiles/secure-repo-setup.sh

# Edit repository creation
nano ~/dotfiles/create-secure-repo.sh

# View default settings
cat ~/dotfiles/.github-repo-defaults.yml
```

## 🔄 Updating Across All Computers

```bash
cd ~/dotfiles
git pull origin main
source ~/.zshrc  # or your shell config
```

## 📚 Examples

### Example 1: New Project

```bash
$ new-secure-repo my-api "REST API with security best practices"
# Creates repo, clones, initializes, applies security
$ cd my-api
$ # ... make changes ...
$ git push  # Works! You're the owner
```

### Example 2: Secure Existing Repo

```bash
$ cd ~/projects/old-repo
$ secure-repo
# Applies branch protection and security settings
```

### Example 3: New Computer Setup

```bash
# On new computer
$ git clone git@github.com:AbrahamOO/dotfiles.git ~/dotfiles
$ cd ~/dotfiles && ./install.sh
$ gh auth login
$ source ~/.zshrc
$ new-secure-repo another-project "Testing on new computer"
```

## 🐛 Troubleshooting

### Aliases not working?

```bash
source ~/.zshrc  # or ~/.bashrc
```

### Authentication error?

```bash
gh auth login
```

### Permission denied?

```bash
chmod +x ~/dotfiles/*.sh
```

### Branch protection fails?

- Ensure repository exists
- Verify you have admin access
- Check that branch exists (make initial commit first)

### Can't clone dotfiles on new computer?

Make sure you have SSH access configured:
```bash
# Generate SSH key if needed
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to GitHub
cat ~/.ssh/id_ed25519.pub
# Copy and add at: https://github.com/settings/keys
```

## 📖 Documentation

- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Branch Protection API](https://docs.github.com/en/rest/branches/branch-protection)

## 📄 License

MIT License - Personal use

---

**Made with ❤️ for secure, automated repository management**
