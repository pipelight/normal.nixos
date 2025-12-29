{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf config.normal.network.bluetooth.enable {
    ##########################
    ## Bluetooth

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "dual"; # "bre/rd", "le", or "dual"
          FastConnectable = true;
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
      input = {
        General = {
          ClassicBondedOnly = false;
          UserspaceHID = true;
        };
      };
      network = {
        General = {
          DisableSecurity = true;
        };
      };
    };
    services.blueman = {
      enable = true;
    };

    users.groups = {
      bluetooth.members = config.normal.users;
    };

    # systemd.tmpfiles.rules = [
    #   "d /var/lib/bluetooth 700 root root - -"
    # ];
  }
