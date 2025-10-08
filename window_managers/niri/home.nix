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
      ".config/wlr-which-key/config.yaml".source = dotfiles/wlr-which-key/config.yaml;
      # App launcher
      ".config/yofi".source = dotfiles/yofi;

      # Notifications
      ".config/dunst/dunstrc".source = dotfiles/dunstrc;

      # ".config/niri/config.kdl".source = dotfiles/niri/config.kdl;
      # ".config/niri/main.kdl".source = dotfiles/niri/main.kdl;
      # ".config/niri/manageable.kdl".source = dotfiles/niri/manageable.kdl;
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
