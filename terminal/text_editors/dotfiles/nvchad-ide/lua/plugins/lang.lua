return {
  {
    "R-nvim/R.nvim",
    lazy = false,
    config = function()
      require("r").setup {
        auto_quit = true,
        auto_start = "always",
        pdfviewer = "evince",
        user_maps_only = true,
        hook = {
          on_filetype = function()
            -- vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>rh", "<Plug>RHelp", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<leader>rh", "<Plug>RHelp", {})
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>tt", "<Plug>RSendFile", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<leader>tt", "<Plug>RSendFile", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end,
        },
      }
    end,
  },
  -- Config files
  {
    "nfnty/vim-nftables",
    lazy = false,
  },
  {
    "jvirtanen/vim-hcl",
    lazy = true,
  },
  {
    "isobit/vim-caddyfile",
    lazy = true,
  },
  {
    "elkowar/yuck.vim",
    lazy = true,
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      local dbee = require "dbee"
      dbee.install()
    end,
    config = function()
      require "configs.dbee"
    end,
    lazy = true,
  },
  -------------------------------
  -- Markdown viewer
  {
    "OXY2DEV/markview.nvim",
    lazy = true, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    -------------------------------
    -- CSV viewer
    {
      "hat0uma/csvview.nvim",
      lazy = true,
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
  },
}
