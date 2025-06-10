-- Load our Mason options
local dynamic_options = require("dynamic_options")

return {
    "andrewsomahony/rayx-navigator-fork",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig"
    },
    config = function()
      local remap = require('navigator.util').binding_remap
      require("navigator").setup({
        mason = dynamic_options.mason_options.has_mason,
        default_mapping = false,
        lsp = {
          code_action = {
            enable = false
          },
          format_on_save = false,
          servers = dynamic_options.lsp_servers,
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
