return {
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        anchor = "NE",
        width = 40,
        height = vim.o.lines - 10,
        row = 2,
        col = vim.o.columns - 40
      }
    }
  },
  filters = {
    dotfiles = true
  }
};
