#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# Install augur from git branch
pip install git+https://github.com/nextstrain/augur.git@victorlin/subsample

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir
