#!/bin/bash

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
    [[ -z "$QS_REPO" ]] && die "QS_REPO not defined."
    git ls-remote "$QS_REPO" &>/dev/null \
        || die "Invalid or Inaccessible repository: '$QS_REPO'"
}


clone_repo() {
    git clone \
        --single-branch \
        --branch "$BRANCH" \
        "$QS_REPO" \
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
