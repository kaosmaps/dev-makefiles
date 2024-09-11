# src/dev_makefiles/main.py
from dev_makefiles.api import api_app
from dev_makefiles.cli import cli
from dev_makefiles.app import create_streamlit_app

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
