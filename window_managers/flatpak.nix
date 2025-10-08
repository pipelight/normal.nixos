{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf (config.normal.wm.gnome.enable || config.normal.wm.niri.enable) {
    services.flatpak.enable = true;

    home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  }
