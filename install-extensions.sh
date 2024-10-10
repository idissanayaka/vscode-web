#!/usr/bin/env bash

export EXTENSIONS_GALLERY='{"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery"}'

EXT_LIST=/extensions
CODE_BIN=/app/code-server/bin/code-server
EXT_DIR=/app/code-server/lib/vscode/extensions

function main() {
    while read extension; do
        install_ext "$extension"
    done < "$EXT_LIST"
}


function install_ext() {
    local ext_id="$1"
    $CODE_BIN --extensions-dir "$EXT_DIR" --install-extension "$ext_id"
}

main