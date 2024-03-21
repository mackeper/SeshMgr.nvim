#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cd "$SCRIPT_DIR/.."
nvim -u "$SCRIPT_DIR/minimal_init.vim" --headless --noplugin -c ':lua require("plenary")' -c 'PlenaryBustedDirectory lua/tests'
