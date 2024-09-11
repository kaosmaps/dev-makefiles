# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .github-workflows-setup

.github-workflows-setup:
	@echo "Scaffolding GitHub Workflows..."
	@mkdir -p $(TARGET_DIR)/.github/workflows
	@echo "$$CI_CD_WORKFLOW_CONTENT" > $(TARGET_DIR)/.github/workflows/ci_cd.yml

define CI_CD_WORKFLOW_CONTENT
name: CI/CD

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x'
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install poetry
        poetry install
    - name: Run tests
      run: |
        poetry run pytest

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
    - uses: actions/checkout@v2
    - name: Deploy
      run: echo "Add your deployment steps here"
endef
export CI_CD_WORKFLOW_CONTENT
