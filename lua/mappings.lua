require "nvchad.mappings"
require "aom"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Workspace diagnostics

vim.api.nvim_set_keymap("n", "<leader>cc", "", {
	noremap = true,
	callback = function()
		for _,client in ipairs(vim.lsp.get_clients()) do
			require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
		end
	end
})

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
        map("i", "{}", "{}<Left><CR><CR><Up><C-f>", {noremap = true})
      end

      -- When we open and close a parenthesis, automatically move the cursor within it;
      -- for if blocks, while loops, etc
      map("i", "()", "()<Left>", {noremap = true})

      -- Python doesn't use semicolons, so we don't need to add one for our parenthesis hotkey
      if vim.bo.filetype == "python" then
        map("i", "((", "()<Left><CR><CR><Up><C-f>")
      else
        -- When we type two parenthesis, we are dealing with a function of some kind.
        -- so automatically move the cursor within the 2 parens and format for tabs and such
        -- We also append a semicolon as we are most likely working with a function call
        map("i", "((", "();<Left><Left><CR><CR><Up><C-f>")
      end
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

      -- Pytest mappings
      map("n", "pt", ":Pytest project<CR>")
      map("n", "ps", ":Pytest session<CR><C-W>j")
      map("n", "pf", ":Pytest file<CR>")
      map("n", "pm", ":Pytest method<CR>")

      -- Python debug mappings
      map("n", "<C-b>", ":lua require('dap').toggle_breakpoint()<CR>")
      map("n", "dm", ":lua require('dap-python').test_method()<CR>")
      map("n", "dc", ":lua require('dap').continue()<CR>")
    end)
  end
})

-- Telescope mappings

map("n", "<Leader>fr", ":lua require('telescope.builtin').lsp_references()<CR>", {
  noremap = true,
  silent = true,
  desc = "View references of the symbol under the cursor"
})

map(
  "n",
  "<Leader>fp",
  ":lua require('telescope.builtin').resume()<CR>",
  {
    noremap = true,
    silent = true,
    desc = "View previous search"
  }
)
