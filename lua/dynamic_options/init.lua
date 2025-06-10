-- Create our module
local M = {}

-- !!! Load everything dynamically in future!

local load_lsp_servers = function ()
  local has_lsp_servers, lsp_servers = pcall(require, "dynamic_options.lsp_servers")

  if not has_lsp_servers then
    lsp_servers = {

    }
  end

  -- Return our lsp list
  return lsp_servers
end

local load_mason_options = function ()
  local has_mason_options, mason_options = pcall(require, "dynamic_options.mason")

  -- Set our default options
  if not has_mason_options then
    mason_options = {
      has_mason = true
    }
  end

  -- Return our options
  return mason_options
end

M["mason_options"] = load_mason_options()
M["lsp_servers"] = load_lsp_servers()

return M
