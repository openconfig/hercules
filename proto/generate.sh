#!/bin/bash

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script rebuilds the protobufs from the Hercules YANG modules
# and the latest OpenConfig public models.
#
# Author: Rob Shakir (robjs@google.com)

rm -rf openconfig
git clone --depth 1 https://github.com/openconfig/public
git clone --depth 1 https://github.com/YangModels/yang
go run $GOPATH/src/github.com/openconfig/ygot/proto_generator/protogenerator.go \
  -generate_fakeroot \
  -base_import_path="github.com/openconfig/hercules/proto" \
  -path=public,yang \
  -output_dir=. \
  -package_name=openconfig \
  -exclude_modules=ietf-interfaces \
  public/release/models/interfaces/openconfig-interfaces.yang \
  public/release/models/interfaces/openconfig-if-ip.yang \
  public/release/models/lacp/openconfig-lacp.yang \
  public/release/models/platform/openconfig-platform.yang \
  public/release/models/platform/openconfig-platform-linecard.yang \
  public/release/models/platform/openconfig-platform-port.yang \
  public/release/models/platform/openconfig-platform-transceiver.yang \
  public/release/models/vlan/openconfig-vlan.yang \
  ../yang/openconfig-hercules-platform-linecard.yang \
  ../yang/openconfig-hercules-qos.yang \
  ../yang/openconfig-hercules-platform.yang \
  ../yang/openconfig-hercules-platform-chassis.yang \
  ../yang/openconfig-hercules-platform-port.yang \
  ../yang/openconfig-hercules.yang \
  ../yang/openconfig-hercules-interfaces.yang \
  ../yang/openconfig-hercules-platform-node.yang
rm -rf public yang
