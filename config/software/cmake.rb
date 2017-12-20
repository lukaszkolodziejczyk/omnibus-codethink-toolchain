# Omnibus::Software definition to build the GNU Compiler Collection.
# Copyright 2017 Codethink Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "cmake"

default_version "3.10.1"

source :url => "https://cmake.org/files/v3.10/cmake-3.10.1.tar.gz",
       :md5 => "9a726e5ec69618b172aa4b06d18c3998"

dependency "gcc"

whitelist_file "bin/ccmake"
relative_path "cmake-#{version}"

build do
  env = with_llvm_compiler_flags(with_embedded_path)
  command "./bootstrap --prefix=#{install_dir}/embedded --parallel=#{workers}", env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
