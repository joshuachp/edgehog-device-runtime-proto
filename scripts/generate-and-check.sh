#!/usr/bin/env bash

set -exEuo pipefail

make

if ! git diff --quiet; then
    git diff
    exit 1
fi
