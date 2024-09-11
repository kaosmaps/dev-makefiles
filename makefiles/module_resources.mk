# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-resources

define RESOURCES_STRUCTURE
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/resources
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/resources/__init__.py
endef
export RESOURCES_STRUCTURE

.create-module-resources:
	@echo "Creating resources structure and files..."
	@$(RESOURCES_STRUCTURE)
	@echo "$$RESOURCES_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/resources/__init__.py

define RESOURCES_CONTENT
# This directory is for project resources such as templates, static files, etc.
# You can access these resources using pkg_resources or importlib.resources
# Example:
# from importlib.resources import files
# template = files('your_package.resources').joinpath('template.txt').read_text()
endef
export RESOURCES_CONTENT
