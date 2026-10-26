#!/usr/bin/env bash
set -euo pipefail -x
mkdir -p "$PREFIX"/bin

# envdir
cp -v "$SRC_DIR"/envdir "$PREFIX"/bin/envdir

# TreeTime v1 as treetime1, next to TreeTime v0 (`treetime`, a dependency of Augur).
# Releases are nightly builds until TreeTime v1 is released; the checksums come
# from the SHA256SUMS file of the pinned release.
TREETIME1_VERSION="1.0.0-nightly.20261026T130313Z+8513a64"
target="$("$SRC_DIR"/target-triple)"
case "$target" in
    x86_64-unknown-linux-gnu)
        treetime1_sha256=786ff42ef8f7ad8a854e3c5e280b2d63b98a28cb5565a86977a11de7c31f483a;;
    x86_64-apple-darwin)
        treetime1_sha256=88b8da9955099a1d1eaec68752e11cfeef1297af0fde18e6d2c903202c4410bc;;
    aarch64-apple-darwin)
        treetime1_sha256=6e2fcc78458984f351b4604a079d2711f41ef979697a8c473e9efd9fb00c8da6;;
    *)
        echo "no TreeTime v1 checksum for $target" >&2
        exit 1;;
esac
curl -fsSL -o "$PREFIX"/bin/treetime1 "https://github.com/neherlab/treetime-nightly/releases/download/$TREETIME1_VERSION/treetime-$target"
echo "$treetime1_sha256  $PREFIX/bin/treetime1" | sha256sum --check --strict
chmod a+rx "$PREFIX"/bin/treetime1
