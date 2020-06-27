#!/usr/bin/env bash

## Generate compile database file

COMPILE_DB="compiledb"

if [ -z "`which ${COMPILE_DB}`" ]; then
    pip install ${COMPILE_DB}
fi

${COMPILE_DB} make
