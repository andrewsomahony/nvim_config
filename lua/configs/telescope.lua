return require('telescope.themes').get_ivy({
  border = {
    prompt = { 1, 1, 1, 1 },
    results = { 1, 1, 1, 1 },
    preview = { 1, 1, 1, 1 }
  },
  borderchars = {
    { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
    results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
  },
  layout_config = {
    height = 20
  },
  -- Set our prompt prefix to a caret
  prompt_prefix = " > ",
  -- Set our selection caret to a caret
  selection_caret = " > ",
  -- Set our entry prefix to be the same length as the selection, as
  -- to avoid shifting of the filename as we scroll
  entry_prefix = "   ",
  preview = {
    hide_on_startup = true
  },
  previewer = false,
  prompt_title = false
})

