{
  config,
  cfg,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf (config.normal.editors.neovim.enable
    || config.normal.editors.nvchad.enable
    || config.normal.editors.nvchad-ide.enable)
  {
    ##########################
    ## Multi keyboad layout support for neovim and vim
    ## Not working for now because I don't have much time to maintain it.

    # home.sessionVariables = {
    #   NVIM_APPNAME = with lib;
    #     mkMerge [
    #       (mkIf (cfg.keyboard.layout == "colemak-dh") "nvim")
    #       (mkIf (cfg.keyboard.layout == "colemak-dh") "nvchad-colemak-dh")
    #       (mkIf (cfg.keyboard.layout == "azerty") "nvchad-azerty")
    #       (mkIf (cfg.keyboard.layout == "qwerty") "nvchad-qwerty")
    #     ];
    # };

    home.sessionVariables = with lib; {
      NVIM_APPNAME =
        if config.normal.editors.nvchad-ide.enable
        then "nvchad-ide"
        else if config.normal.editors.nvchad.enable
        then "nvchad"
        else if config.normal.editors.neovim.enable
        then "nvim"
        else "nvim";

      EDITOR = mkMerge [
        (mkIf (config.normal.editors.nvchad-ide.enable) "nvim -u ~/.config/nvchad/init.lua")
        (mkIf (config.normal.editors.nvchad.enable) "nvim -u ~/.config/nvchad/init.lua")
        (mkDefault "nvim")
      ];
      MANPAGER = mkMerge [
        (mkIf (config.normal.editors.nvchad-ide.enable) "nvim -u ~/.config/nvchad/init.lua -c 'Man!' -o -")
        (mkIf (config.normal.editors.nvchad.enable) "nvim -u ~/.config/nvchad/init.lua -c 'Man!' -o -")
        (mkDefault "nvim +Man!")
      ];
    };

    home.file = {
      # Terminal multiplexer
      ".config/zellij".source = dotfiles/zellij;

      # Vim colemak conf
      ".vimrc".source = dotfiles/.vimrc;

      # NvChadIde
      ".config/nvchad-ide/lua".source = dotfiles/nvchad-ide/lua;
      ".config/nvchad-ide/init.lua".source = dotfiles/nvchad-ide/init.lua;
      # NvChad
      ".config/nvchad/lua".source = dotfiles/nvchad/lua;
      ".config/nvchad/init.lua".source = dotfiles/nvchad/init.lua;
      # Neovim
      ".config/nvim/lua".source = dotfiles/nvim/lua;
      ".config/nvim/init.lua".source = dotfiles/nvim/init.lua;
      # Less
      ".lesskey".source = dotfiles/.lesskey;

      # Lock plugin versions
      # :Lazy sync on first boot
      # ".config/nvim/lazy-lock.json".source = dotfiles/nvchad/lazy-lock.json;
    };

    programs.neovide = {
      enable = true;
      settings = {
        frame = "full";
        fork = true;
        maximized = false;
        vsync = true;
        wls = false;
        srgb = false;
        font = let
          cfg = config.normal;
        in {
          normal = [
            "JetBrainsMono Nerd Font Mono"
            "NotoSansM Nerd Font Mono"
            "Noto Sans Mono CJK JP"
            "Noto Color Emoji"
          ];
          size =
            if cfg.font.enable
            then (cfg.font.size - 0.2)
            else 10.8;
        };
      };
    };

    home.packages = with pkgs;
    with lib;
      mkMerge [
        #############################
        [
          ## Terminal multiplexers
          # tmux
          # zellij
        ]
        #############################
        ## Neovim lsp/formaters
        (mkIf (config.normal.editors.neovim.enable) [neovim])
        (mkIf (config.normal.editors.nvchad.enable)
          [
            neovim
            ## Lsp lint/formatting tools
            tree-sitter
          ])
        (
          mkIf (config.normal.editors.nvchad-ide.enable)
          [
            treefmt2
            git-cliff

            neovim

            ## Lsp lint/formatting tools
            tree-sitter

            # Grammar
            ltex-ls
            # Lua
            lua-language-server
            stylua
            # Nix
            nil
            statix
            alejandra
            # Toml and friends
            taplo
            # Yaml
            yaml-language-server
            yamllint
            stylelint
            # Hcl
            hclfmt
            # Kdl
            kdlfmt
            # Markdown
            marksman
            # Go
            gopls
            golangci-lint
            # Python
            python3Packages.python-lsp-server
            ruff
            black
            # Zig
            zls
            # Sql
            sqls

            ##############################
            # Web
            prettierd
            # nodePackages.prettier
            # nodePackages.typescript
            typescript
            # nodePackages.typescript-language-server
            typescript-language-server

            # nodePackages.eslint
            eslint
            nodePackages.jsonlint

            vue-language-server
          ]
        )
      ];
  }
