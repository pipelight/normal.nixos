{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  cfg = config.crocuda;
  niri-latest = pkgs.callPackage ./niri.latest.nix {};
in
  with lib;
    mkIf cfg.wm.niri.enable {
      # Do not use following option as it tweaks systemd.
      # programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        # niri
        niri-latest
        xwayland-satellite

        # keyboard daemon
        inputs.mudras.packages.${system}.default

        # Bars
        waybar
        pkgs-unstable.quickshell

        # wlr-which-key
        # Waiting for newest than 1.1.0
        # inputs.wlr-which-key.packages.${system}.default
      ];

      users.groups = {
        inputs.members = cfg.users;
      };
    }
