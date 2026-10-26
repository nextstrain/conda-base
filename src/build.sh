#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir

# TreeTime v1 as treetime1, next to TreeTime v0 (`treetime`, a dependency of Augur).
# Until TreeTime v1 is released, this is the latest nightly build.
curl -fsSL -o "$PREFIX"/bin/treetime1 https://github.com/neherlab/treetime-nightly/releases/latest/download/treetime-$("$SRC_DIR"/target-triple)
chmod a+rx "$PREFIX"/bin/treetime1
