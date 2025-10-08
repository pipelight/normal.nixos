{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.torrent.enable {
    ################################
    ### Torrent
    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
    };
  }
