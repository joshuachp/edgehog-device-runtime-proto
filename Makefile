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


.PHONY: all rust

all: rust

rust:
	cargo run --manifest-path ./rust/Cargo.toml -p codegen -- -p ./proto -o ./output
	cp -v output/edgehog.deviceruntime.containers.v1.rs rust/edgehog-device-runtime-proto/src/


.PHONY: clean

clean:
	test -f ./output && rm -rf ./output
