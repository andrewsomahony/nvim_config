local dap = require("dap")

local M = {}

M.setup = function ()
  -- Find out where to look for the pretty printer Python module.
  local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
  assert(
    vim.v.shell_error == 0,
    'failed to get rust sysroot using `rustc --print sysroot`: '
      .. rustc_sysroot
  )
    print(rustc_sysroot)
  local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
  local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

  local command1 = '!command script import "' .. script_file .. '"'
  local command2 = "command source '" .. commands_file .. "'"

  -- vim.cmd ([[command source '%s']]):format(commands_file)

  dap.adapters.codelldb = function (callback, client_config)
    -- !!! NEED TO MAKE THIS MORE FLUID AND ALSO COMPATIBLE FOR LINUX
    local has_mason, mason_registry = pcall(require, 'mason-registry')
    local codelldb_package = mason_registry.get_package('codelldb')
    local mason_codelldb_path

    if require('mason.version').MAJOR_VERSION > 1 then
      mason_codelldb_path = vim.fs.joinpath(vim.fn.expand('$MASON'), 'packages', codelldb_package.name, 'extension')
    else
      mason_codelldb_path = vim.fs.joinpath(codelldb_package:get_install_path(), 'extension')
    end

    local codelldb_path = vim.fs.joinpath(mason_codelldb_path, "adapter", "codelldb")
    local liblldb_path = vim.fs.joinpath(mason_codelldb_path, "lldb", "lib", "liblldb")

    liblldb_path = liblldb_path .. ".dylib" --(shell.is_macos() and '.dylib' or '.so')

    callback(
      {
        type = "server",
        port = "27631",
        host = "127.0.0.1",
        executable = {
          command = codelldb_path,
          args = {"--liblldb", liblldb_path, "--port", "27631"}
        }
      }
    )
  end
end

return M
