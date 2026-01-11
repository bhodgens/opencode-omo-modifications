# Makefile for OpenCode OMO Modifications
# Install persistent command allowlist wrapper for OpenCode

.PHONY: install uninstall clean help check-deps

# Default target
all: install

# Install the opencode-exec wrapper and setup allowlist
install:
	@echo "🚀 Installing OpenCode OMO modifications..."
	
	# Create bin directory if it doesn't exist
	@mkdir -p $(HOME)/bin
	
	# Install opencode-exec wrapper
	@cp opencode-exec $(HOME)/bin/opencode-exec
	@chmod +x $(HOME)/bin/opencode-exec
	
	# Create opencode config directory
	@mkdir -p $(HOME)/.config/opencode
	
	# Install allowlist if not exists
	@if [ ! -f $(HOME)/.config/opencode/allowlist.txt ]; then \
		echo "📋 Installing default allowlist..."; \
		cp allowlist.txt $(HOME)/.config/opencode/allowlist.txt; \
	else \
		echo "📋 Allowlist already exists, keeping current settings"; \
	fi
	
	@echo "✅ Installation complete!"
	@echo ""
	@echo "🎯 To use with OpenCode:"
	@echo "   export OPENCODE_EXEC_WRAPPER=\"$(HOME)/bin/opencode-exec\""
	@echo "   opencode"
	@echo ""
	@echo "💡 Add to your shell profile (~/.zshrc, ~/.bashrc):"
	@echo "   export OPENCODE_EXEC_WRAPPER=\"$(HOME)/bin/opencode-exec\""
	@echo "   export PATH=\"$(HOME)/bin:$$PATH\""

# Uninstall the opencode-exec wrapper
uninstall:
	@echo "🗑️  Uninstalling OpenCode OMO modifications..."
	
	# Remove wrapper script
	@rm -f $(HOME)/bin/opencode-exec
	
	# Ask about allowlist
	@if [ -f $(HOME)/.config/opencode/allowlist.txt ]; then \
		read -p "Remove allowlist file? [y/N]: " -n 1 -r response; \
		echo ""; \
		if [[ $$response =~ ^[Yy] ]]; then \
			rm -f $(HOME)/.config/opencode/allowlist.txt; \
			echo "📋 Allowlist removed"; \
		else \
			echo "📋 Allowlist kept at $(HOME)/.config/opencode/allowlist.txt"; \
		fi; \
	fi
	
	@echo "✅ Uninstall complete!"

# Clean temporary files
clean:
	@echo "🧹 Cleaning up..."
	@rm -f *.bak *~
	@echo "✅ Clean complete!"

# Show help
help:
	@echo "OpenCode OMO Modifications"
	@echo "=========================="
	@echo ""
	@echo "Available targets:"
	@echo "  install    - Install opencode-exec wrapper and allowlist"
	@echo "  uninstall  - Remove opencode-exec wrapper"
	@echo "  clean     - Clean temporary files"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make install     # Install everything"
	@echo "  make uninstall   # Remove modifications"
	@echo ""
	@echo "After installation, use with:"
	@echo "  export OPENCODE_EXEC_WRAPPER=\"$(HOME)/bin/opencode-exec\""
	@echo "  opencode"

# Check dependencies
check-deps:
	@echo "🔍 Checking dependencies..."
	@command -v bash >/dev/null 2>&1 && echo "✅ bash: found" || echo "❌ bash: not found"
	@command -v mkdir >/dev/null 2>&1 && echo "✅ mkdir: found" || echo "❌ mkdir: not found"
	@command -v cp >/dev/null 2>&1 && echo "✅ cp: found" || echo "❌ cp: not found"
	@command -v chmod >/dev/null 2>&1 && echo "✅ chmod: found" || echo "❌ chmod: not found"
	@echo ""
	@echo "All dependencies satisfied!"