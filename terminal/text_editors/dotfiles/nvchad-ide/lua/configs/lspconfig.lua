local lspconfig = require "nvchad.configs.lspconfig"
-- local on_attach = lspconfig.on_attach
local on_init = lspconfig.on_init
local capabilities = lspconfig.capabilities

-- Load nvchad lsp defaults
-- local nvlsp = require "nvchad.configs.lspconfig"
-- nvlsp.defaults()

local servers = {
  -- Lua
  "lua_ls",

  -- Nix
  "nil_ls",
  -- "rnix", main contributor has passed away (will fork)

  -- Markup
  "taplo",
  "yamlls",
  "marksman",
  "tinymist",

  -- Go
  "gopls",

  -- Python
  "pylsp",

  -- Zig
  "zls",

  --sql
  "sqls",

  -- Web / Vue
  "html",
  -- "cssls",

  -- 3D
  "openscad_lsp",

  -- C/C++
  -- "clangd",
  "ccls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    -- on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })

  vim.lsp.enable(lsp)
end

-- lspconfig.eslint.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   cmd = { "eslint" },
-- }

-- support for vue
vim.lsp.config("vue_ls", {
  cmd = { "bun", "run", "vue-language-server", "--stdio" },
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
  root_markers = { "vite.config.ts", "vitest.config.ts" },
})
vim.lsp.enable "vue_ls"

vim.lsp.config("ts_ls", {
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "bun", "run", "typescript-language-server", "--stdio" },
  init_options = {
    plugins = {
      {
        -- Before, install in bun global dir:
        -- bun install -g @vue/typescript-plugin && bun update -g
        name = "@vue/typescript-plugin",
        location = "",
        -- location = "$HOME/.bun/install/global/vue-language-server",
        languages = { "vue" },
      },
      {
        -- Before, install in bun global dir:
        -- bun install -g @vue/language-plugin-pug && bun update -g
        name = "@vue/language-plugin-pug",
        location = "",
        -- location = "$HOME/.bun/install/global/vue-language-server",
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
})
vim.lsp.enable "ts_ls"

-- Pug
-- Install pug lsp from go with: go install github.com/opa-oz/pug-lsp@latest
vim.lsp.config("pug", {
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = vim.fn.getcwd(),
})
vim.lsp.enable "pug"

vim.lsp.config("tailwindcss", {
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "pug", "css", "html", "vue", "postcss", "markdown", "svelte", "handlebars", "mustache", "jade", "htmx" },
})
vim.lsp.enable "tailwindcss"

vim.lsp.config("denols", {
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_marker = { "deno.lock", "deno.json", "mod.ts" },
})
vim.lsp.enable "denols"

-- support for rust
vim.lsp.config("rust_analyzer", {
  settings = {
    -- Autoreload cargo at start for better completion -> avoid typing ":CargoReload" every time
    -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer.rust-analyzer.workspace.discoverConfig"] = {
      ["command"] = {
        "rust-project",
        "develop-json",
      },
      ["progressLabel"] = "rust-analyzer",
      ["filesToWatch"] = {
        "BUCK",
      },
    },
  },
})
vim.lsp.enable "rust_analyzer"

-- Grammar correction
-- https://medium.com/@Erik_Krieg/free-and-open-source-grammar-correction-in-neovim-using-ltex-and-n-grams-dea9d10bc964
vim.lsp.config("ltex", {
  settings = {
    ltex = {
      language = "en-GB",
      additionalRules = {
        languageModel = "~/Documents/Ngrams/",
      },
    },
  },
})
vim.lsp.enable "ltex"

-- Diagnostic styling
-- Enable diagnostic floating window on insert mode
--
vim.diagnostic.config {
  -- float = "always",
  virtual_text = false,
  severity_sort = true,
}
-- Toggle diagnostic virtual text
local function diagnostic_floating_window()
  vim.diagnostic.open_float(nil, { focus = false })
end
vim.api.nvim_create_autocmd("CursorHoldI", { callback = diagnostic_floating_window })
