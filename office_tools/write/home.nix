{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.office.write.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  }
