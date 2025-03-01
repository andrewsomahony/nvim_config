-- My own custom mappings, mostly for my UI work

local set_keymap = vim.api.nvim_set_keymap

set_keymap(
  "n",
  "<leader>aom",
  "<cmd>Trouble lsp_references toggle focus=false<cr><cmd>Trouble diagnostics toggle focus=false<cr><cmd>Trouble symbols toggle focus=false<cr>",
  {
    noremap = true,
  }
)
