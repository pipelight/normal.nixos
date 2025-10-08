{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.wm.gnome.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "fish.desktop"
          "lutris.desktop"
          "nautilus.desktop"
        ];
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };
    };
  }
