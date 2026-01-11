# OpenCode OMO Modifications

A **smart allowlist system** for OpenCode that provides security with intelligent prompting for unauthorized commands.

## ✨ Features

- **🔒 Persistent Allowlist** - Commands saved to `~/.config/opencode/allowlist.txt`
- **🤖 Smart Prompting** - Interactive approval for unauthorized commands
- **⚡ Allow-Once Mode** - Execute specific commands without permanently adding them
- **📦 Easy Installation** - Simple Makefile-based setup
- **🎯 Comprehensive Defaults** - 150+ pre-approved common development commands

## 🚀 Quick Install

```bash
# Clone the repository
git clone https://github.com/bhodgens/opencode-omo-modifications.git
cd opencode-omo-modifications

# Install with Makefile
make install

# Add to your shell profile
echo 'export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"' >> ~/.zshrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Start OpenCode with wrapper
opencode
```

## 📋 Files

- **`opencode-exec`** - The main wrapper script with intelligent prompting
- **`allowlist.txt`** - Comprehensive default allowlist with 150+ commands
- **`Makefile`** - Automated installation and management
- **`README.md`** - This documentation

## 🎮 Command Handling

### ✅ Allowed Commands
Commands matching allowlist patterns execute immediately without prompting.

### ⚠️ Unauthorized Commands

**Interactive Mode (Terminal):**
```
⚠️  Command not in allowlist: some-command arg1 arg2
📍 Allowlist location: /Users/caimlas/.config/opencode/allowlist.txt

Do you want to: [A]llow once, [P]ermanently add, [D]eny?
```

**Non-Interactive Mode (OpenCode):**
```
🤖 OpenCode: This command requires user approval.
💡 To allow this command permanently, add it to allowlist:
   echo "command args" >> "/Users/caimlas/.config/opencode/allowlist.txt"
💡 To allow this command once, run:
   OPENCODE_ALLOW_ONCE=true command args
```

## 📦 Installation Options

### Standard Installation
```bash
make install
```

### Uninstallation
```bash
make uninstall
```

### Check Dependencies
```bash
make check-deps
```

### Clean Temporary Files
```bash
make clean
```

## 🔧 Configuration

### Environment Variables

- **`OPENCODE_EXEC_WRAPPER`** - Path to the wrapper script
- **`OPENCODE_ALLOW_ONCE`** - Allow a specific command once without prompting

### Custom Allowlist Location
```bash
export OPENCODE_ALLOWLIST="/path/to/custom/allowlist.txt"
```

## 📋 Default Allowlist Categories

The default allowlist includes commands for:

### **Development Tools**
- **Package Managers**: `npm`, `yarn`, `pnpm`, `pip`, `pip3`, `node`, `npx`
- **Build Tools**: `make`, `cmake`, `cargo`, `go`, `java`, `gradle`, `maven`, `mvn`
- **Compilers**: `gcc`, `g++`, `clang`, `rustc`, `javac`
- **Debuggers**: `gdb`, `valgrind`

### **Container & Cloud**
- **Docker**: `docker *`, `docker compose *`, `docker-compose *`
- **Kubernetes**: `kubectl *`, `helm *`, `kubens *`, `kubectx *`
- **Cloud CLI**: `aws *`, `gcloud *`, `az *`, `terraform *`

### **Version Control**
- **Git**: Complete git operations (`git status`, `git diff`, `git clone`, `git push`, etc.)

### **System & File Operations**
- **File Ops**: `cat`, `touch`, `cp`, `mv`, `rm`, `chmod`, `chown`
- **System**: `ps`, `kill`, `top`, `htop`, `systemctl`, `service`
- **Network**: `ssh`, `scp`, `rsync`, `curl`, `wget`
- **Text**: `nano`, `vim`, `vi`, `emacs`, `code`

### **Database Tools**
- `mysql *`, `psql *`, `sqlite3 *`, `mongo *`

## 🎯 Usage Examples

### Basic Usage
```bash
# Set wrapper and start OpenCode
export OPENCODE_EXEC_WRAPPER="$HOME/bin/opencode-exec"
opencode

# Allow-once for specific commands
OPENCODE_ALLOW_ONCE=true risky-command-with-args
```

### Managing Allowlist
```bash
# View current allowlist
cat ~/.config/opencode/allowlist.txt

# Add new command
echo "new-command *" >> ~/.config/opencode/allowlist.txt

# Search for specific commands
grep "docker" ~/.config/opencode/allowlist.txt
```

## 🔒 Security Features

1. **Automatic Setup** - Creates directory and default allowlist if missing
2. **Flexible Patterns** - Supports exact matches and glob patterns
3. **User Control** - Interactive prompting for unauthorized commands
4. **Audit Trail** - All allowed commands recorded in allowlist
5. **Exit Codes** - Returns standard exit codes (126 for denied commands)

## 🛠️ Makefile Targets

| Target | Description |
|--------|-------------|
| `install` | Install wrapper and setup allowlist |
| `uninstall` | Remove wrapper and optionally allowlist |
| `check-deps` | Verify system dependencies |
| `clean` | Clean temporary files |
| `help` | Show help information |

## 🧪 Testing

```bash
# Test wrapper directly
./opencode-exec pwd
./opencode-exec "echo 'Hello World'"

# Test allow-once
OPENCODE_ALLOW_ONCE=true ./opencode-exec "echo 'Temporary access'"

# Test with OpenCode
export OPENCODE_EXEC_WRAPPER="./opencode-exec"
opencode
```

## 🔗 Integration with OpenCode

Once installed, OpenCode automatically uses the wrapper when the `OPENCODE_EXEC_WRAPPER` environment variable is set. All bash command executions are filtered through the allowlist with intelligent prompting for unauthorized commands.

This provides the perfect balance between security and productivity - keeping dangerous operations blocked while allowing legitimate development workflows through user approval.

## 📝 License

MIT License - Feel free to modify and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 🐛 Troubleshooting

### Common Issues

**Command not found:**
```bash
# Ensure ~/bin is in PATH
echo $PATH | grep -o "$HOME/bin"
export PATH="$HOME/bin:$PATH"
```

**Permission denied:**
```bash
# Make executable
chmod +x ~/bin/opencode-exec
```

**Allowlist not working:**
```bash
# Check file exists
ls -la ~/.config/opencode/allowlist.txt

# Check wrapper path
echo $OPENCODE_EXEC_WRAPPER
```

### Getting Help

```bash
make help          # Show Makefile targets
./opencode-exec    # Show usage information
```