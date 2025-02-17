return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "pocco81/auto-save.nvim",
    lazy = false
  },
  {
    "alfredodeza/pytest.vim",
    lazy = false
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require "configs.dap-python"
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = {
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require "configs.dapui"
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python",
        "dockerfile", "cpp"
      },
    }
  },
}
