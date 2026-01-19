################################
## Printer and Scanner
# This module adds the bare minimum for scanner compatibility.
# Support only Epson backend but can be extended if requested.
{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
with lib;
  mkIf config.normal.office.printers.enable {
    environment.systemPackages = with pkgs; [
      ## Gnome Gui for scanners
      simple-scan
    ];
    # Allow unfree software
    allow-unfree = [
      # Epson scanner
      "iscan"
      "iscan-.*"
    ];
    ## Printers
    # Enable CUPS to handle printers
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        # following for the 3150
        epson-escpr
        #or
        epson-escpr2

        # cups-filters
        # cups-browsed
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ## Scanners
    # Enable SANE to handle scanners
    ## Temporally removed/silenced because of anoying unreachable server during update.
    hardware.sane.enable = false;
    hardware.sane.extraBackends = [pkgs.epkowa];
    # Epson support
    users.groups = let
      e = config.normal.users;
    in {
      scanner.members = e;
      lp.members = e;
      cups.members = e;
    };
  }
