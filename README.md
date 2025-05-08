# Conda package for nextstrain-base

![CI](https://github.com/nextstrain/conda-base/actions/workflows/ci.yaml/badge.svg)
[![Anaconda-Server Badge](https://anaconda.org/nextstrain/nextstrain-base/badges/latest_release_relative_date.svg)](https://anaconda.org/nextstrain/nextstrain-base)
[![Anaconda-Server Badge](https://anaconda.org/nextstrain/nextstrain-base/badges/downloads.svg)](https://anaconda.org/nextstrain/nextstrain-base)

This is the source for creating the `nextstrain-base` Conda package.

This meta-package depends on all the other packages needed for a base
Nextstrain runtime installed as a Conda environment.  As the nextstrain/base
image is to Nextstrain CLI's Docker runtime, this nextstrain-base package is to
Nextstrain CLI's Conda runtime.  The package's dependencies which completely
lock its full transitive dependency tree.  This means that if version _X_ of
nextstrain-base worked some way in the past, it'll work the same way in the
future.

Note that this is not a general purpose package for installing Nextstrain.
It's intended for use by Nextstrain CLI's managed Conda runtime and may be
unsuitable for use in a user-managed Conda environment.


## How it works

The meta-package source recipe is in `src/recipe.yaml`.  This is a
[rattler-build recipe spec][].  It defines our runtime's direct dependencies,
typically without version restrictions (pins) or with only loose pinning as
necessary.

A two-pass build process is used to produce the final package.

In the first pass, the source recipe is built into a package in `build/src/`.
This package _does not_ lock its dependency tree.  Crucially, however, such a
tree is still resolved during the build and recorded as package metadata.

In the second pass, the recorded locked dependency tree is extracted from the
first pass and substituted into the source recipe to produce the locked recipe,
`locked/recipe.yaml`.  The locked recipe is then built into a package in
`build/locked/`.  This final package now _does_ fully lock its dependency tree.

As the fully locked dependency trees are platform-specific, [CI][] produces
packages for both Linux and macOS (i.e. for Conda's `linux-64` and `osx-64`
subdirs).

[rattler-build recipe spec]: https://rattler.build/latest/reference/recipe_file/


## Developing

_You can build this package locally during development, but it's important for
production releases to happen via CI so packages are built for both Linux and
macOS._

First, setup a Conda environment for development in `.dev-env/` so that
[rattler-build](https://rattler.build) is available.

    ./devel/setup

You only need to do this once, or whenever you want to refresh your development
environment.  Either [Micromamba][], [Mamba][], or [Conda][] must be available
for setup to succeed. You do not need to create a new environment yourself,
the script automatically sets everything up without interfering with your
existing environments.

[Micromamba]: https://mamba.readthedocs.io/page/user_guide/micromamba.html
[Mamba]: https://mamba.readthedocs.io
[Conda]: https://docs.conda.io/projects/conda/

### Building

To build this package locally, run:

    ./devel/build

The final built package will be written to
`build/locked/<arch>/nextstrain-base-*.conda`, where `<arch>` is a Conda
subdir, i.e. `linux-64`, `osx-64` or `osx-arm64`.

[CI][] builds store the entire `build/` and `locked/` directories as an
artifact attached to each CI run.  You can download the artifacts to inspect
the built packages or install them.

[CI]: https://github.com/nextstrain/conda-base/actions/workflows/ci.yaml

### Installing

To install the built package into a new environment, run:

    mamba create                              \
      --prefix /path/to/new/env               \
      --strict-channel-priority               \
      --override-channels                     \
      --channel conda-forge                   \
      --channel bioconda                      \
      --channel ./build/locked                \
      nextstrain-base

### Uploading

To upload the built package to anaconda.org, run:

    ./devel/upload

You'll need an appropriate Anaconda API token set in the `ANACONDA_TOKEN`
environment variable.  The token must have at least the `api:read`,
`api:write`, and `conda` scopes attached to it.  CI uses a token issued for the
[Nextstrain Anaconda organization](https://anaconda.org/Nextstrain/settings/access).

You can adjust the label applied to the uploaded package by setting the `LABEL`
environment variable.  By default the Git ref is used to determine the label:

- Uploads from our `main` branch are given the `main` label.  These packages
  will be found by default for anyone using our Anaconda channel (e.g.
  `--channel nextstrain`).

- Uploads from other branches, tags, and PRs will get `branch-<name>`,
  `tag-<name>`, and `pull-<number>` labels.  These packages can be used by
  asking for them explicitly (e.g. `--channel nextstrain/label/pull-123`).

If no label can be worked out, then `dev` is used as a final fallback.

[CI][] uploads the built package if it passes the test phase.  You can use the
above labels to install CI-uploaded packages locally without downloading the CI
artifacts.


### Repository layout

`src/` contains the package recipe source.  Any files in this directory will be
automatically included in the built package.  (`recipe.yaml` doesn't live in
the top-level of the repo, and thus `src/` exists, to avoid including the whole
repo in each built package.)

`locked/` contains the package recipe source after requirements locking.  It is
overwritten on each build and not tracked in version control.

`build/` contains build outputs not tracked in version control.

`devel/` contains programs for development of this package.


## History

- [Initial suggestion of the meta-package][1] on the Nextstrain CLI PR
  introducing the Conda runtime.

- [Further discussion about the meta-package][2] on Slack, motivated by the
  Conda runtime [breaking between one day and the next][3] due to upstream
  changes.

[1]: https://github.com/nextstrain/cli/pull/218#issuecomment-1269082344
[2]: https://bedfordlab.slack.com/archives/C01LCTT7JNN/p1665599068266849
[3]: https://bedfordlab.slack.com/archives/C01LCTT7JNN/p1665594330478279
