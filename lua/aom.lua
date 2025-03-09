-- My own custom mappings, mostly for my UI work

local set_keymap = vim.api.nvim_set_keymap

-- Telescope mappings

set_keymap(
  "n",
  "<Leader>fr",
  ":lua require('telescope.builtin').lsp_references()<CR>",
  {
    noremap = true,
    silent = true,
    desc = "View references of the symbol under the cursor"
  }
)

set_keymap(
  "n",
  "<Leader>fp",
  ":lua require('telescope.builtin').resume()<CR>",
  {
    noremap = true,
    silent = true,
    desc = "View previous search"
  }
)

-- When we want to toggle diagnostics for the entire workspace, to see all
-- messages from all files
set_keymap(
  "n",
  "<leader>cc",
  "",
  {
  	noremap = true,
    silent = true,
  	callback = function()
  		for _,client in ipairs(vim.lsp.get_clients()) do
  			require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
  		end
  	end
  }
)

-- Trouble keymaps
set_keymap(
  "n",
  "<leader>ts",
  "<cmd>Trouble symbols toggle focus=false<cr>",
  {
    noremap = true,
    silent = true,
  }
)

set_keymap(
  "n",
  "<leader>tr",
  "<cmd>Trouble lsp_references toggle focus=false<cr>",
  {
    noremap = true,
    silent = true,
  }
)

set_keymap(
  "n",
  "<leader>te",
  "<cmd>Trouble diagnostics toggle focus=false<cr>",
  {
    noremap = true,
    silent = true,
  }
)

-- Neotest keymaps

-- Toggle the unit tests window
set_keymap(
  "n",
  "<leader>tw",
  "<cmd>lua require('neotest').summary.toggle()<cr>",
  {
    noremap = true,
    silent = true,
  }
)
-- Run the marked tests in the unit tests window
set_keymap(
  "n",
  "<leader>tm",
  "<cmd>lua require('neotest').summary.run_marked()<cr>",
  {
    noremap = true,
    silent = true,
  }
)
-- Run the current test highlighted
set_keymap(
  "n",
  "<leader>tt",
  "<cmd>lua require('neotest').run.run()<cr>",
  {
    noremap = true,
    silent = true,
  }
)
-- Debug the current test
set_keymap(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').run.run({strategy='dap'})<cr>",
  {
    noremap = true,
    silent = true
  }
)

-- Spectre keymaps

set_keymap(
  "n",
  "<leader>ss",
  "<cmd>lua require('spectre').toggle()<cr>",
  {
    desc = "Toggle Spectre Window"
  }
)

set_keymap(
  "n",
  "<leader>sw",
  "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
  {
    desc = "Spectre search current word"
  }
)

set_keymap(
  "v",
  "<leader>sw",
  "<cmd>lua require('spectre').open_visual()<cr>",
  {
    desc = "Spectre search current highlighted word"
  }
)

set_keymap(
  "n",
  "<leader>sp",
  "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
  {
    desc = "Spectre search current file"
  }
)

