local rust_neotest_adapter = require("neotest-rust")

-- Find out where to look for the pretty printer Python module.
local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')

-- If we were able to find our Rustc root, then we can proceed to configure our
-- adapter with the specific commands

if 0 == vim.v.shell_error then
  -- Assemble our script file path using our rustc sysroot
  local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
  -- Assemble our commands file path using our rustc sysroot
  local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

  -- Configure our adapter by calling its __call metatable entry
  rust_neotest_adapter({
    args = {
      -- We can use our plugin's metatable to pass in arguments that will be
      -- used by the plugin; in this case, we want to import our LLDB lookup
      -- script as well as source our commands file for use by code_lldb
      initCommands = {
          "command script import '" .. script_file .. "'",
          "command source '" .. commands_file .."'"
        }
    }
  })
end

-- Return our modified adapter
return rust_neotest_adapter;
