# Version: 1.0.2
# Last updated: 2024-03-14

.PHONY: .create-pyproject

.create-pyproject:
	@echo "Creating pyproject.toml..."
	@echo "$$PYPROJECT_CONTENT" > $(TARGET_DIR)/pyproject.toml

define PYPROJECT_CONTENT
[tool.poetry]
name = "$(SAUBER_PACKAGE_NAME)"
version = "0.0.1"
description = "A Python package for tool vision"
authors = ["Your Name <you@example.com>"]
readme = "README.md"
packages = [{include = "$(subst -,_,$(SAUBER_PACKAGE_NAME))", from = "src"}]

[tool.poetry.dependencies]
python = "^$(SAUBER_PYTHON_VERSION)"
$(foreach dep,$(DEPENDENCIES),$(dep) = "*"
)

[tool.poetry.group.dev.dependencies]
$(foreach dev_dep,$(DEV_DEPENDENCIES),$(dev_dep) = "*"
)

[tool.poetry.scripts]
$(if $(filter subpackage,$(SAUBER_PACKAGE_TYPE)),$(SAUBER_PACKAGE_PARENT),$(SAUBER_PACKAGE_NAME)) = "$(subst -,_,$(SAUBER_PACKAGE_NAME)).cli.commands:cli"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"

[tool.pytest.ini_options]
testpaths = ["tests"]
pythonpath = ["src"]

[tool.ruff]
line-length = 88
target-version = "py$(shell echo $(SAUBER_PYTHON_VERSION) | sed 's/\([0-9]\)\.\([0-9]\{1,2\}\).*/\1\2/')"

[tool.isort]
profile = "black"
line_length = 88

[tool.mypy]
SAUBER_PYTHON_VERSION = "$(SAUBER_PYTHON_VERSION)"
strict = true
endef
export PYPROJECT_CONTENT
