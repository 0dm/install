#!/bin/bash

# Run a command and ensure it did not fail
RunAndCheck() {
    res = $($1)

    if [ $res != 0 ]; then
        echo "Failed: $2 : $res"
        exit 1
    else
        echo "Success: $2 : $res"
    fi
}

RunAndCheck "git clone https://github.com/MLDSAI/puterbot.git" "clone git repo"

cd puterbot

RunAndCheck "python -m venv .venv" "create python virtual environment"
RunAndCheck "source .venv/bin/activate" "enable python virtual environment"
RunAndCheck "pip install wheel" "pip install wheel"
RunAndCheck "pip install -r requirements.txt" "pip install -r requirements.txt"
RunAndCheck "pip install -e ." "pip install -e ."
RunAndCheck "alembic upgrade head" "alembic upgrade head"
RunAndCheck "pytest" "run puterbot tests"
