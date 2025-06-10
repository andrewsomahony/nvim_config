local return_value = {}

-- Load our Mason options
local mason_options = require("dynamic_options").mason_options

if true == mason_options.has_mason then
  table.insert(
    return_value,
    {
      "jay-babu/mason-nvim-dap.nvim"
    }
  )
  table.insert(
    return_value,
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          -- THIS IS KEY AS THIS FEATURE DOES NOT WORK WITH RAYX-NAVIGATOR AT THIS TIME
          automatic_enable = false,
          ensure_installed = require("configs.ensure-installed")
        })
        require("mason-nvim-dap").setup({
          ensure_installed = {"codelldb"}
        })
      end
    }
  )
else
  print("No Mason")
end

return return_value
