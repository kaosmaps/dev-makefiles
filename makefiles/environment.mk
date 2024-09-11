# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

# Python environment and dependency management tasks
.PHONY: .setup-env .activate-venv .install-deps .setup-hooks

.setup-env:
	echo "Setting up Python environment..."
	if command -v pyenv >/dev/null 2>&1; then \
		pyenv local $(SAUBER_PYTHON_VERSION) || { echo "Failed to set local Python version."; exit 1; } \
	else \
		echo "pyenv not found. Skipping Python version setup."; \
	fi
	poetry config virtualenvs.in-project true || { echo "Failed to configure poetry virtualenvs.in-project."; exit 1; }
	if [ ! -f pyproject.toml ]; then \
		poetry init -n; \
	else \
		echo "pyproject.toml already exists. Skipping poetry init."; \
	fi

.activate-venv:
	@echo "Activating virtual environment..."
	# @poetry shell || { echo "Failed to activate poetry shell."; exit 1; }
	@poetry run echo "Virtual environment activated." || { echo "Failed to activate poetry shell."; exit 1; }

.install-deps:
	@echo "Installing dependencies..."
	poetry add $(DEPENDENCIES)
	poetry add --group dev $(DEV_DEPENDENCIES)
	poetry install
	@echo "Creating .env file if it doesn't exist..."
	@touch .env
	@echo "Attempting to load environment variables..."
	@poetry run python -c "from dotenv import load_dotenv; load_dotenv('.env'); print('Environment variables loaded successfully.')"
	@eval $$(poetry run python -c "from dotenv import load_dotenv; load_dotenv('.env'); import os; print(' '.join([f'export {k}=\"{v}\"' for k, v in os.environ.items() if k.startswith('POETRY_') or k == 'PYTHON_KEYRING_BACKEND']))")

.setup-hooks:
	@echo "Setting up pre-commit hooks..."
	@if ! command -v pre-commit &> /dev/null; then \
		echo "pre-commit not found. Installing..."; \
		poetry run pip install pre-commit; \
	fi
	poetry run pre-commit install
