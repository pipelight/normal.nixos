{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.wm.niri.enable {
    home.file = {
      # Keyboard
      ".config/mudras/config.kdl".source = dotfiles/mudras/config.kdl;

      # App launcher
      ".config/yofi".source = dotfiles/yofi;

      # Window Manager (niri)
      ".config/niri/config.kdl".source = dotfiles/niri/config.kdl;
      ".config/niri/main.kdl".source = dotfiles/niri/main.kdl;
      ".config/niri/manageable.kdl".source = dotfiles/niri/manageable.kdl;

      # Bars
      ".config/waybar/main.jsonc".source = dotfiles/waybar/main.jsonc;
      ".config/waybar/workspaces.jsonc".source = dotfiles/waybar/workspaces.jsonc;
      ".config/waybar/metrics.jsonc".source = dotfiles/waybar/metrics.jsonc;
      ".config/waybar/style.css".source = dotfiles/waybar/style.css;

      # Notifications
      ".config/dunst/dunstrc".source = dotfiles/dunstrc;
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
  }
