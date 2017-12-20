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

name "llvm"
default_version "5.0.0"

source :url => "http://releases.llvm.org/#{version}/llvm-#{version}.src.tar.xz",
       :md5 => "5ce9c5ad55243347ea0fdb4c16754be0"

relative_path "llvm-#{version}.src"

dependency 'gcc'
dependency 'cmake'
dependency 'python'

llvm_build_dir = "#{build_dir}/build-llvm"

build do
  env = with_llvm_compiler_flags(with_embedded_path)
  mkdir llvm_build_dir

  command "cmake" \
    " -DCMAKE_C_COMPILER=#{install_dir}/bin/gcc" \
    " -DCMAKE_CXX_COMPILER=#{install_dir}/bin/g++" \
    " -DCMAKE_INSTALL_PREFIX=#{install_dir}" \
    " -DPYTHON_EXECUTABLE=#{install_dir}/embedded/bin/python" \
    " #{project_dir}", env: env, cwd: llvm_build_dir
  
  make "-j #{workers}", env: env, cwd: llvm_build_dir, timeout: 28800
  make "-j #{workers} install", env: env, cwd: llvm_build_dir
end
