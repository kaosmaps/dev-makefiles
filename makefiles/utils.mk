# makefiles/utils.mk

.PHONY: .create-utils

.create-utils:
	@echo "Creating utils directory and demo content..."
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(SAUBER_PACKAGE_NAME_PYTHON)/utils
	@echo "$$UTILS_DEMO_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(SAUBER_PACKAGE_NAME_PYTHON)/utils/demo_util.py
	@echo "Utils directory and demo content created."

define UTILS_DEMO_CONTENT
# $(SRC_DIR)/$(SAUBER_PACKAGE_NAME_PYTHON)/utils/demo_util.py

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
