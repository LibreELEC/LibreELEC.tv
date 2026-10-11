#!/bin/sh

# Sample usage:
#     export LD_LIBRARY_PATH="$(libatomic.sh):${LD_LIBRARY_PATH}"

DIR_BIN=$(cd "$(dirname "$0")" && pwd)
echo "${DIR_BIN}/../libs"

