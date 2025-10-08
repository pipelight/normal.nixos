{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf config.normal.office.gaming.enable {
    allow-unfree = [
      "steam.*"
    ];
  }
