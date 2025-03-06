-- My own custom mappings, mostly for my UI work

local set_keymap = vim.api.nvim_set_keymap

-- Trouble keymaps
set_keymap(
  "n",
  "<leader>ts",
  "<cmd>Trouble symbols toggle focus=false<cr>",
  {
    noremap = true,
  }
)

set_keymap(
  "n",
  "<leader>tr",
  "<cmd>Trouble lsp_references toggle focus=false<cr>",
  {
    noremap = true
  }
)

set_keymap(
  "n",
  "<leader>te",
  "<cmd>Trouble diagnostics toggle focus=false<cr>",
  {
    noremap = true,
  }
)

-- Neotest keymaps

-- Toggle the unit tests window
set_keymap(
  "n",
  "<leader>tw",
  "<cmd>lua require('neotest').summary.toggle()<cr>",
  {
    noremap = true
  }
)
-- Run the marked tests in the unit tests window
set_keymap(
  "n",
  "<leader>tm",
  "<cmd>lua require('neotest').summary.run_marked()<cr>",
  {
    noremap = true
  }
)
-- Run the current test highlighted
set_keymap(
  "n",
  "<leader>tt",
  "<cmd>lua require('neotest').run.run()<cr>",
  {
    noremap = true
  }
)
-- Debug the current test
set_keymap(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').run.run({strategy='dap'})<cr>",
  {
    noremap = true
  }
)
