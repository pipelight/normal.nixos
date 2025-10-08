{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  cfg = config.normal;
  niri-latest = pkgs.callPackage ./niri.latest.nix {};
in
  with lib;
    mkIf cfg.wm.niri.enable {
      # Do not use following option as it maybe tweaks systemd too much
      # for our needs.

      # programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        ## Window manager
        niri-latest
        xwayland-satellite

        ## keyboard daemons
        inputs.mudras.packages.${system}.default
        # wlr-which-key

        ## Bars
        waybar
        pkgs-unstable.quickshell

        ## Night light
        # redshift
        gammastep

        wl-clipboard
        ## Keyboard utils
        via
        wev
      ];

      services.flatpak.enable = true;

      allow-unfree = [
        "via"
      ];
      services.udev.packages = with pkgs; [
        via
      ];
    }
