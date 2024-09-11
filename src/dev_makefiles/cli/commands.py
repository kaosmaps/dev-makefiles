# src/dev_makefiles/cli/commands.py
import click
import uvicorn
import subprocess
import sys
from rich.console import Console
from rich.panel import Panel
from dev_makefiles.core.config import settings

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
        title="dev-makefiles API",
        border_style="green"
    ))
    uvicorn.run("dev_makefiles.api:api_app", host=host, port=port, reload=True)

@cli.command()
@click.option("--host", default=settings.APP_HOST, help="Host to bind the Streamlit app")
@click.option("--port", default=settings.APP_PORT, type=int, help="Port to bind the Streamlit app")
def app_start(host, port):
    console.print(Panel.fit(
        f"Starting Streamlit app on [bold cyan]{host}:{port}[/bold cyan]",
        title="dev-makefiles App",
        border_style="blue"
    ))
    subprocess.run([
        sys.executable, "-m", "streamlit", "run",
        "src/dev_makefiles/app/main.py",
        "--server.address", host,
        "--server.port", str(port)
    ])

if __name__ == "__main__":
    cli()
