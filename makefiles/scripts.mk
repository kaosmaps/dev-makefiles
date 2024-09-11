# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-scripts

define START_API_CONTENT
#!/bin/bash

HOST=$${1:-"0.0.0.0"}
PORT=$${2:-8000}

python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli api-start --host $$HOST --port $$PORT
endef
export START_API_CONTENT

define START_APP_CONTENT
#!/bin/bash

HOST=$${1:-"0.0.0.0"}
PORT=$${2:-8501}

python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli app-start --host $$HOST --port $$PORT
endef
export START_APP_CONTENT

define CLI_START_API_CONTENT
#!/bin/bash

HOST=$${1:-"0.0.0.0"}
PORT=$${2:-8000}

python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli api-start --host $$HOST --port $$PORT
endef
export CLI_START_API_CONTENT

define CLI_START_APP_CONTENT
#!/bin/bash

HOST=$${1:-"0.0.0.0"}
PORT=$${2:-8501}

python -m $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli app-start --host $$HOST --port $$PORT
endef
export CLI_START_APP_CONTENT

.create-scripts:
	@echo "Creating scripts directory..."
	@mkdir -p $(TARGET_DIR)/scripts
	@echo "$$START_API_CONTENT" > $(TARGET_DIR)/scripts/start_api.sh
	@chmod +x $(TARGET_DIR)/scripts/start_api.sh
	@echo "$$START_APP_CONTENT" > $(TARGET_DIR)/scripts/start_app.sh
	@chmod +x $(TARGET_DIR)/scripts/start_app.sh
	@echo "$$CLI_START_API_CONTENT" > $(TARGET_DIR)/scripts/cli_start_api.sh
	@chmod +x $(TARGET_DIR)/scripts/cli_start_api.sh
	@echo "$$CLI_START_APP_CONTENT" > $(TARGET_DIR)/scripts/cli_start_app.sh
	@chmod +x $(TARGET_DIR)/scripts/cli_start_app.sh
	@echo "Scripts created successfully."
