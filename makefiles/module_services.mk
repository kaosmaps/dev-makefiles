# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-services

define SERVICES_STRUCTURE
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/{__init__.py,main_service.py}
endef
export SERVICES_STRUCTURE

.create-module-services:
	@echo "Creating services structure and files..."
	@$(SERVICES_STRUCTURE)
	@echo "$$SERVICES_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/__init__.py
	@echo "$$SERVICES_MAIN_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/main_service.py

define SERVICES_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/__init__.py
from .main_service import MainService

__all__ = ['MainService']
endef
export SERVICES_CONTENT

define SERVICES_MAIN_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/services/main_service.py
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core import demo_function

class MainService:
    def main_function(self):
        return f'Service says: {demo_function()}'
endef
export SERVICES_MAIN_CONTENT
