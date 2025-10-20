{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.emulators.kitty.enable {
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
        themeFile = "GitHub_Dark_Dimmed";
        # themeFile = "Doom_One";
      };
    };
  }
