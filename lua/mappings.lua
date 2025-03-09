require "nvchad.mappings"
require "aom"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Special keybindings for our git commit buffers, so we can quickly add our
-- bullet points
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = "gitcommit",
    callback = function ()
      -- Create a map for making a bullet point on the same line, mostly to start a commit
      map("n", "oo", "i*<Space>")
      -- Create a map for making a new bullet point, as that's how I like to write git commits 
      map("n", "ooo", "o<CR><Esc>0I*<Space>")
    end
  }
)

-- C-style brackets and parenthesis hotkeys for insert mode
-- We can share some of these with Python, with the notable exception of
-- any that use semicolons

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype ~= "python" then
        -- When we open and close a bracket, automatically move the cursor within it
        -- and format for tabs and such; Python doesn't use brackets, so we don't need
        -- this one for Python at all
        map("i", "{}}", "{}<Left><CR><CR><Up><C-f>", {noremap = true})
      end

      map("n", "<C-b>", ":lua require('dap').toggle_breakpoint()<CR>")
      map("n", "dc", ":lua require('dap').continue()<CR>")

      -- When we open and close a parenthesis, automatically move the cursor within it;
      -- for if blocks, while loops, etc
      map("i", "()", "()<Left>", {noremap = true})

      -- When we type a second closing parenthesis, automatically CR and jump to the center
      -- of the parenthesis pair
      map("i", "())", "()<Left><CR><CR><Up><C-f>")
    end)
  end
})

-- Python-specific mappings

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"py", "python"},
  callback = function()
    vim.schedule(function()
      -- Simple mapping to create a Python block and be within it quickly
      map("i", "::", ":<CR><C-f>")

    end)
  end
})

