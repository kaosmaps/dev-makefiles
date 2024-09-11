#!/bin/bash

HOST=${1:-"0.0.0.0"}
PORT=${2:-8000}

python -m dev_makefiles.cli api-start --host $HOST --port $PORT
