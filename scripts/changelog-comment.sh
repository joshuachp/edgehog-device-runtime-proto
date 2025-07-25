#!/usr/bin/env bash

set -exEuo pipefail

# Trap -e errors
trap 'echo "Exit status $? at line $LINENO from: $BASH_COMMAND"' ERR

FROM=$1
TO=$2

changelog=$(git cliff -s all -- "$FROM..$TO")

body="
Review the changelog that will be generated.

# Changelog

$changelog
"

gh pr comment --edit-last --create-if-none --body="$body"
