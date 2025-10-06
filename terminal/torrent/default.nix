{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.normal;
in
  with lib;
    mkIf cfg.terminal.torrent.enable {
      ################################
      ### Torrent
      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
      };
    }
