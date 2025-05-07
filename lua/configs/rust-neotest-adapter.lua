-- Find out where to look for the pretty printer Python module.
local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
-- If we could not execute the rustc command, fail silently
if 0 ~= vim.v.shell_error then
  print("Failed to get rust sysroot")
  return
end

-- Assemble our script file path using our rustc sysroot
local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
-- Assemble our commands file path using our rustc sysroot
local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

-- Require our neotest adapter and pass in our initCommands
local rust_neotest_adapter = require("neotest-rust")({
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

-- Return our modified adapter
return rust_neotest_adapter;
