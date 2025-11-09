{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.wm.niri.enable {
    home.file = let
      screen = config.normal.wm.niri.screen;
    in
      {
        # Keyboard
        ".config/mudras/config.kdl".source = dotfiles/mudras/config.kdl;

        # App launcher
        ".config/yofi".source = dotfiles/yofi;

        # Window Manager (niri)
        ".config/niri/config.kdl".source = dotfiles/niri/config.kdl;
        ".config/niri/main.kdl".source = dotfiles/niri/main.kdl;
        ".config/niri/manageable.kdl".source = dotfiles/niri/manageable.kdl;

        # Notifications
        ".config/dunst/dunstrc".source = dotfiles/dunstrc;
      }
      // {
        # Bars
        ".config/waybar/main.jsonc".source = dotfiles/waybar/${screen}/main.jsonc;
        ".config/waybar/workspaces.jsonc".source = dotfiles/waybar/${screen}/workspaces.jsonc;
        ".config/waybar/metrics.jsonc".source = dotfiles/waybar/${screen}/metrics.jsonc;
        ".config/waybar/style.css".source = dotfiles/waybar/${screen}/style.css;
      };

    home.packages = with pkgs; let
      image_to_grayscale = pkgs.writeShellScriptBin "image_to_grayscale" ''
        convert $1 -colorspace gray $1.gray.jpeg
      '';
    in [
      # Yofi and dependencies
      inputs.yofi.packages.${system}.default

      # Font support
      libnotify
      fontconfig

      # Wallpapers
      swww
      image_to_grayscale

      # notifications
      dunst
    ];

    # Remove gtk window buttons
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "";
        };
      };
    };
  }
