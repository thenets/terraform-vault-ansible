#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_DIR=${DIR}/../.env

set -o allexport

# Load all envs
source ${ENV_DIR}/config/*.env
source ${ENV_DIR}/python_env/bin/activate

# Add binaries to the PATH
export PATH=${PATH}:${ENV_DIR}/bin

# Style for bash
export PS1='\e[96m(DevOps)\e[39m \[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$ '

set +o allexport
