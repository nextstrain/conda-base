#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir

# Nextclade v3
# TODO: Remove once bioconda has nextclade3
curl -fsSL -o "$PREFIX"/bin/nextclade3 https://github.com/nextstrain/nextclade/releases/download/3.0.0/nextclade-$("$SRC_DIR"/target-triple)
chmod a+rx "$PREFIX"/bin/nextclade3

# Nextclade v2
# TODO: Remove once nextclade2 package is added to recipe.yaml
curl -fsSL -o "$PREFIX"/bin/nextclade2 https://github.com/nextstrain/nextclade/releases/download/2.14.0/nextclade-$("$SRC_DIR"/target-triple)
chmod a+rx "$PREFIX"/bin/nextclade2
