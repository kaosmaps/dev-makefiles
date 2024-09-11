# Version: 1.0.6
# Last updated: 2024-03-14

.PHONY: .create-package

.create-package:
	@echo "Creating package structure and files..."
	@mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))
	@echo "$$PKG_INIT_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/__init__.py
	@echo "$$PKG_CONFIG_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/config.py
	@echo "$$PKG_MAIN_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/main.py

define PKG_STRUCTURE
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/{__init__.py,config.py,main.py}
endef
export PKG_STRUCTURE

define PKG_INIT_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/__init__.py
from .config import settings
from .api import api_app

__all__ = ["settings", "api_app"]
endef
export PKG_INIT_CONTENT

define PKG_CONFIG_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/config.py
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
export PKG_CONFIG_CONTENT

define PKG_MAIN_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/main.py
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api import api_app
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).cli import cli
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).app import create_streamlit_app

def run_api():
    import uvicorn
    uvicorn.run(api_app, host="0.0.0.0", port=8000)

def run_cli():
    cli()

def run_app():
    create_streamlit_app()

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        if sys.argv[1] == "api":
            run_api()
        elif sys.argv[1] == "cli":
            run_cli()
        elif sys.argv[1] == "app":
            run_app()
        else:
            print("Invalid argument. Use 'api', 'cli', or 'app'.")
    else:
        print("Please specify 'api', 'cli', or 'app' as an argument.")
endef
export PKG_MAIN_CONTENT
