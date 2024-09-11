# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-cli

define CLI_STRUCTURE
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/{__init__.py,commands.py,__main__.py}
endef
export CLI_STRUCTURE

.create-module-cli:
	@echo "Creating CLI structure and files..."
	@$(CLI_STRUCTURE)
	@echo "$$CLI_INIT_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/__init__.py
	@echo "$$CLI_MAIN_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/__main__.py
	@echo "$$CLI_COMMANDS_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/commands.py

define CLI_INIT_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/__init__.py
from .commands import cli

__all__ = ['cli']
endef
export CLI_INIT_CONTENT

define CLI_MAIN_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/__main__.py
from .commands import cli

if __name__ == "__main__":
    cli()
endef
export CLI_MAIN_CONTENT

define CLI_COMMANDS_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/cli/commands.py
import click
import uvicorn
import subprocess
import sys
from rich.console import Console
from rich.panel import Panel
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core.config import settings

console = Console()

@click.group()
def cli():
    pass

@cli.command()
@click.option("--host", default=settings.API_HOST, help="Host to bind the API server")
@click.option("--port", default=settings.API_PORT, type=int, help="Port to bind the API server")
def api_start(host, port):
    console.print(Panel.fit(
        f"Starting API server on [bold cyan]{host}:{port}[/bold cyan]",
        title="$(SAUBER_PACKAGE_NAME) API",
        border_style="green"
    ))
    uvicorn.run("$(subst -,_,$(SAUBER_PACKAGE_NAME)).api:api_app", host=host, port=port, reload=True)

@cli.command()
@click.option("--host", default=settings.APP_HOST, help="Host to bind the Streamlit app")
@click.option("--port", default=settings.APP_PORT, type=int, help="Port to bind the Streamlit app")
def app_start(host, port):
    console.print(Panel.fit(
        f"Starting Streamlit app on [bold cyan]{host}:{port}[/bold cyan]",
        title="$(SAUBER_PACKAGE_NAME) App",
        border_style="blue"
    ))
    subprocess.run([
        sys.executable, "-m", "streamlit", "run",
        "src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/main.py",
        "--server.address", host,
        "--server.port", str(port)
    ])

if __name__ == "__main__":
    cli()
endef
export CLI_COMMANDS_CONTENT
