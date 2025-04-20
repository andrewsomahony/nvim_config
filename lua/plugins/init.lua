return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = require("configs.ensure-installed")
      })
      require("mason-nvim-dap").setup({
        ensure_installed = {"codelldb"}
      })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
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
        "asm", "rust"
      },
    }
  },
  {
    "andrewsomahony/neotest-rust-fork",
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
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- Register our test adapters for Python and
          -- for Go
          require("neotest-python")({
            dap = {
              justMyCode = false
            }
          }),
          require("neotest-golang"),
          require("configs.rust-neotest-adapter"),
        }
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        -- We have to setup our defaults in here, as this file's dependencies
        -- are not available to lua when the opts are parsed, but are available
        -- when the config method is called
        defaults = require("configs.telescope-defaults"),
        pickers = {
          find_files = {
            hidden = true
          }
        }
      })
    end
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
    config = function()
      -- We cannot use the plugin's LSP as it throws an Exception with every token
      -- handler!
      require("go").setup({
        -- We don't want this plugin messing up our keymaps, as it seems to
        -- hit really common ones like O, which is really silly
        dap_debug_keymap = false,
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
    -- We need this Go dap adapter because xray go only loads an adapter
    -- when we debug (lazy loading), while we want to debug with neotest
    -- without having to enter in a specific command.
    "leoluz/nvim-dap-go",
    config = function()
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
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("neoclip").setup({
        -- We have to put the primary register as a default for some reason,
        -- as otherwise nvim always pastes from it, but neoclip doesn't change it
        -- with the default CR action
        default_register = {
          '"',
          '*'
        }
      })
    end,
    -- We always want this loaded, as we need our clipboard right away
    lazy = false
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        }
      }
    },
    opts = {
      extensions = {
        undo = {

        }
      }
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
    -- We always want this loaded, as we want our undo tree right away
    lazy = false
  },
  {
    "tribela/transparent.nvim"
  },
  {
    "andrewsomahony/gitdotplan.nvim",
    opts = {
      repo_to_update = "andrewsomahony/fingers.git"
    },
    lazy = false
  },
  -- THIS PLUGIN DOES NOT WORK AT ALL
 -- {
 --   "mrcjkb/rustaceanvim",
 --   version = "^6",
 --   lazy = false,
 -- },
  {
    "ray-x/navigator.lua",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig"
    },
    config = function()
      local remap = require('navigator.util').binding_remap
      require("navigator").setup({
        mason = true,
        default_mapping = false,
        lsp = {
          code_action = {
            enable = false
          },
          format_on_save = false,
          servers = {
            -- Add our assembly language server so we can get all the nice UI goodies with it :D
            -- This will call on_init and on_attach and such, and add some settings as well, which
            -- so far is working the same if not better than nvchad's lspconfig
            "asm_lsp"
          },
          asm_lsp = {
            filetypes = { "ASM", "asm", "vmasm" }
          },
          lua_ls = {
            settings = {
              Lua = {
                -- We need to put specific settings here to allow the vim global to be visible
                -- to our LSP so we don't get a million errors about it :D
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/luv/library",
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000,
                },
              },
            },
          }
        },
        keymaps = {
          { key = 'gr',         func = require('navigator.reference').async_ref,                             desc = 'async_ref' },
          { key = '<Leader>gr', func = require('navigator.reference').reference,                             desc = 'reference' }, -- reference deprecated
          { key = 'SS',         func = vim.lsp.buf.signature_help,                                           desc = 'signature_help' },
          { key = 'gs',         func = require('navigator.symbols').document_symbols,                        desc = 'document_symbols' },
          { key = 'gW',         func = require('navigator.workspace').workspace_symbol_live,                 desc = 'workspace_symbol_live' },
          { key = '<c-]>',      func = require('navigator.definition').definition,                           desc = 'definition' },
          -- For some reason, the navigator function for goto definition doesn't work well, either
          -- with Linux or C++, or both, not sure
          { key = 'gd',         func = vim.lsp.buf.definition,              desc = 'definition' },
          { key = 'gD',         func = vim.lsp.buf.declaration,                                              desc = 'declaration', },            -- fallback used
          -- for lsp handler
          { key = 'gp',         func = remap(require('navigator.definition').definition_preview, 'gp'),      desc = 'definition_preview' },      -- paste
          { key = 'gP',         func = remap(require('navigator.definition').type_definition_preview, 'gP'), desc = 'type_definition_preview' }, -- paste
          { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts,                               desc = 'buf_ts' },
          { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts,                              desc = 'bufs_ts' },
          { key = '<Leader>ct', func = require('navigator.ctags').ctags,                                     desc = 'ctags' },
          { key = '<Space>ca',  func = require('navigator.codeAction').code_action,                          desc = 'code_action',                       mode = { 'n', 'v' } },
          -- { key = '<Leader>re', func = 'rename()' },
          { key = '<Space>rn',  func = require('navigator.rename').rename,                                   desc = 'rename' },
          { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls,                                           desc = 'incoming_calls' },
          { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls,                                           desc = 'outgoing_calls' },
          { key = 'gi',         func = vim.lsp.buf.implementation,                                           desc = 'implementation' }, -- insert
          { key = '<Space>D',   func = vim.lsp.buf.type_definition,                                          desc = 'type_definition' },
          { key = 'gL',         func = require('navigator.diagnostics').show_diagnostics,                    desc = 'show_diagnostics' },
          { key = 'gG',         func = require('navigator.diagnostics').show_buf_diagnostics,                desc = 'show_buf_diagnostics' },
          { key = '<Leader>dt', func = require('navigator.diagnostics').toggle_diagnostics,                  desc = 'toggle_diagnostics' },
          { key = ']d',         func = require('navigator.diagnostics').goto_next,                           desc = 'next diagnostics error or fallback' },
          { key = '[d',         func = require('navigator.diagnostics').goto_prev,                           desc = 'prev diagnostics error or fallback' },
          { key = ']O',         func = vim.diagnostic.set_loclist,                                           desc = 'diagnostics set loclist' },
          { key = ']r',         func = require('navigator.treesitter').goto_next_usage,                      desc = 'goto_next_usage' },
          { key = '[r',         func = require('navigator.treesitter').goto_previous_usage,                  desc = 'goto_previous_usage' },
          { key = '<Leader>k',  func = require('navigator.dochighlight').hi_symbol,                          desc = 'hi_symbol' },
          { key = '<Space>wa',  func = require('navigator.workspace').add_workspace_folder,                  desc = 'add_workspace_folder' },
          { key = '<Space>wr',  func = require('navigator.workspace').remove_workspace_folder,               desc = 'remove_workspace_folder' },
          { key = '<Space>gm',  func = require('navigator.formatting').range_format,                         mode = 'n',                                 desc = 'range format operator e.g gmip' },
          { key = '<Space>wl',  func = require('navigator.workspace').list_workspace_folders,                desc = 'list_workspace_folders' },
          { key = '<Space>la',  func = require('navigator.codelens').run_action,                             desc = 'run code lens action',              mode = 'n' }
        }
      })
    end,
    lazy = false
  }
}
