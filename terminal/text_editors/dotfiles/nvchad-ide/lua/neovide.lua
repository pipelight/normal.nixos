if vim.g.neovide then
  -- Title
  vim.opt.title = true

  local cwd = vim.fn.getcwd()
  vim.opt.titlestring = [[%{v:progname} ]] .. cwd

  -- Colors
  vim.opt.termguicolors = true

  -- bug fix: Explicitely pass terminal colors.
  -- Doomchad
  -- black
  vim.g.terminal_color_0 = "#4e525a"
  vim.g.terminal_color_8 = "#5a5e66"
  -- red
  vim.g.terminal_color_1 = "#ff6c6b"
  vim.g.terminal_color_9 = "#ff6b5a"
  -- green
  vim.g.terminal_color_2 = "#98be65"
  vim.g.terminal_color_10 = "#a9cf76"
  -- yellow
  vim.g.terminal_color_3 = "#ecbe7b"
  vim.g.terminal_color_11 = "#f2c481"
  -- blue
  vim.g.terminal_color_4 = "#48a6e6"
  vim.g.terminal_color_12 = "#66c4ff"
  -- magenta
  vim.g.terminal_color_5 = "#c678dd"
  vim.g.terminal_color_13 = "#dc8ef3"
  -- cyan
  vim.g.terminal_color_6 = "#46d9ff"
  vim.g.terminal_color_14 = "#56d4dd"
  -- white
  vim.g.terminal_color_7 = "#a7aebb"
  vim.g.terminal_color_15 = "#bbc2cf"

  -- Fonts
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10.8"

  -- Padding
  vim.g.neovide_padding_top = 2
  vim.g.neovide_padding_bottom = 2
  vim.g.neovide_padding_right = 2
  vim.g.neovide_padding_left = 4

  -- Border rounded
  vim.g.neovide_floating_corner_radius = 4.0

  -- Shadow
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 4
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 4

  --Blur
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Refresh rate
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_short_animation_length = 0.02
  vim.g.neovide_cursor_trail_size = 0.8
end
