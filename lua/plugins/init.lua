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
--  {
--    "alfredodeza/pytest.vim",
--    lazy = false
--  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require "configs.dap-python"
    end
  },
--  {
--    "rcarriga/nvim-dap-ui",
--    lazy = false,
--    dependencies = {
--      "nvim-neotest/nvim-nio"
--    },
--    config = function()
--      require "configs.dapui"
--    end
--  },
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
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "mfussenegger/nvim-dap-python",
      "mfussenegger/nvim-dap"
    },
    config = function ()
     require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = {
              justMyCode = false
            }
          })
        }
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        preview = {
          hide_on_startup = true
        }
      }
    },
  },
  {
    "artemave/workspace-diagnostics.nvim",
  },
  {
    "folke/trouble.nvim",
    opts = {
      warn_no_results = false,
      open_no_results = true
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        ":Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)"
      },
      {
        "<leader>cs",
        ":Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)"
      },
      {
        "<leader>cl",
        ":Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)"
      }
    }
  }
}
