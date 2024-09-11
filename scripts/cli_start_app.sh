#!/bin/bash

HOST=${1:-"0.0.0.0"}
PORT=${2:-8501}

python -m dev_makefiles.cli app-start --host $HOST --port $PORT
