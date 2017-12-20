# This contains overrides for the "standard" compiler flags built into Omnibus.
#
# To make it available to all software definitions, it's imported from the
# project definition using `require_relative`.
#
# The standard Omnibus flags maybe here:
#   https://github.com/chef/omnibus/blob/master/lib/omnibus/software.rb#L653

def with_codethink_compiler_flags(platform, env = {}, opts = {})
  env = with_standard_compiler_flags(env = env, opts = opts)

  compiler_flags =
    {
      "LDFLAGS" => "-Wl,-rpath,#{install_dir}/lib -L#{install_dir}/lib",
      "CFLAGS" => "-I#{install_dir}/include -O2",
    }

  return env.merge(compiler_flags).
    merge("CXXFLAGS" => compiler_flags["CFLAGS"]).
    merge("CPPFLAGS" => compiler_flags["CFLAGS"])
end

def with_llvm_compiler_flags(env = {}, opts = {})
  env = with_standard_compiler_flags(env = env, opts = opts)
  
  return env.
    merge("LD_LIBRARY_PATH" => "#{install_dir}/lib;#{install_dir}/lib64;#{install_dir}/libexec;#{install_dir}/embedded/lib")
end
