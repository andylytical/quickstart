#!/bin/bash

# Allow QS_REPO and QS_GIT_REPO
if [[ -n "${QS_GIT_REPO}" ]] ; then
  REPO="${QS_GIT_REPO%%/tree/*}"
  BRANCH="${QS_GIT_REPO##*/tree/}"
else
  REPO="${QS_REPO%%/tree/*}"
  BRANCH="${QS_REPO##*/tree/}"
fi

# Branch to clone from
if [[ -n "${QS_GIT_BRANCH}" ]] ; then
  BRANCH="${QS_GIT_BRANCH}"
elif [[ -n "${QS_BRANCH}" ]] ; then
  BRANCH="${QS_BRANCH}"
fi
[[ -z "${BRANCH}" ]] && BRANCH=main

echo "REPO : '${REPO}'"
echo "BRANCH : '${BRANCH}'"
exit 1

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
  [[ -z "$REPO" ]] && die "QS_GIT_REPO not defined."
  git ls-remote "$REPO" &>/dev/null \
  || die "Invalid or Inaccessible repository: '$REPO'"
}


validate_branch() {
  [[ $DEBUG -gt 0 ]] && set -x
  [[ -z "$BRANCH" ]] && die "QS_GIT_BRANCH not defined."
  local _is_valid=no
  if is_remote_branch_valid "$BRANCH" ; then
    _is_valid=yes
  else
    if [[ "$BRANCH" == "main" ]] ; then
      # try for master branch (instead of main)
      if is_remote_branch_valid "master" ; then
        BRANCH="master"
        _is_valid=yes
      fi
    fi
  fi
  if [[ "$_is_valid" == "no" ]] ; then
    die "Invalid branch: '$BRANCH'"
  fi
}


is_remote_branch_valid() {
  [[ $DEBUG -gt 0 ]] && set -x
  local _branch="$1"
  [[ -z "$_branch" ]] && die "Refusing to test empty branch name"
  git ls-remote --heads "$REPO" "$_branch" 2>/dev/null \
  | head -1 \
  | grep -q "refs/heads/$_branch"
}


clone_repo() {
  [[ $DEBUG -gt 0 ]] && set -x
  git clone \
    --single-branch \
    --branch "$BRANCH" \
    "$REPO" \
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
validate_branch

clone_repo

run_setup

cleanup
