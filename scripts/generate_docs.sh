#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cd "$SCRIPT_DIR/.."
nvim -u NORC --headless --noplugin -c ':lua require("mini.doc").generate(nil, "doc/SeshMgr.txt", nil)' -c 'q'
