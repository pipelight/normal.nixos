{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.emulators.kitty.enable {
    home.file = {
      ".config/kitty/themes/github_dark_dimmed.conf".source = dotfiles/kitty/github_dark_dimmed.conf;
      ".config/kitty/themes/doom_chad.conf".source = dotfiles/kitty/doom_chad.conf;
    };
    # Terminal
    programs = {
      kitty = {
        enable = true;
        extraConfig = mkMerge [
          (builtins.readFile dotfiles/kitty/kitty.conf)
          (mkIf config.normal.font.enable ''
            map ctrl+j change_font_size ${toString (cfg.font.size)}
            font_size ${toString (cfg.font.size)}
          '')
        ];
      };
    };
  }
