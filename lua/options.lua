require "nvchad.options"

vim.o.nu = true
vim.o.relativenumber = true
vim.o.statuscolumn = "%s %l  "
vim.o.numberwidth = 8

-- !!! TODO: Change the shell if desired

-- Set this to nil to have NVIM load the python3 provider
vim.g.loaded_python3_provider = nil

-- Add the "fully uppercase ASM" as a filetype, as some old assembly language code
-- files are named this way, and nvim does not have an extension entry for the
-- fully uppercase extension
vim.filetype.add({
  extension = {
    ASM = "asm"
  }
})
