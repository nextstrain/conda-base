#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir
