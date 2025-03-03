-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig

local M = {}

local stbufnr = function ()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local theme_to_use = "solarized_osaka"

M.base46 = {
  -- Set our theme to Solarized Osaka
	theme = theme_to_use,
  hl_add = {
    -- We have to use our colors manually, as at the time this file is loaded,
    -- we won't necessarily have the base46 themes available
    St_relativepath = { bg = "#03394F", fg = "#9eabac" },
  },
  hl_override = {
    --St_file_sep = {bg = "#03394F"}
  }
}

M.ui = {
  telescope = {
    style = "bordered"
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    -- Inject a custom status line entry, namely the relative path of the file in the current buffer
    order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor"},
    modules = {
      relativepath = function ()
        local path = vim.api.nvim_buf_get_name(stbufnr())

        if "" == path then
          return ""
        end

        -- Create our relative path using Vim substitution
        relative_path = vim.fn.expand("%:.:h") .. "/"
        -- Put spaces between our path separators to make it look cleaner
        relative_path = relative_path:gsub("/", " / ")

        -- Slice off the trailing space of our relative path
        return "%#St_relativepath#  " .. string.sub(relative_path, 1, -2)
      end
    }
  }
}

return M
