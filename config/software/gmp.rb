#
# Copyright 2014 Chef Software, Inc.
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

name "gmp"
default_version "6.1.0"

version("6.1.0")  { source md5: "86ee6e54ebfc4a90b643a65e402c4048" }

source url: "https://ftp.gnu.org/gnu/gmp/gmp-#{version}.tar.bz2"

relative_path "gmp-#{version}"

build do
  env = with_codethink_compiler_flags(ohai["platform"], with_embedded_path)

  if aix?
    env["ABI"] = "32"
  end

  configure_command = ["./configure",
                       "--prefix=#{install_dir}"]

  command configure_command.join(" "), env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
