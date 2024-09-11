# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .clean

.clean:
	@echo "Cleaning up..."
	rm -f $(TARGET_DIR)/poetry.lock
	rm -rf $(TARGET_DIR)/.venv
	rm -rf $(TARGET_DIR)/__pycache__
	rm -rf $(TARGET_DIR)/.pytest_cache
	rm -rf $(TARGET_DIR)/.mypy_cache
	rm -rf $(TARGET_DIR)/.ruff_cache
	find $(TARGET_DIR) -type d -name "__pycache__" -exec rm -rf {} +
	find $(TARGET_DIR) -type f -name "*.pyc" -delete
