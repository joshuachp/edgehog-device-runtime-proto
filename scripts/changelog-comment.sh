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

FROM=$1
TO=$2
PR=$3

changelog=$(git cliff -s all -- "$FROM..$TO")

if [[ -n $changelog ]]; then
    body="
    Review the changelog that will be generated.

    # Changelog

    $changelog
    "
else
    body="The commits don't specify any user facing change to add to the CHANGELOG.md."
fi

gh pr comment "$PR" --edit-last --create-if-none --body="$body"
