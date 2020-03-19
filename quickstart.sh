#!/bin/bash

# URL of repository to be installed from
# Either set QS_REPO environment variable or hardcode the URL here manually
REPO=${QS_REPO}

# Branch to clone from
BRANCH=${QS_GIT_BRANCH:-master}

# Temp working space
TMPDIR=$(mktemp -d)


# FUNCTIONS
cleanup() {
    rm -rf "$TMPDIR"
}


die() {
    echo "Error: ${*}" >&2
    cleanup
    exit 2
}


check_git() {
    which git || die "Can't find 'git'. Is 'git' installed and on your path?"
}


validate_repo() {
    [[ -z "$REPO" ]] && die "REPO is not set in quickstart file."
    git ls-remote "$REPO" &>/dev/null \
        || die "Invalid or Inaccessible repository: '$REPO'"
}


clone_repo() {
    git clone \
        --single-branch \
        --branch "$BRANCH" \
        https://github.com/ncsa/xcat-tools.git \
        $TMPDIR
}

run_setup() {
    local _setup=$TMPDIR/setup.sh
    if [[ -f "$_setup" ]] ; then
        $TMPDIR/setup.sh
    else
        || die "Setup script not found: '$_setup'"
    fi
}

check_git

validate_repo

clone_repo

run_setup

cleanup
