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
  hl_add = {
    -- We have to find the colors from our theme to use here, as we cannot
    -- load the theme and grab the colors directly.  I suppose we could include
    -- it directly though as the base46 plugin is doing, and extract the values
    -- straight from its exported objects?
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
