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
    "nvim-tree/nvim-tree.lua",
    opts = function ()
      return require "configs.nvimtree"
    end
  },
  {
    "pocco81/auto-save.nvim",
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
        "dockerfile", "cpp", "go",
        "asm"
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
      "mfussenegger/nvim-dap",
      "nvim-neotest/neotest-go"
    },
    config = function ()
     require("neotest").setup({
        adapters = {
          -- Register our test adapters for Python and
          -- for Go
          require("neotest-python")({
            dap = {
              justMyCode = false
            }
          }),
          require("neotest-go")
        }
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    -- We can create our telescope by using the opts, and pass our
    -- custom defaults into the defaults key, which will set our telescope
    -- UI the way we want it
    opts = {
      defaults = require("configs.telescope-defaults")
    },
  },
  {
    "artemave/workspace-diagnostics.nvim",
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      -- We cannot use the plugin's LSP as it throws an Exception with every token
      -- handler!
      require("go").setup({
        -- We don't want this plugin messing up our keymaps, as it seems to
        -- hit really common ones like O, which is really silly
        dap_debug_keymap = false
      })
    end,
    event = {
      "CmdlineEnter"
    },
    ft = {
      "go",
      "gomod"
    },
    build = ":lua require('go.install').update_all_sync()"
  },
  {
    "leoluz/nvim-dap-go",
    config = function ()
      -- Manually call our setup function to register the go adapter
      -- with dap
      require("dap-go").setup()
    end,
    -- Load it all the time for now
    -- !!! We need to figure out how to only load it for Go buffers,
    -- !!! and even tests
    lazy = false
  },
  {
    "folke/trouble.nvim",
    opts = {
      warn_no_results = false,
      open_no_results = true
    },
    cmd = "Trouble"
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    -- Load Spectre all the time for now
    lazy = true
  },
  {
    "tribela/transparent.nvim"
  }
}
