if vim.g.neovide then
  -- Title
  vim.opt.title = true

  local cwd = vim.fn.getcwd()
  vim.opt.titlestring = [[%{v:progname} ]] .. cwd

  -- Colors
  vim.opt.termguicolors = true

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
