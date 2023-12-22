#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir

# Nextclade v3
curl -fsSL -o "$PREFIX"/bin/nextclade3 https://github.com/nextstrain/nextclade/releases/download/3.0.0-alpha.1/nextclade-$("$SRC_DIR"/target-triple)
chmod a+rx "$PREFIX"/bin/nextclade3
