-- Create our module
local M = {}

local load_dynamic_options = function (name)
  return pcall(require, "dynamic_options." .. name)
end
-- !!! Load everything dynamically in future!

local load_rust_analyzer = function ()
  local has_options, options = load_dynamic_options("rust_analyzer")

  if not has_options then
    options = {}
  end

  -- Return our rust analyzer options
  return options
end

local load_lsp_servers = function ()
  local has_options, options = load_dynamic_options("lsp_servers")

  if not has_options then
    options = {}
  end

  -- Return our lsp list
  return options
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

local load_treesitter_options = function ()
  local has_treesitter_options, treesitter_options = pcall(require)
end

M["mason_options"] = load_mason_options()
M["lsp_servers"] = load_lsp_servers()
M["rust_analyzer"] = load_rust_analyzer()

return M
