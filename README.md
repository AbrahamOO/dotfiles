# Dotfiles - GitHub Repository Security Automation

Automated security configuration for GitHub repositories. Never manually configure branch protection again!

## 🚀 Quick Start

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/AbrahamOO/dotfiles/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/AbrahamOO/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
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

## 🔐 Security Considerations

### What's Safe

✅ All scripts in this repository contain **NO credentials**
✅ No API tokens, passwords, or secrets
✅ Only automation logic
✅ Safe to share publicly

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

## 🔄 Updating

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

### Example 3: Multiple Computers

```bash
# On new computer
$ curl -fsSL https://raw.githubusercontent.com/AbrahamOO/dotfiles/main/install.sh | bash
$ gh auth login
$ new-secure-repo another-project
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

## 📖 Documentation

- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Branch Protection API](https://docs.github.com/en/rest/branches/branch-protection)

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:
- Fork for your own use
- Suggest improvements via issues
- Share your own dotfiles repo

## 📄 License

MIT License - Feel free to use and modify

## ⭐ Acknowledgments

Inspired by dotfiles repositories from:
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [paulirish/dotfiles](https://github.com/paulirish/dotfiles)

---

**Made with ❤️ for secure, automated repository management**
