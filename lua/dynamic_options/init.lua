local M = {}

M.load_mason_options = function ()
  local has_mason_options, mason_options = pcall(require, "dynamic_options.mason")

  if not has_mason_options then
    mason_options = {
      has_mason = true
    }
  end

  return mason_options
end

return M
