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
      ".config/kitty/ssh.conf".source = dotfiles/kitty/ssh.conf;
    };

    # Terminal
    programs = {
      kitty = {
        enable = true;
        extraConfig = mkMerge [
          (builtins.readFile dotfiles/kitty/kitty.conf)
          (mkIf cfg.font.enable ''
            map ctrl+j change_font_size ${toString (cfg.font.size)}
            font_size ${toString (cfg.font.size)}
          '')
        ];
        themeFile = "GitHub_Dark_Dimmed";
        # themeFile = "Doom_One";
      };
    };
  }
