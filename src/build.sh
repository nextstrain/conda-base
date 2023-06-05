#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir
