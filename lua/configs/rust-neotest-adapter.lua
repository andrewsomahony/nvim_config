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

-- Require our neotest adapter
local rust_neotest_adapter = require("neotest-rust")

-- Add our init commands to our Neotest Rust CodeLLDB adapter, 
-- which will execute when codelldb is executed
rust_neotest_adapter.addCodeLLDBInitCommand("command script import '" .. script_file .. "'")
rust_neotest_adapter.addCodeLLDBInitCommand("command source '" .. commands_file .."'")

-- Return our modified adapter
return rust_neotest_adapter;
