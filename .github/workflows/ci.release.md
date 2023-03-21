You can trial setting up the Conda runtime using the packages built and released **for this specific CI run**:

    NEXTSTRAIN_CONDA_CHANNEL=nextstrain/label/${LABEL} \
    NEXTSTRAIN_CONDA_BASE_PACKAGE="nextstrain-base ==${VERSION}" \
      nextstrain setup --force conda

Or, assuming you've already run `nextstrain setup conda` with a non-development package, you can also trial an update of your Conda runtime:

    NEXTSTRAIN_CONDA_CHANNEL=nextstrain/label/${LABEL} \
    NEXTSTRAIN_CONDA_BASE_PACKAGE="nextstrain-base ==${VERSION}" \
      nextstrain update conda

You should see output from Micromamba showing it fetching the index of the custom channel and then a diff of dependency additions, changes, and removals before it completes the update.

Omit the `NEXTSTRAIN_CONDA_BASE_PACKAGE` variable if you want to trial setup or update using the **latest packages built and released for this branch, PR, etc.**.
