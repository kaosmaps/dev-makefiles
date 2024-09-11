# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-core

.create-module-core:
	@echo "Creating core structure and files..."
	@CORE_PATH=$(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/$(if $(SAUBER_DOMAIN),$(SAUBER_DOMAIN)/)core; \
	mkdir -p $$CORE_PATH; \
	touch $$CORE_PATH/{__init__.py,demo.py,config.py}; \
	echo "$$CORE_INIT_CONTENT" > $$CORE_PATH/__init__.py; \
	echo "$$CORE_DEMO_CONTENT" > $$CORE_PATH/demo.py; \
	echo "$$CORE_CONFIG_CONTENT" > $$CORE_PATH/config.py

define CORE_INIT_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/$(if $(SAUBER_DOMAIN),$(SAUBER_DOMAIN)/)core/__init__.py
from .demo import demo_function
from .config import settings

__all__ = ['demo_function', 'settings']
endef
export CORE_INIT_CONTENT

define CORE_DEMO_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/$(if $(SAUBER_DOMAIN),$(SAUBER_DOMAIN)/)core/demo.py
def demo_function():
    return 'Hello from $(SAUBER_PACKAGE_NAME) core!'
endef
export CORE_DEMO_CONTENT

define CORE_CONFIG_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/$(if $(SAUBER_DOMAIN),$(SAUBER_DOMAIN)/)core/config.py
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    PROJECT_NAME: str = "$(SAUBER_PACKAGE_NAME)"
    API_HOST: str = "0.0.0.0"
    API_PORT: int = 8000
    APP_HOST: str = "0.0.0.0"
    APP_PORT: int = 8501

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

settings = Settings()
endef
export CORE_CONFIG_CONTENT
