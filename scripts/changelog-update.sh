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

# Remove everything until the first tag
sed '/^## \[[0-9]\+/,$!d' -i CHANGELOG.md

# prepend the unreleased changes
if [[ -n ${GITHUB_REPO:-} ]]; then
    git cliff --github-repo="$GITHUB_REPO" --unreleased --prepend CHANGELOG.md
else
    git cliff --unreleased --prepend CHANGELOG.md
fi
