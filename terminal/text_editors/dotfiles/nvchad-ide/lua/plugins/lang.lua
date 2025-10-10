return {
  {
    "R-nvim/R.nvim",
    lazy = false,
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
  },
}
