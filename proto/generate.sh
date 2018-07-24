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

THISDIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

find -E $THISDIR/openconfig -regex ".*\.(pb\.go|proto)" -exec rm {} \;

(cd $THISDIR && git clone --depth 1 https://github.com/openconfig/public)

mkdir $THISDIR/yang
(
cd $THISDIR
curl -o yang/ietf-inet-types.yang \
  https://raw.githubusercontent.com/YangModels/yang/master/standard/ietf/RFC/ietf-inet-types%402013-07-15.yang
curl -o yang/ietf-interfaces.yang \
  https://raw.githubusercontent.com/YangModels/yang/master/standard/ietf/RFC/ietf-interfaces%402014-05-08.yang
curl -o yang/ietf-yang-types.yang \
  https://raw.githubusercontent.com/YangModels/yang/master/standard/ietf/RFC/ietf-yang-types%402013-07-15.yang
curl -o yang/iana-if-type.yang \
  https://raw.githubusercontent.com/YangModels/yang/master/standard/ietf/RFC/iana-if-type%402017-01-19.yang

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
  public/release/models/system/openconfig-system.yang \
  ../yang/openconfig-hercules-platform-linecard.yang \
  ../yang/openconfig-hercules-qos.yang \
  ../yang/openconfig-hercules-platform.yang \
  ../yang/openconfig-hercules-platform-chassis.yang \
  ../yang/openconfig-hercules-platform-port.yang \
  ../yang/openconfig-hercules.yang \
  ../yang/openconfig-hercules-interfaces.yang \
  ../yang/openconfig-hercules-platform-node.yang
rm -rf public yang
find . -type d -mindepth 1 | while read l; do (cd $l && go generate); done;
)


