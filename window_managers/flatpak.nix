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

    xdg.portal = {
      enable = true;
      config.common.default = "*";
      # enable = lib.mkForce false;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  }
