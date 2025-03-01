-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

local stbufnr = function ()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.base46 = {
  -- Set our theme to Solarized Osaka
	theme = "solarized_osaka",
}

M.ui = {
  telescope = {
    style = "bordered"
  },
  statusline = {
    theme = "default",
    -- Inject a custom status line entry, namely the relative path of the file in the current buffer
    order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor"},
    modules = {
      relativepath = function ()
        local path = vim.api.nvim_buf_get_name(stbufnr())

        if "" == path then
          return ""
        end

        return "%#St_relativepath#  " .. vim.fn.expand("%:.:h") .. " /"
      end
    }
  }
}

return M
