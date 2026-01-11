# OpenCode OMO Modifications

🔒 **A smart allowlist system** for OpenCode that provides security with intelligent prompting for unauthorized commands.

## 🎯 What This Does

- **🛡️ Security First**: Only allow explicitly approved commands to execute
- **🤖 Smart Prompting**: Ask for permission when commands aren't in allowlist
- **⚡ Flexible**: Allow commands once or permanently add them
- **📦 Easy Setup**: One-command installation with Makefile
- **🎯 Developer Ready**: 150+ pre-approved commands for common workflows

---

## 🚀 Installation (Step-by-Step)

### Prerequisites
- ✅ Git installed
- ✅ Bash shell
- ✅ Standard Unix tools (mkdir, cp, chmod)

### Step 1: Clone the Repository
```bash
git clone https://github.com/bhodgens/opencode-omo-modifications.git
cd opencode-omo-modifications
```

### Step 2: Install with Makefile
```bash
make install
```

**What this does:**
- 📁 Creates `~/bin/` directory (if needed)
- 📋 Installs `opencode-exec` wrapper to `~/bin/`
- ⚙️ Creates `~/.config/opencode/` directory (if needed)
- 📝 Installs default `allowlist.txt` (if you don't have one)
- 🔐 Sets correct permissions on wrapper script

### Step 3: Configure Your Shell
**For Zsh (default on macOS):**
```bash
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.zshrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**For Bash:**
```bash
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Step 4: Verify Installation
```bash
# Check wrapper is executable
ls -la ~/bin/opencode-exec

# Test wrapper works
~/bin/opencode-exec pwd

# Verify environment variable is set
echo $OPENCODE_EXEC_WRAPPER
```

### Step 5: Start OpenCode with Wrapper
```bash
opencode
```

---

## 🎮 How It Works

### ✅ Allowed Commands (No Prompting)
Commands matching patterns in your allowlist execute immediately.

### ⚠️ Unauthorized Commands (Interactive Prompt)

**When you run a command not in allowlist:**
```bash
⚠️  Command not in allowlist: some-command arg1 arg2
📍 Allowlist location: /Users/username/.config/opencode/allowlist.txt

Do you want to: [A]llow once, [P]ermanently add, [D]eny?
```

**Options:**
- **[A]llow once** - Execute this command one time only
- **[P]ermanently add** - Add to allowlist and execute immediately
- **[D]eny** - Block the command

### 🤖 Non-Interactive Mode (OpenCode)

When OpenCode runs commands, it shows:
```bash
🤖 OpenCode: This command requires user approval.
💡 To allow this command permanently, add it to allowlist:
   echo "command args" >> "/Users/username/.config/opencode/allowlist.txt"
💡 To allow this command once, run:
   OPENCODE_ALLOW_ONCE=true command args
```

---

## 📋 Managing Your Allowlist

### View Current Allowlist
```bash
cat ~/.config/opencode/allowlist.txt
```

### Add Commands Manually
```bash
# Add a specific command
echo "npm run build" >> ~/.config/opencode/allowlist.txt

# Add a pattern (all npm commands)
echo "npm *" >> ~/.config/opencode/allowlist.txt
```

### Search for Commands
```bash
# Find all docker-related commands
grep "docker" ~/.config/opencode/allowlist.txt

# Count total allowed commands
wc -l ~/.config/opencode/allowlist.txt
```

### Remove Commands
```bash
# Edit the allowlist file
nano ~/.config/opencode/allowlist.txt

# Or remove specific lines
sed -i '' '/npm run build/d' ~/.config/opencode/allowlist.txt
```

---

## 🎯 Pre-Approved Command Categories

### 📦 Development Tools
- **Package Managers**: `npm *`, `yarn *`, `pnpm *`, `pip *`, `pip3 *`, `node *`, `npx *`
- **Build Tools**: `make *`, `cmake *`, `cargo *`, `go *`, `java *`, `gradle *`, `maven *`, `mvn *`
- **Compilers**: `gcc *`, `g++ *`, `clang *`, `rustc *`, `javac *`
- **Debuggers**: `gdb *`, `valgrind *`

### 🐳 Container & Cloud
- **Docker**: `docker *`, `docker compose *`, `docker-compose *`, `podman *`
- **Kubernetes**: `kubectl *`, `helm *`, `kubens *`, `kubectx *`
- **Cloud CLI**: `aws *`, `gcloud *`, `az *`, `terraform *`

### 📁 File & System Operations
- **File Ops**: `cat *`, `touch *`, `cp *`, `mv *`, `rm *`, `chmod *`, `chown *`
- **System Info**: `pwd`, `ls`, `tree`, `stat *`, `file *`, `du *`, `df *`, `whoami`, `uname`, `date`, `id`
- **Process Mgmt**: `ps *`, `kill *`, `killall *`, `jobs *`, `fg *`, `bg *`, `nohup *`
- **System Tools**: `systemctl *`, `service *`, `top *`, `htop *`, `lsof *`, `netstat *`, `ss *`

### 🌐 Network Tools
- **SSH/SCP**: `ssh *`, `scp *`, `rsync *`
- **Download**: `wget *`, `curl *`
- **Network**: `ping *`

### 📝 Text & Data
- **Editors**: `nano *`, `vim *`, `vi *`, `emacs *`, `code *`
- **Processing**: `grep *`, `awk *`, `sed *`, `jq *`, `yq *`, `toml *`
- **Archive**: `tar *`, `unzip *`, `zip *`, `gzip *`, `gunzip *`, `bzip2 *`, `bunzip2 *`, `xz *`, `unxz *`

### 🗃️ Version Control
- **Complete Git**: `git status`, `git diff`, `git log *`, `git clone *`, `git pull *`, `git push *`, etc.

### 🗄️ Database Tools
- `mysql *`, `psql *`, `sqlite3 *`, `mongo *`

---

## 🔧 Advanced Configuration

### Environment Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `OPENCODE_EXEC_WRAPPER` | Path to wrapper script | `export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"` |
| `OPENCODE_ALLOW_ONCE` | Allow one command without prompting | `OPENCODE_ALLOW_ONCE=true risky-command` |
| `OPENCODE_ALLOWLIST` | Custom allowlist location | `export OPENCODE_ALLOWLIST="/path/to/custom.txt"` |

### Custom Allowlist Location
```bash
# Use a custom allowlist file
export OPENCODE_ALLOWLIST="/my/custom/allowlist.txt"
```

### Block-Only Mode (No Prompting)
```bash
# Only block commands, don't prompt
export OPENCODE_BLOCK_MODE=true
```

---

## 🛠️ Makefile Commands

```bash
make help          # Show all available commands
make install       # Install wrapper and setup allowlist
make uninstall     # Remove wrapper and optionally allowlist
make check-deps    # Verify system dependencies
make clean         # Remove temporary files
```

---

## 🎯 Usage Examples

### Daily Workflow
```bash
# Start OpenCode with wrapper
opencode

# During OpenCode session, commands will be filtered:
- Allowed: git status, npm install, docker build
- Prompted: rm -rf /important (will ask for permission)
- Blocked: sudo rm -rf / (dangerous, will deny)
```

### Temporary Access
```bash
# Allow a specific command once
OPENCODE_ALLOW_ONCE=true ~/bin/opencode-exec "risky-command-with-args"

# Use within OpenCode recommendations
OPENCODE_ALLOW_ONCE=true docker run --rm ubuntu bash
```

### Allowlist Management
```bash
# Add all terraform commands
echo "terraform *" >> ~/.config/opencode/allowlist.txt

# Allow specific database access
echo "mysql -u user -p db_name" >> ~/.config/opencode/allowlist.txt

# View current settings
cat ~/.config/opencode/allowlist.txt | grep -E "(docker|k8s|aws)"
```

---

## 🐛 Troubleshooting

### 🔍 Diagnosis Commands

```bash
# Check if wrapper is installed
ls -la ~/bin/opencode-exec

# Verify wrapper is executable
test -x ~/bin/opencode-exec && echo "✅ Executable" || echo "❌ Not executable"

# Check allowlist exists
test -f ~/.config/opencode/allowlist.txt && echo "✅ Allowlist exists" || echo "❌ Allowlist missing"

# Check environment variable
echo $OPENCODE_EXEC_WRAPPER

# Check PATH includes ~/bin
echo $PATH | grep -o "$HOME/bin"
```

### Common Issues & Solutions

**❌ "Command not found" Error**
```bash
# Problem: ~/bin not in PATH
# Solution: Add to shell profile
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**❌ "Permission denied" Error**
```bash
# Problem: Wrapper not executable
# Solution: Fix permissions
chmod +x ~/bin/opencode-exec
```

**❌ "Allowlist not working" Error**
```bash
# Problem: Environment variable not set
# Solution: Set the variable
export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.zshrc
```

**❌ Commands Always Prompt**
```bash
# Problem: Command not matching allowlist patterns
# Solution: Check patterns exist
grep "npm" ~/.config/opencode/allowlist.txt

# Add broader pattern if needed
echo "npm *" >> ~/.config/opencode/allowlist.txt
```

**❌ Interactive Prompt Not Showing**
```bash
# Problem: Running in non-interactive mode
# Solution: Use allow-once or add to allowlist
OPENCODE_ALLOW_ONCE=true ~/bin/opencode-exec "your-command"
```

---

## 🔒 Security Features

1. **🛡️ Default-Deny**: Only explicitly allowed commands can execute
2. **📝 Audit Trail**: All allowed commands are recorded in allowlist
3. **🎯 Pattern Matching**: Supports exact matches and flexible glob patterns
4. **🤖 User Control**: Interactive approval for new commands
5. **⚡ Temporary Access**: Allow-once mode for one-time exceptions
6. **🔐 Proper Exit Codes**: Returns standard Unix exit codes (126 for denied)

---

## 📚 File Structure

```
opencode-omo-modifications/
├── opencode-exec          # Main wrapper script
├── allowlist.txt          # Default allowlist with 150+ commands
├── Makefile              # Installation and management
├── README.md              # This documentation
└── .gitignore            # Git ignore rules
```

---

## 🚀 Quick Start Summary

```bash
# One-line installation
git clone https://github.com/bhodgens/opencode-omo-modifications.git && \
cd opencode-omo-modifications && \
make install && \
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.zshrc && \
source ~/.zshrc && \
opencode
```

---

## 📝 License

MIT License - Free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test thoroughly with `make check-deps`
5. Commit changes: `git commit -m "Add your feature"`
6. Push to your fork: `git push origin feature-name`
7. Create a Pull Request

## 🔗 Links

- **Repository**: https://github.com/bhodgens/opencode-omo-modifications
- **OpenCode**: https://github.com/opencode-dev/oh-my-opencode
- **Issues**: Report bugs via GitHub Issues

---

## 🎯 TL;DR (Too Long; Didn't Read)

```bash
# Install
git clone https://github.com/bhodgens/opencode-omo-modifications.git
cd opencode-omo-modifications
make install

# Setup shell
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.zshrc
source ~/.zshrc

# Use
opencode
```

*Commands will be filtered through a smart allowlist that prompts for authorization.*