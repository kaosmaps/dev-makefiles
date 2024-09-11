# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

    .PHONY: .create-utils

define UTILS_STRUCTURE
mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/utils
touch $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/utils/__init__.py
endef
export UTILS_STRUCTURE

.create-module-utils:
	@echo "Creating utils structure and files..."
	@$(UTILS_STRUCTURE)
	@echo "$$UTILS_DEMO_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/utils/demo_util.py

define UTILS_DEMO_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/utils/demo_util.py

def demo_utility_function(text: str) -> str:
    """
    A demo utility function that capitalizes the input text.

    Args:
        text (str): The input text to be capitalized.

    Returns:
        str: The capitalized text.
    """
    return text.upper()
endef
export UTILS_DEMO_CONTENT