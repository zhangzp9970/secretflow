#! /bin/bash
#
# Copyright 2023 Ant Group Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

echo "1. Update component spec doc."
# comp_spec.tmpl is adapted from https://github.com/pseudomuto/protoc-gen-doc/blob/master/examples/templates/grpc-md.tmpl.
docker run --rm -v $(pwd)/component/:/out \
                -v $(pwd)/../:/protos \
                pseudomuto/protoc-gen-doc \
                --doc_opt=/out/comp_spec.tmpl,comp_spec.md \
                protos/secretflow/protos/component/cluster.proto \
                protos/secretflow/protos/component/data.proto \
                protos/secretflow/protos/component/comp.proto \
                protos/secretflow/protos/component/evaluation.proto \
                protos/secretflow/protos/component/report.proto
echo "2. Update comp list doc."

env PYTHONPATH=$PYTHONPATH:$PWD/.. python $PWD/component/update_comp_list.py