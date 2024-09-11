# Version: 1.0.0
# Last updated: 2023-12-13

# Configuration variables

# Package Information
# -------------------
SAUBER_PACKAGE_NAME := $(or $(SAUBER_PACKAGE_NAME), dev-makefiles)

# GITHUB_ORG: The GitHub organization or username where the repository will be created.
# Examples:
#   - Organization: mycompany
#   - Personal account: johndoe
GITHUB_ORG := $(or $(SAUBER_GITHUB_ORG), kaosmaps)

# GITHUB_REPO_PRIVATE: Determines if the GitHub repository should be private.
# Set to 'true' for a private repository, 'false' for a public repository.
# Default is 'true' (private repository).
GITHUB_REPO_PRIVATE := $(or $(SAUBER_GITHUB_REPO_PRIVATE), true)

# SAUBER_PYTHON_VERSION: The version of Python to use for this project.
# Example: 3.9.5
SAUBER_PYTHON_VERSION := $(or $(SAUBER_PYTHON_VERSION), 3.12.3)

# Dependencies
# ------------
# DEPENDENCIES: Space-separated list of production dependencies to be installed.
DEPENDENCIES := $(or $(SAUBER_DEPENDENCIES), fastapi uvicorn pydantic pydantic-settings python-dotenv-vault click streamlit plotly)

# DEV_DEPENDENCIES: Space-separated list of development dependencies to be installed.
DEV_DEPENDENCIES := $(or $(SAUBER_DEPENDENCIES_DEV), pytest ruff isort mypy pre-commit sphinx sphinx-autodoc-typehints myst-parser)

# Package Structure
# -----------------
# SAUBER_PACKAGE_TYPE: Determines the package structure. Options:
# - standard: A standalone package
# - subpackage: Part of a larger package ecosystem
# SAUBER_PACKAGE_TYPE := subpackage
SAUBER_PACKAGE_TYPE := $(or $(SAUBER_PACKAGE_TYPE), standard)

# SAUBER_PACKAGE_PARENT: Only needed if SAUBER_PACKAGE_TYPE is subpackage.
# Specifies the name of the parent package this subpackage belongs to.
# Example: mycompany
# SAUBER_PACKAGE_PARENT := sauber
SAUBER_PACKAGE_PARENT := $(or $(SAUBER_PACKAGE_PARENT),)

# ENTRY_POINT: The entry point for the CLI command.
# This will be automatically set based on SAUBER_PACKAGE_TYPE and SAUBER_PACKAGE_PARENT.
ifeq ($(SAUBER_PACKAGE_TYPE),subpackage)
    ENTRY_POINT := $(SAUBER_PACKAGE_PARENT).$(subst -,_,$(SAUBER_PACKAGE_NAME)).cli:main
else
    ENTRY_POINT := $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli:main
endif

# SRC_DIR: The directory containing the package source code.
# Example: src
SRC_DIR := $(or $(SAUBER_SRC_DIR), src)

# TARGET_DIR: The directory containing the package source code.
# Example: src
TARGET_DIR := $(or $(SAUBER_TARGET_DIR), .)

# Note on multi-word package names:
# - For PyPI and GitHub: Use hyphens (e.g., my-package-name)
# - For Python imports: Hyphens will be converted to underscores (e.g., my_package_name)
# - Directory structure: Will use the PyPI naming (with hyphens)
# The Makefile system will handle the necessary conversions between these formats.
#
# Examples:
# 1. For a package named "my-awesome-package":
#    - PyPI/GitHub name: my-awesome-package
#    - Python import: import my_awesome_package
#    - Directory structure: src/my-awesome-package/
#
# 2. For a subpackage named "data-processor" under "mycompany":
#    - PyPI/GitHub name: mycompany-data-processor
#    - Python import: from mycompany import data_processor
#    - Directory structure: src/mycompany/data-processor/

# SAUBER_AUTO_CONFIRM: Set to 'true' to automatically confirm all prompts
# This is useful for non-interactive environments or when you're sure about all choices
SAUBER_AUTO_CONFIRM := $(or $(SAUBER_AUTO_CONFIRM), false)

export SRC_DIR
export SAUBER_PACKAGE_NAME
export GITHUB_ORG
export GITHUB_REPO_PRIVATE
export SAUBER_PYTHON_VERSION
export DEPENDENCIES
export DEV_DEPENDENCIES
export SAUBER_PACKAGE_TYPE
export SAUBER_PACKAGE_PARENT
export ENTRY_POINT
export SAUBER_AUTO_CONFIRM
