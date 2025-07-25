#!/usr/bin/env bash

# This file is part of Edgehog.
#
# Copyright 2025 SECO Mind Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

set -exEuo pipefail

# Trap -e errors
trap 'echo "Exit status $? at line $LINENO from: $BASH_COMMAND"' ERR

TAG=$1

latest_tag=$(
    git tag --list |
        sort --version-sort |
        tail -n 1
)

if [[ $latest_tag == "$TAG" ]]; then
    latest="true"
else
    latest="false"
fi

if [[ -n ${GITHUB_REPO:-} ]]; then
    changelog=$(git cliff --strip all ---unreleased --tag="$TAG" --github-repo="$GITHUB_REPO")
else
    changelog=$(git cliff --strip all --unreleased --tag="$TAG")
fi

notes="### CHANGELOG

$changelog
"

gh release create "$TAG" \
    --verify-tag --fail-on-no-commits \
    --notes="$notes" --latest="$latest"
