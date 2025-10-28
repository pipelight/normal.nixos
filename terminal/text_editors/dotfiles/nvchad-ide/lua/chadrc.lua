-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

-- @types ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",
}

M.ui = {
  cmp = {
    icons = false,
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "file_rel_path" },
    modules = {
      -- Display active buffer filepath relative to project root.
      file_rel_path = function()
        local cwd = vim.loop.cwd()
        local path = vim.api.nvim_buf_get_name(0)
        local subpath = string.gsub(path, cwd, "")
        return "%#St_lspInfo#" .. subpath
      end,
    },
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor" },
    modules = {
      cursor = function()
        local lines = vim.fn.line "$"
        return "%#St_pos_text# " .. lines .. " l - " .. "%p %% "
      end,
    },
  },
}

M.term = {
  base46_colors = true,
}

return M
