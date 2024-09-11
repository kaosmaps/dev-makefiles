# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

# Notebook-based development tasks
.PHONY: .create-readme-notebook .update-readme-notebook

NOTEBOOK_DIR := notebooks
README_NOTEBOOK := $(NOTEBOOK_DIR)/README.ipynb

define NOTEBOOK_CONTENT
{
    "cells": [
        {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
                "# $(SAUBER_PACKAGE_NAME) Usage Guide\n",
                "\n",
                "This notebook demonstrates how to use the main components of $(SAUBER_PACKAGE_NAME)."
            ]
        },
        {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
                "## Importing Services"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "from $(SAUBER_PACKAGE_NAME_PYTHON).services import *\n",
                "\n",
                "# Example usage of a service\n",
                "# result = some_service_function()"
            ]
        },
        {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
                "## Using the CLI"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "!python -m $(SAUBER_PACKAGE_NAME_PYTHON).cli --help"
            ]
        },
        {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
                "## Interacting with the API"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "from $(SAUBER_PACKAGE_NAME_PYTHON).api import app\n",
                "from fastapi.testclient import TestClient\n",
                "\n",
                "client = TestClient(app)\n",
                "response = client.get(\"/\")\n",
                "print(response.json())"
            ]
        }
    ],
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "codemirror_mode": {
                "name": "ipython",
                "version": 3
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3",
            "version": "3.8.0"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 4
}
endef
export NOTEBOOK_CONTENT

# create-readme-notebook:
# 	@echo "Creating README.ipynb..."
# 	@mkdir -p $(NOTEBOOK_DIR)
# 	@echo '$(subst ','"'"',$(NOTEBOOK_CONTENT))' | sed 's/\$${/\$$/g' > $(README_NOTEBOOK)
# 	@echo "README.ipynb created successfully."

# create-readme-notebook:
# 	@echo "Creating README.ipynb..."
# 	@mkdir -p $(NOTEBOOK_DIR)
# 	@printf '%s' "$${NOTEBOOK_CONTENT}" | \
# 		sed 's/\$$(SAUBER_PACKAGE_NAME)/$(SAUBER_PACKAGE_NAME)/g; s/\$$(SAUBER_PACKAGE_NAME_PYTHON)/$(SAUBER_PACKAGE_NAME_PYTHON)/g' > $(README_NOTEBOOK)
# 	@echo "README.ipynb created successfully."

.create-readme-notebook:
	@echo "Creating README.ipynb..."
	@mkdir -p $(TARGET_DIR)/$(NOTEBOOK_DIR)
	@printf '%s' "$${NOTEBOOK_CONTENT}" | \
		sed 's/$$(SAUBER_PACKAGE_NAME)/$(SAUBER_PACKAGE_NAME)/g; s/$$(SAUBER_PACKAGE_NAME_PYTHON)/$(SAUBER_PACKAGE_NAME_PYTHON)/g' | \
		sed 's/\\n/\n/g; s/\\t/\t/g' > $(TARGET_DIR)/$(README_NOTEBOOK)
	@echo "README.ipynb created successfully."

.update-readme-notebook:
	@echo "Updating README.ipynb..."
	@echo '$(subst ','"'"',$(NOTEBOOK_CONTENT))' | sed 's/\$${/\$$/g' > $(README_NOTEBOOK)
	@echo "README.ipynb updated successfully."
