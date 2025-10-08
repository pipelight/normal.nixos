##########################
## Gaming suite
# Emulators
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf config.normal.office.gaming.enable {
    home.packages = with pkgs; [
      lutris
      bottles
    ];
  }
