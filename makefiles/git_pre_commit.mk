# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .git-pre-commit-setup

# Remove the duplicate target definition
# .git-pre-commit-setup:
#     @echo "Creating .pre-commit-config.yaml..."
#     @echo "$$PRECOMMIT_CONTENT" > $(TARGET_DIR)/.pre-commit-config.yaml

# Keep only this target definition
.git-pre-commit-setup:
	@echo "Setting up pre-commit..."
	@if [ ! -f $(TARGET_DIR)/.pre-commit-config.yaml ]; then \
		echo "Creating .pre-commit-config.yaml..."; \
		echo "$$PRECOMMIT_CONTENT" > $(TARGET_DIR)/.pre-commit-config.yaml; \
	else \
		echo ".pre-commit-config.yaml already exists. Skipping creation."; \
	fi
	@if command -v pre-commit >/dev/null 2>&1; then \
		cd $(TARGET_DIR) && pre-commit install; \
	else \
		echo "pre-commit is not installed. Please install it to use pre-commit hooks."; \
	fi

define PRECOMMIT_CONTENT
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
  - repo: https://github.com/pycqa/isort
    rev: 5.13.2
    hooks:
      - id: isort
  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.5.7
    hooks:
      - id: ruff
endef
export PRECOMMIT_CONTENT
