# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .git-repo-setup .git-gitignore-create

.git-repo-setup:
	@echo "Setting up Git repository..."
	@if [ ! -d .git ]; then \
		git init; \
		echo "Git repository initialized."; \
	else \
		echo "Git repository already exists. Skipping initialization."; \
	fi
	@echo "Setting up Git configuration..."
	@if [ -z "$(shell git config user.name)" ]; then \
		read -p "Enter your Git username: " git_username; \
		git config user.name "$$git_username"; \
	else \
		echo "Git username already set: $(shell git config user.name)"; \
	fi
	@if [ -z "$(shell git config user.email)" ]; then \
		read -p "Enter your Git email: " git_email; \
		git config user.email "$$git_email"; \
	else \
		echo "Git email already set: $(shell git config user.email)"; \
	fi

.git-gitignore-create:
	@echo "Creating .gitignore file..."
	@if [ ! -f $(TARGET_DIR)/.gitignore ]; then \
		printf "%s" "$$GITIGNORE_CONTENT" > $(TARGET_DIR)/.gitignore; \
		echo ".gitignore file created."; \
	else \
		echo ".gitignore file already exists. Skipping creation."; \
	fi

define GITIGNORE_CONTENT
# Python
__pycache__/
*.py[cod]
*.so
.Python
env/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Virtual environment
.venv/
venv/

# IDE
.vscode/
.idea/

# Misc
.DS_Store
*.log
*.sqlite3

# Project-specific
.env
.env.*
!.env.example
endef
export GITIGNORE_CONTENT
