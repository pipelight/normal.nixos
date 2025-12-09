{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  cfg = config.normal;
in
  with lib;
    mkIf cfg.wm.niri.enable {
      # Do not use following option as it maybe tweaks systemd too much
      # for our needs.
      # programs.niri.enable = true;

      environment.systemPackages = with pkgs; let
        system = stdenv.hostPlatform.system;
      in [
        ## Window manager
        pkgs-unstable.niri
        xwayland-satellite

        ## keyboard daemons
        inputs.mudras.packages.${system}.default
        # wlr-which-key

        ## Bars
        waybar

        ## Night light
        # redshift
        gammastep

        wl-clipboard
        ## Keyboard utils
        via
        wev
      ];

      allow-unfree = [
        "via"
      ];
      services.udev.packages = with pkgs; [
        via
      ];
    }
