#!/bin/bash

# Branch to clone from
BRANCH=${QS_GIT_BRANCH:-master}

# Temp working space
TMPDIR=$(mktemp -d)

DEBUG=1

# FUNCTIONS
cleanup() {
    [[ $DEBUG -gt 0 ]] && set -x
    rm -rf "$TMPDIR"
}


die() {
    echo "Error: ${*}" >&2
    cleanup
    exit 2
}


check_git() {
    [[ $DEBUG -gt 0 ]] && set -x
    which git || die "Can't find 'git'. Is 'git' installed and on your path?"
}


validate_repo() {
    [[ $DEBUG -gt 0 ]] && set -x
    [[ -z "$QS_REPO" ]] && die "QS_REPO not defined."
    git ls-remote "$QS_REPO" &>/dev/null \
        || die "Invalid or Inaccessible repository: '$QS_REPO'"
}


clone_repo() {
    [[ $DEBUG -gt 0 ]] && set -x
    git clone \
        --single-branch \
        --branch "$BRANCH" \
        "$QS_REPO" \
        $TMPDIR
}

run_setup() {
    [[ $DEBUG -gt 0 ]] && set -x
    local _setup=$TMPDIR/setup.sh
    [[ -f "$_setup" ]] || die "Setup script not found: '$_setup'"
    "$_setup"
}

[[ $DEBUG -gt 0 ]] && set -x

check_git

validate_repo

clone_repo

run_setup

cleanup
